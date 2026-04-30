#!/usr/bin/env python3
"""
Islamic content source importer.

Respects robots.txt, rate limits, and copyright requirements.
Full-text import is ONLY performed when copyright_status == "allowed".
By default only metadata (title, URL, description, category) is saved.

Usage examples
--------------
# List available sources
python tools/import_sources.py --list-sources

# Save metadata record for a dua page
python tools/import_sources.py --source duas_org \
    --url "https://www.duas.org/kumail.htm" --type dua --title "Dua Kumail"

# Rebuild the imported-content index
python tools/import_sources.py --generate-index

Copyright rule
--------------
These websites are treated as *reference pointers* only.
Full content must NOT be copied unless:
  1. The site's Terms of Service or licence explicitly permits redistribution, OR
  2. You hold written permission from the copyright holder.
Store such confirmation in the record under "permissionNote".
"""

import argparse
import json
import re
import time
import urllib.request
import urllib.robotparser
import uuid
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
IMPORTED_DIR = ROOT / "assets" / "json" / "imported"

# ---------------------------------------------------------------------------
# Source registry
# ---------------------------------------------------------------------------
SOURCES: dict[str, dict] = {
    "duas_org": {
        "id": "duas_org",
        "title": "Duas.org",
        "base_url": "https://www.duas.org/",
        "robots_url": "https://www.duas.org/robots.txt",
        "copyright_note": (
            "Duas.org is maintained by volunteers. Check the site's terms before "
            "redistributing content. Store only metadata unless reuse is confirmed."
        ),
    },
    "al_islam": {
        "id": "al_islam",
        "title": "Al-Islam.org",
        "base_url": "https://www.al-islam.org/",
        "robots_url": "https://www.al-islam.org/robots.txt",
        "copyright_note": (
            "Al-Islam.org hosts works under various licences (Creative Commons, "
            "publisher-specific). Check each book/article page individually before "
            "importing full text."
        ),
    },
}

CONTENT_TYPES = ["dua", "ziyarat", "book", "article", "event", "amaal", "biography"]
RATE_LIMIT_SEC = 3.0  # polite delay between HTTP requests
USER_AGENT = "HidayatApp/1.0 (metadata-only collector; contact: app-admin)"


# ---------------------------------------------------------------------------
# Robots checker
# ---------------------------------------------------------------------------
class RobotChecker:
    def __init__(self, robots_url: str) -> None:
        self._rp = urllib.robotparser.RobotFileParser()
        self._rp.set_url(robots_url)
        self._ok = False
        try:
            self._rp.read()
            self._ok = True
        except Exception as exc:
            print(f"[warn] Could not read robots.txt ({robots_url}): {exc}")

    def can_fetch(self, url: str) -> bool:
        if not self._ok:
            # If we can't read robots.txt, be conservative and block.
            return False
        return self._rp.can_fetch(USER_AGENT, url)


# ---------------------------------------------------------------------------
# HTTP helpers
# ---------------------------------------------------------------------------
def _fetch(url: str) -> str:
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=20) as resp:
        charset = resp.headers.get_content_charset("utf-8")
        return resp.read().decode(charset, errors="replace")


def fetch_with_robots_check(source_id: str, url: str) -> tuple[bool, str]:
    """Return (allowed, html). Applies robots.txt check + rate limit."""
    src = SOURCES.get(source_id)
    if src is None:
        print(f"[error] Unknown source: {source_id}")
        return False, ""
    checker = RobotChecker(src["robots_url"])
    if not checker.can_fetch(url):
        print(f"[robots] Fetch disallowed: {url}")
        return False, ""
    time.sleep(RATE_LIMIT_SEC)
    try:
        return True, _fetch(url)
    except Exception as exc:
        print(f"[error] Fetch failed ({url}): {exc}")
        return False, ""


# ---------------------------------------------------------------------------
# Metadata extraction from raw HTML
# ---------------------------------------------------------------------------
def _strip_tags(html: str) -> str:
    return re.sub(r"<[^>]+>", " ", html)


def _extract_meta(html: str, attr_name: str, attr_key: str = "content") -> str:
    pattern = (
        rf'<meta[^>]+name=["\']?{re.escape(attr_name)}["\']?'
        rf'[^>]+{re.escape(attr_key)}=["\']([^"\']+)["\']'
    )
    m = re.search(pattern, html, re.IGNORECASE)
    if m:
        return m.group(1).strip()
    # Also try reversed attribute order
    pattern2 = (
        rf'<meta[^>]+{re.escape(attr_key)}=["\']([^"\']+)["\']'
        rf'[^>]+name=["\']?{re.escape(attr_name)}["\']?'
    )
    m2 = re.search(pattern2, html, re.IGNORECASE)
    return m2.group(1).strip() if m2 else ""


def extract_metadata(html: str) -> dict:
    """Pull title + description from page HTML without storing body text."""
    title_m = re.search(r"<title[^>]*>([^<]+)</title>", html, re.IGNORECASE)
    title = re.sub(r"\s+", " ", title_m.group(1)).strip() if title_m else ""
    description = _extract_meta(html, "description") or _extract_meta(html, "Description")
    author = _extract_meta(html, "author") or _extract_meta(html, "Author")
    return {"title": title, "description": description, "author": author}


# ---------------------------------------------------------------------------
# Record construction
# ---------------------------------------------------------------------------
def _now() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


def _slug(text: str) -> str:
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")[:60]


def make_record(
    source_id: str,
    content_type: str,
    title: str,
    source_url: str,
    description: str = "",
    author: str = "",
    language: str = "",
    copyright_status: str = "metadata_only",
    permission_note: str = "",
) -> dict:
    now = _now()
    return {
        "id": uuid.uuid4().hex[:10],
        "sourceId": source_id,
        "sourceTitle": SOURCES.get(source_id, {}).get("title", source_id),
        "sourceUrl": source_url,
        "contentType": content_type,
        "title": title,
        "slug": _slug(title or source_url),
        "category": "",
        "language": language,
        "author": author,
        "translator": "",
        "reference": source_url,
        "copyrightStatus": copyright_status,
        "permissionNote": permission_note,
        "description": description,
        # Full content only populated when copyright_status == "allowed"
        "content": [],
        "audioFiles": [],
        "tags": [],
        "status": "draft",
        "createdAt": now,
        "updatedAt": now,
    }


# ---------------------------------------------------------------------------
# Disk helpers
# ---------------------------------------------------------------------------
def save_record(record: dict, output_dir: Path) -> Path:
    output_dir.mkdir(parents=True, exist_ok=True)
    name = f"{record['id']}_{record['slug']}.json"
    path = output_dir / name
    path.write_text(json.dumps(record, ensure_ascii=False, indent=2), encoding="utf-8")
    return path


def generate_index(imported_dir: Path) -> None:
    """Rebuild index.json from all *.json files in imported_dir."""
    items = []
    for f in sorted(imported_dir.glob("*.json")):
        if f.name == "index.json":
            continue
        try:
            data = json.loads(f.read_text(encoding="utf-8"))
            items.append(
                {
                    "id": data.get("id"),
                    "title": data.get("title"),
                    "contentType": data.get("contentType"),
                    "sourceTitle": data.get("sourceTitle"),
                    "sourceUrl": data.get("sourceUrl"),
                    "copyrightStatus": data.get("copyrightStatus"),
                    "status": data.get("status"),
                    "file": f.name,
                    "createdAt": data.get("createdAt"),
                }
            )
        except Exception as exc:
            print(f"[warn] Skipping {f.name}: {exc}")

    index = {
        "version": "1.0.0",
        "updatedAt": _now(),
        "totalItems": len(items),
        "items": items,
    }
    out = imported_dir / "index.json"
    out.write_text(json.dumps(index, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Index written: {out}  ({len(items)} items)")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
def main() -> None:
    parser = argparse.ArgumentParser(
        description="Import Islamic content metadata from reference sources.",
        epilog=(
            "IMPORTANT: Full content is NEVER copied without confirmed reuse permission. "
            "Use --copyright-status allowed only after verifying the source terms."
        ),
    )
    parser.add_argument("--source", choices=list(SOURCES), help="Source identifier")
    parser.add_argument("--url", help="Page URL to import metadata from")
    parser.add_argument("--type", choices=CONTENT_TYPES, default="dua")
    parser.add_argument("--title", default="", help="Override page title")
    parser.add_argument("--language", default="")
    parser.add_argument(
        "--copyright-status",
        choices=["metadata_only", "permission_required", "allowed"],
        default="metadata_only",
        help="Set only to 'allowed' when reuse is confirmed",
    )
    parser.add_argument("--permission-note", default="", help="Evidence of permission")
    parser.add_argument("--output-dir", type=Path, default=IMPORTED_DIR)
    parser.add_argument("--list-sources", action="store_true")
    parser.add_argument("--generate-index", action="store_true")
    args = parser.parse_args()

    if args.list_sources:
        for sid, s in SOURCES.items():
            print(f"\n{sid}: {s['title']}")
            print(f"  base : {s['base_url']}")
            print(f"  note : {s['copyright_note']}")
        return

    if args.generate_index:
        generate_index(args.output_dir)
        return

    if not args.source or not args.url:
        parser.error("--source and --url are required (or use --list-sources / --generate-index)")

    src = SOURCES[args.source]
    print(f"Source  : {src['title']}")
    print(f"URL     : {args.url}")
    print(f"Note    : {src['copyright_note']}\n")

    allowed_fetch, html = fetch_with_robots_check(args.source, args.url)
    meta: dict = {"title": args.title, "description": "", "author": ""}
    if allowed_fetch and html:
        extracted = extract_metadata(html)
        if not meta["title"]:
            meta["title"] = extracted["title"]
        meta["description"] = extracted["description"]
        meta["author"] = extracted["author"]
    else:
        print("[warn] Could not fetch page – saving URL-only record.")

    if args.copyright_status == "allowed" and not args.permission_note:
        print(
            "[warn] --copyright-status=allowed requires --permission-note describing the "
            "confirmed permission. Downgrading to 'permission_required'."
        )
        args.copyright_status = "permission_required"

    record = make_record(
        source_id=args.source,
        content_type=args.type,
        title=meta["title"],
        source_url=args.url,
        description=meta["description"],
        author=meta["author"],
        language=args.language,
        copyright_status=args.copyright_status,
        permission_note=args.permission_note,
    )

    path = save_record(record, args.output_dir)
    print(f"Saved   : {path}")
    print(f"Status  : {record['copyrightStatus']}")
    if record["copyrightStatus"] != "allowed":
        print(
            "NOTE: Content array is empty. After confirming reuse permission, add full "
            "text manually or re-run with --copyright-status allowed --permission-note '...'."
        )


if __name__ == "__main__":
    main()
