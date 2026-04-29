import argparse
import json
import math
import urllib.request
import xml.etree.ElementTree as ET
from bisect import bisect_right
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
QURAN_DIR = ROOT / "assets" / "json" / "quran"
SURAHS_DIR = QURAN_DIR / "surahs"
INDEX_PATH = QURAN_DIR / "quran_index.json"
SURAHS_PATH = QURAN_DIR / "quran_surahs.json"
AYAHS_PATH = QURAN_DIR / "quran_ayahs.json"
LEGACY_PATH = ROOT / "assets" / "json" / "quran.json"

QURAN_TEXT_URL = (
    "https://tanzil.net/pub/download/index.php?"
    "quranType=simple&outType=txt-2&agree=true"
)
QURAN_METADATA_URL = "https://tanzil.net/res/text/metadata/quran-data.xml"

TOTAL_SURAHS = 114
TOTAL_AYAHS = 6236
UPDATED_AT = "2026-04-29"

AYAH_KEYS = [
    "id",
    "surahNumber",
    "ayahNumber",
    "juz",
    "hizb",
    "page",
    "textArabic",
    "textEnglish",
    "textUrdu",
    "textFarsi",
    "transliteration",
    "audioUrl",
    "audioStartTime",
    "audioEndTime",
]

SOURCE_REFS = [
    {
        "title": "Tanzil Quran Text",
        "url": "https://tanzil.net/download",
        "license": "Tanzil terms allow verbatim use in websites/apps with source attribution and link-back.",
        "copyright": "Copyright (C) 2007-2026 Tanzil Project",
    },
    {
        "title": "Tanzil Quran Metadata",
        "url": "https://tanzil.net/docs/Quran_Metadata",
        "license": "CC-BY metadata file from Tanzil.",
        "copyright": "Copyright (C) 2008-2009 Tanzil.info",
    },
]


def download_text(url: str) -> str:
    with urllib.request.urlopen(url, timeout=60) as response:
        return response.read().decode("utf-8")


def load_existing_surah_names() -> dict[int, dict]:
    if not SURAHS_PATH.exists():
        return {}
    return {
        int(item["surahNumber"]): item
        for item in json.loads(SURAHS_PATH.read_text(encoding="utf-8"))
    }


def parse_quran_text(text: str) -> dict[tuple[int, int], str]:
    ayahs = {}
    for raw_line in text.splitlines():
        if "|" not in raw_line or raw_line.startswith("#"):
            continue
        surah_text, ayah_text, arabic = raw_line.split("|", 2)
        key = (int(surah_text), int(ayah_text))
        if key in ayahs:
            raise ValueError(f"Duplicate Quran ayah in source: {key}")
        ayahs[key] = arabic
    return ayahs


def parse_metadata(xml_text: str) -> dict:
    root = ET.fromstring(xml_text)
    surahs = []
    for sura in root.find("suras").findall("sura"):
        surahs.append(
            {
                "surahNumber": int(sura.attrib["index"]),
                "nameArabic": sura.attrib["name"],
                "nameEnglish": sura.attrib["tname"],
                "nameUrdu": "",
                "nameFarsi": "",
                "transliteration": sura.attrib["tname"],
                "revelationType": "meccan"
                if sura.attrib["type"].lower() == "meccan"
                else "medinan",
                "totalAyahs": int(sura.attrib["ayas"]),
                "start": int(sura.attrib["start"]),
            }
        )

    starts = {
        "juz": _parse_starts(root.find("juzs"), "juz"),
        "quarter": _parse_starts(root.find("hizbs"), "quarter"),
        "page": _parse_starts(root.find("pages"), "page"),
    }
    return {"surahs": surahs, "starts": starts}


def _parse_starts(parent: ET.Element, tag_name: str) -> list[tuple[int, int, int]]:
    starts = []
    for element in parent.findall(tag_name):
        starts.append(
            (
                int(element.attrib["index"]),
                int(element.attrib["sura"]),
                int(element.attrib["aya"]),
            )
        )
    return starts


def global_index(surah_starts: dict[int, int], surah: int, ayah: int) -> int:
    return surah_starts[surah] + ayah


def build_start_lookup(
    starts: list[tuple[int, int, int]], surah_starts: dict[int, int]
) -> tuple[list[int], list[int]]:
    positions = []
    values = []
    for index, surah, ayah in starts:
        positions.append(global_index(surah_starts, surah, ayah))
        values.append(index)
    return positions, values


def value_for_position(positions: list[int], values: list[int], position: int) -> int:
    index = bisect_right(positions, position) - 1
    if index < 0:
        return values[0]
    return values[index]


def generate() -> None:
    QURAN_DIR.mkdir(parents=True, exist_ok=True)
    SURAHS_DIR.mkdir(parents=True, exist_ok=True)

    existing_names = load_existing_surah_names()
    quran_text = download_text(QURAN_TEXT_URL)
    metadata_text = download_text(QURAN_METADATA_URL)
    arabic_text = parse_quran_text(quran_text)
    metadata = parse_metadata(metadata_text)

    surahs = []
    for item in metadata["surahs"]:
        previous = existing_names.get(item["surahNumber"], {})
        surah = {
            "surahNumber": item["surahNumber"],
            "nameArabic": item["nameArabic"],
            "nameEnglish": previous.get("nameEnglish") or item["nameEnglish"],
            "nameUrdu": previous.get("nameUrdu", ""),
            "nameFarsi": previous.get("nameFarsi", ""),
            "transliteration": previous.get("transliteration") or item["transliteration"],
            "revelationType": item["revelationType"],
            "totalAyahs": item["totalAyahs"],
        }
        surahs.append(surah)

    surah_starts = {item["surahNumber"]: item["start"] for item in metadata["surahs"]}
    juz_positions, juz_values = build_start_lookup(metadata["starts"]["juz"], surah_starts)
    quarter_positions, quarter_values = build_start_lookup(
        metadata["starts"]["quarter"], surah_starts
    )
    page_positions, page_values = build_start_lookup(metadata["starts"]["page"], surah_starts)

    all_ayahs = []
    legacy_surahs = []
    for surah in surahs:
        surah_number = surah["surahNumber"]
        ayahs = []
        legacy_ayahs = []
        for ayah_number in range(1, surah["totalAyahs"] + 1):
            key = (surah_number, ayah_number)
            text_arabic = arabic_text.get(key)
            if not text_arabic:
                raise ValueError(f"Missing Arabic Quran text for {surah_number}:{ayah_number}")
            position = global_index(surah_starts, surah_number, ayah_number)
            quarter = value_for_position(quarter_positions, quarter_values, position)
            ayah = {
                "id": f"{surah_number}_{ayah_number}",
                "surahNumber": surah_number,
                "ayahNumber": ayah_number,
                "juz": value_for_position(juz_positions, juz_values, position),
                "hizb": math.ceil(quarter / 4),
                "page": value_for_position(page_positions, page_values, position),
                "textArabic": text_arabic,
                "textEnglish": "",
                "textUrdu": "",
                "textFarsi": "",
                "transliteration": "",
                "audioUrl": "",
                "audioStartTime": None,
                "audioEndTime": None,
            }
            ayahs.append(ayah)
            all_ayahs.append(ayah)
            legacy_ayahs.append(
                {
                    "number": ayah_number,
                    "textArabic": text_arabic,
                    "textEnglish": "",
                    "textUrdu": "",
                    "textFarsi": "",
                    "transliteration": "",
                    "audioUrls": [],
                }
            )

        write_json(
            SURAHS_DIR / f"surah_{surah_number}.json",
            {
                **surah,
                "sourceRefs": SOURCE_REFS,
                "ayahs": ayahs,
            },
        )
        legacy_surahs.append(
            {
                "number": surah_number,
                "name": surah["nameEnglish"],
                "nameArabic": surah["nameArabic"],
                "meaning": "",
                "ayahCount": surah["totalAyahs"],
                "revelationType": surah["revelationType"].capitalize(),
                "bismillah": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ"
                if surah_number != 9
                else "",
                "ayahs": legacy_ayahs,
            }
        )

    write_json(SURAHS_PATH, surahs)
    write_json(AYAHS_PATH, all_ayahs)
    write_json(
        INDEX_PATH,
        {
            "version": "1.0.0",
            "totalSurahs": TOTAL_SURAHS,
            "totalAyahs": TOTAL_AYAHS,
            "updatedAt": UPDATED_AT,
            "files": {
                "surahs": "quran_surahs.json",
                "ayahs": "quran_ayahs.json",
                "surahsDir": "surahs/",
            },
            "features": [
                "surah_wise_reading",
                "juz_wise_reading",
                "search_arabic_english_urdu",
                "audio_ready",
                "timestamp_highlight_ready",
                "bookmark_ready",
                "continue_reading_ready",
                "offline_first",
            ],
            "textDirection": {
                "arabic": "rtl",
                "urdu": "rtl",
                "farsi": "rtl",
                "english": "ltr",
                "transliteration": "ltr",
            },
            "sourceRefs": SOURCE_REFS,
        },
    )
    write_json(LEGACY_PATH, {"surahs": legacy_surahs})


def write_json(path: Path, data) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def validate() -> None:
    index = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    surahs = json.loads(SURAHS_PATH.read_text(encoding="utf-8"))
    ayahs = json.loads(AYAHS_PATH.read_text(encoding="utf-8"))

    if index["totalSurahs"] != TOTAL_SURAHS or len(surahs) != TOTAL_SURAHS:
        raise ValueError("Total Surahs must be 114")
    if index["totalAyahs"] != TOTAL_AYAHS or len(ayahs) != TOTAL_AYAHS:
        raise ValueError("Total Ayahs must be 6236")

    seen = set()
    expected_ayah_count = 0
    for expected_surah, surah in enumerate(surahs, start=1):
        if surah["surahNumber"] != expected_surah:
            raise ValueError(f"Surah numbering mismatch at {expected_surah}")
        expected_ayah_count += surah["totalAyahs"]
        surah_path = SURAHS_DIR / f"surah_{expected_surah}.json"
        if not surah_path.exists():
            raise ValueError(f"Missing per-Surah file: {surah_path}")
        surah_file = json.loads(surah_path.read_text(encoding="utf-8"))
        if len(surah_file["ayahs"]) != surah["totalAyahs"]:
            raise ValueError(f"Wrong ayah count in {surah_path}")
        for expected_ayah, ayah in enumerate(surah_file["ayahs"], start=1):
            validate_ayah(ayah, expected_surah, expected_ayah, surah_path)
            seen.add(ayah["id"])

    if expected_ayah_count != TOTAL_AYAHS:
        raise ValueError("Surah ayah counts do not sum to 6236")

    for ayah in ayahs:
        validate_ayah(ayah, ayah["surahNumber"], ayah["ayahNumber"], AYAHS_PATH)
        if ayah["id"] not in seen:
            raise ValueError(f"Aggregate ayah missing from per-Surah files: {ayah['id']}")

    if len(seen) != TOTAL_AYAHS:
        raise ValueError("Duplicate or missing ayah IDs detected")

    legacy = json.loads(LEGACY_PATH.read_text(encoding="utf-8"))
    if len(legacy.get("surahs", [])) != TOTAL_SURAHS:
        raise ValueError("Legacy quran.json must contain 114 Surahs")


def validate_ayah(ayah: dict, surah_number: int, ayah_number: int, path: Path) -> None:
    missing = [key for key in AYAH_KEYS if key not in ayah]
    extra = [key for key in ayah.keys() if key not in AYAH_KEYS]
    if missing or extra:
        raise ValueError(f"{path}: ayah keys mismatch; missing={missing}, extra={extra}")
    if ayah["id"] != f"{surah_number}_{ayah_number}":
        raise ValueError(f"{path}: wrong ayah id {ayah['id']}")
    if ayah["surahNumber"] != surah_number or ayah["ayahNumber"] != ayah_number:
        raise ValueError(f"{path}: wrong ayah numbering for {ayah['id']}")
    if not ayah["textArabic"]:
        raise ValueError(f"{path}: Arabic text is required for {ayah['id']}")
    if not 1 <= ayah["juz"] <= 30:
        raise ValueError(f"{path}: invalid juz for {ayah['id']}")
    if not 1 <= ayah["hizb"] <= 60:
        raise ValueError(f"{path}: invalid hizb for {ayah['id']}")
    if not 1 <= ayah["page"] <= 604:
        raise ValueError(f"{path}: invalid page for {ayah['id']}")
    if ayah["audioStartTime"] is not None and not isinstance(
        ayah["audioStartTime"], (int, float)
    ):
        raise ValueError(f"{path}: audioStartTime must be null or numeric")
    if ayah["audioEndTime"] is not None and not isinstance(
        ayah["audioEndTime"], (int, float)
    ):
        raise ValueError(f"{path}: audioEndTime must be null or numeric")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=["generate", "validate"])
    args = parser.parse_args()

    if args.command == "generate":
        generate()
        validate()
        print("Generated and validated complete Quran JSON system: 114 Surahs, 6236 Ayahs.")
    else:
        validate()
        print("Validated complete Quran JSON system: 114 Surahs, 6236 Ayahs.")


if __name__ == "__main__":
    main()
