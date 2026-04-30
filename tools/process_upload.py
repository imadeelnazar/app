#!/usr/bin/env python3
"""
Process uploaded Islamic content files into structured JSON for the Hidayat app.

Supported input formats
-----------------------
  .json  — already-structured content (validated against the schema)
  .txt   — plain text parsed into Arabic/translation line pairs
  .mp3   — audio file linked to existing content

Usage examples
--------------
# Process a TXT file (Arabic + English pairs separated by blank lines)
python tools/process_upload.py process \
    --file my_dua.txt --type dua --title "Dua Kumail" --category weekly_duas

# Validate an existing JSON content file
python tools/process_upload.py validate --file assets/json/imported/abc123_dua-kumail.json

# Link an MP3 file to an uploaded content item
python tools/process_upload.py audio \
    --file recitation.mp3 --content-id abc123def0

# List all uploaded content
python tools/process_upload.py list

JSON schema (top-level)
-----------------------
{
  "id", "type", "title", "category", "source", "languages",
  "content": [ { "number", "chapterTitle", "sectionTitle",
                  "textArabic", "textUrdu", "textEnglish", "textFarsi",
                  "reference", "audioUrl", "audioStartTime", "audioEndTime" } ],
  "audioFiles", "createdAt", "updatedAt"
}
"""

import argparse
import json
import re
import shutil
import sys
import uuid
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
IMPORTED_DIR = ROOT / "assets" / "json" / "imported"
AUDIO_DIR = ROOT / "assets" / "audio" / "imported"

CONTENT_TYPES = ["book", "dua", "ziyarat", "quran", "event", "amaal", "biography"]

REQUIRED_TOP_KEYS = {
    "id", "type", "title", "category", "source", "languages",
    "content", "audioFiles", "createdAt", "updatedAt",
}
REQUIRED_ITEM_KEYS = {
    "number", "chapterTitle", "sectionTitle",
    "textArabic", "textUrdu", "textEnglish", "textFarsi",
    "reference", "audioUrl", "audioStartTime", "audioEndTime",
}


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def _now() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


def _slug(text: str) -> str:
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")[:60]


def _new_id() -> str:
    return uuid.uuid4().hex[:10]


def _has_arabic(text: str) -> bool:
    return bool(re.search(r"[؀-ۿݐ-ݿﭐ-﷿ﹰ-﻿]", text))


def _empty_item(number: int) -> dict:
    return {
        "number": number,
        "chapterTitle": "",
        "sectionTitle": "",
        "textArabic": "",
        "textUrdu": "",
        "textEnglish": "",
        "textFarsi": "",
        "reference": "",
        "audioUrl": "",
        "audioStartTime": None,
        "audioEndTime": None,
    }


def _wrap_content(
    content_type: str,
    title: str,
    category: str,
    source: str,
    items: list[dict],
    content_id: str | None = None,
) -> dict:
    now = _now()
    return {
        "id": content_id or _new_id(),
        "type": content_type,
        "title": title,
        "category": category,
        "source": source,
        "languages": ["arabic", "english", "urdu", "farsi"],
        "content": items,
        "audioFiles": [],
        "createdAt": now,
        "updatedAt": now,
        "status": "draft",
        "copyrightStatus": "metadata_only",
    }


# ---------------------------------------------------------------------------
# TXT parser
# ---------------------------------------------------------------------------
def _parse_txt(raw: str) -> list[dict]:
    """
    Split text into content items.

    Heuristic:
    - Paragraphs are separated by one or more blank lines.
    - If a paragraph contains Arabic script → textArabic.
    - If the immediately following paragraph has no Arabic → textEnglish for same item.
    - Otherwise each paragraph becomes its own item.
    """
    paragraphs = [p.strip() for p in re.split(r"\n{2,}", raw) if p.strip()]
    items: list[dict] = []
    num = 1
    i = 0
    while i < len(paragraphs):
        item = _empty_item(num)
        para = paragraphs[i]
        if _has_arabic(para):
            item["textArabic"] = para
            # Peek: next paragraph is a translation?
            if i + 1 < len(paragraphs) and not _has_arabic(paragraphs[i + 1]):
                item["textEnglish"] = paragraphs[i + 1]
                i += 2
            else:
                i += 1
        else:
            item["textEnglish"] = para
            i += 1
        items.append(item)
        num += 1
    return items


def process_txt(path: Path, content_type: str, title: str, category: str, source: str) -> dict:
    raw = path.read_text(encoding="utf-8", errors="replace")
    items = _parse_txt(raw)
    if not items:
        raise ValueError("No content extracted from file.")
    return _wrap_content(content_type, title, category, source, items)


# ---------------------------------------------------------------------------
# JSON validator / loader
# ---------------------------------------------------------------------------
def _validate_item(item: dict, idx: int) -> list[str]:
    errors: list[str] = []
    missing = REQUIRED_ITEM_KEYS - set(item.keys())
    if missing:
        errors.append(f"  content[{idx}] missing keys: {sorted(missing)}")
    if item.get("number") != idx:
        errors.append(f"  content[{idx}].number is {item.get('number')!r}, expected {idx}")
    for key in ("audioStartTime", "audioEndTime"):
        val = item.get(key)
        if val is not None and not isinstance(val, (int, float)):
            errors.append(f"  content[{idx}].{key} must be null or numeric")
    return errors


def validate_json(data: dict) -> list[str]:
    errors: list[str] = []
    missing_top = REQUIRED_TOP_KEYS - set(data.keys())
    if missing_top:
        errors.append(f"Missing top-level keys: {sorted(missing_top)}")
    content = data.get("content", [])
    if not isinstance(content, list):
        errors.append("'content' must be a list")
    else:
        for idx, item in enumerate(content, 1):
            if not isinstance(item, dict):
                errors.append(f"  content[{idx}] is not an object")
            else:
                errors.extend(_validate_item(item, idx))
    return errors


def load_and_validate_json(path: Path) -> tuple[dict, list[str]]:
    data = json.loads(path.read_text(encoding="utf-8"))
    return data, validate_json(data)


# ---------------------------------------------------------------------------
# Disk helpers
# ---------------------------------------------------------------------------
def save_content(data: dict, output_dir: Path) -> Path:
    output_dir.mkdir(parents=True, exist_ok=True)
    name = f"{data['id']}_{_slug(data.get('title', 'content'))}.json"
    path = output_dir / name
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    return path


def find_content_file(content_id: str, output_dir: Path) -> Path | None:
    matches = list(output_dir.glob(f"{content_id}_*.json"))
    return matches[0] if matches else None


def update_audio_in_content(content_file: Path, audio_entry: dict) -> None:
    data = json.loads(content_file.read_text(encoding="utf-8"))
    audio_list: list = data.setdefault("audioFiles", [])

    # Deduplicate by filename
    if not any(a.get("file") == audio_entry["file"] for a in audio_list):
        audio_list.append(audio_entry)
    data["updatedAt"] = _now()
    content_file.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")


# ---------------------------------------------------------------------------
# Audio handling
# ---------------------------------------------------------------------------
def link_audio(audio_path: Path, content_id: str, chapter: str = "", line: int = 0) -> dict:
    """Copy MP3 to the imported audio directory and return an audio entry dict."""
    dest_dir = AUDIO_DIR / content_id
    dest_dir.mkdir(parents=True, exist_ok=True)
    dest = dest_dir / audio_path.name
    shutil.copy2(audio_path, dest)
    relative = f"assets/audio/imported/{content_id}/{audio_path.name}"
    return {
        "file": audio_path.name,
        "localPath": relative,
        "contentId": content_id,
        "chapter": chapter,
        "lineNumber": line,
        "duration": None,
        "addedAt": _now(),
    }


# ---------------------------------------------------------------------------
# List command
# ---------------------------------------------------------------------------
def list_content(output_dir: Path) -> None:
    files = sorted(output_dir.glob("*.json"))
    if not files:
        print("No uploaded content found.")
        return
    print(f"{'ID':<12} {'Type':<12} {'Status':<12} Title")
    print("-" * 70)
    for f in files:
        if f.name == "index.json":
            continue
        try:
            d = json.loads(f.read_text(encoding="utf-8"))
            print(
                f"{d.get('id','?'):<12} {d.get('type','?'):<12} "
                f"{d.get('status','?'):<12} {d.get('title','?')}"
            )
        except Exception:
            print(f"  (could not read {f.name})")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------
def main() -> None:
    parser = argparse.ArgumentParser(
        description="Process Islamic content files into JSON for the Hidayat app."
    )
    sub = parser.add_subparsers(dest="cmd")

    # --- process ---
    p_proc = sub.add_parser("process", help="Convert TXT/JSON file to content JSON")
    p_proc.add_argument("--file", type=Path, required=True)
    p_proc.add_argument("--type", choices=CONTENT_TYPES, default="book")
    p_proc.add_argument("--title", default="")
    p_proc.add_argument("--category", default="")
    p_proc.add_argument("--source", default="")
    p_proc.add_argument("--output-dir", type=Path, default=IMPORTED_DIR)

    # --- validate ---
    p_val = sub.add_parser("validate", help="Validate a content JSON file")
    p_val.add_argument("--file", type=Path, required=True)

    # --- audio ---
    p_aud = sub.add_parser("audio", help="Link an MP3 file to uploaded content")
    p_aud.add_argument("--file", type=Path, required=True)
    p_aud.add_argument("--content-id", required=True)
    p_aud.add_argument("--chapter", default="")
    p_aud.add_argument("--line", type=int, default=0)
    p_aud.add_argument("--output-dir", type=Path, default=IMPORTED_DIR)

    # --- list ---
    p_lst = sub.add_parser("list", help="List all uploaded content")
    p_lst.add_argument("--output-dir", type=Path, default=IMPORTED_DIR)

    args = parser.parse_args()

    if args.cmd == "process":
        if not args.file.exists():
            sys.exit(f"File not found: {args.file}")
        title = args.title or args.file.stem.replace("_", " ").replace("-", " ").title()
        ext = args.file.suffix.lower()

        if ext == ".json":
            data, errors = load_and_validate_json(args.file)
            if errors:
                print("Validation errors:")
                for e in errors:
                    print(f"  {e}")
                sys.exit(1)
            # Ensure required fields have defaults
            data.setdefault("status", "draft")
            data.setdefault("copyrightStatus", "metadata_only")
            print(f"JSON valid – {len(data.get('content', []))} content items")
        elif ext in (".txt", ".text"):
            data = process_txt(args.file, args.type, title, args.category, args.source)
            print(f"Parsed {len(data['content'])} content items from TXT")
        else:
            sys.exit(
                f"Unsupported file type '{ext}'. Supported: .json, .txt\n"
                "For PDF/DOCX, extract text first then process as .txt"
            )

        out_path = save_content(data, args.output_dir)
        print(f"Saved: {out_path}")

    elif args.cmd == "validate":
        if not args.file.exists():
            sys.exit(f"File not found: {args.file}")
        data, errors = load_and_validate_json(args.file)
        if errors:
            print("Errors found:")
            for e in errors:
                print(f"  {e}")
            sys.exit(1)
        print(
            f"Valid – id={data.get('id')}  type={data.get('type')}  "
            f"items={len(data.get('content', []))}"
        )

    elif args.cmd == "audio":
        if not args.file.exists():
            sys.exit(f"File not found: {args.file}")
        entry = link_audio(args.file, args.content_id, args.chapter, args.line)
        content_file = find_content_file(args.content_id, args.output_dir)
        if content_file:
            update_audio_in_content(content_file, entry)
            print(f"Updated {content_file.name} with audio '{args.file.name}'")
        else:
            print(
                f"Warning: No content JSON found for id={args.content_id}\n"
                f"Audio copied to: {entry['localPath']}"
            )

    elif args.cmd == "list":
        list_content(args.output_dir)

    else:
        parser.print_help()


if __name__ == "__main__":
    main()
