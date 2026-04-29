import argparse
import json
import urllib.request
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
BOOKS_DIR = ROOT / "assets" / "json" / "books"
INDEX_PATH = BOOKS_DIR / "index.json"
AGGREGATE_PATH = ROOT / "assets" / "json" / "books.json"
ZIYARAAT_INDEX_PATH = ROOT / "assets" / "json" / "ziyaraat" / "index.json"
QURAN_DOWNLOAD_URL = (
    "https://tanzil.net/pub/download/index.php?"
    "quranType=simple-clean&outType=txt-2&agree=true"
)

LINE_KEYS = [
    "number",
    "textArabic",
    "textEnglish",
    "textUrdu",
    "textFarsi",
    "transliteration",
    "audioUrl",
    "audioStartTime",
    "audioEndTime",
]

TOP_LEVEL_KEYS = [
    "id",
    "title",
    "titleArabic",
    "titleUrdu",
    "titleFarsi",
    "author",
    "category",
    "languageAvailable",
    "description",
    "coverImage",
    "contentStatus",
    "reuseNote",
    "sourceRefs",
    "textDirection",
    "chapters",
]

DIRECTION = {
    "arabic": "rtl",
    "urdu": "rtl",
    "farsi": "rtl",
    "english": "ltr",
    "transliteration": "ltr",
}

TANZIL_NOTICE = {
    "title": "Tanzil Quran Text",
    "url": "https://tanzil.net/download",
    "license": "Creative Commons Attribution 3.0",
    "usage": (
        "Arabic Quran text is included verbatim from Tanzil Project. "
        "Keep source attribution and this notice with derived files."
    ),
    "copyright": "Copyright (C) 2007-2021 Tanzil Project",
}

SOURCE_POINTERS = [
    {
        "title": "Duas.org",
        "url": "https://www.duas.org/",
        "usage": "Reference pointer only unless reuse permission is confirmed.",
    },
    {
        "title": "Al-Islam.org",
        "url": "https://www.al-islam.org/",
        "usage": "Reference pointer only unless reuse permission is confirmed.",
    },
]

BOOKS = [
    {
        "id": "holy_quran",
        "file": "holy_quran.json",
        "title": "Holy Quran",
        "titleArabic": "القرآن الكريم",
        "titleUrdu": "قرآن کریم",
        "titleFarsi": "قرآن کریم",
        "author": "",
        "category": "quran",
        "description": "Complete Arabic Quran text from Tanzil Project; translations are intentionally empty until licensed translations are supplied.",
        "sourceRefs": [TANZIL_NOTICE],
    },
    {
        "id": "mafatih_al_jinan",
        "file": "mafatih_al_jinan.json",
        "title": "Mafatih al-Jinan",
        "titleArabic": "مفاتيح الجنان",
        "titleUrdu": "مفاتیح الجنان",
        "titleFarsi": "مفاتیح الجنان",
        "author": "Shaykh Abbas Qummi",
        "category": "dua_book",
    },
    {
        "id": "sahifa_sajjadiya",
        "file": "sahifa_sajjadiya.json",
        "title": "Sahifa Sajjadiya",
        "titleArabic": "الصحيفة السجادية",
        "titleUrdu": "صحیفہ سجادیہ",
        "titleFarsi": "صحیفه سجادیه",
        "author": "Imam Ali ibn Husayn Zayn al-Abidin A.S",
        "category": "dua_book",
    },
    {
        "id": "sahifa_mahdiya",
        "file": "sahifa_mahdiya.json",
        "title": "Sahifa Mahdiya",
        "titleArabic": "الصحيفة المهدية",
        "titleUrdu": "صحیفہ مہدیہ",
        "titleFarsi": "صحیفه مهدیه",
        "author": "",
        "category": "dua_book",
    },
    {
        "id": "sahifa_fatemiyya",
        "file": "sahifa_fatemiyya.json",
        "title": "Sahifa Fatemiyya",
        "titleArabic": "الصحيفة الفاطمية",
        "titleUrdu": "صحیفہ فاطمیہ",
        "titleFarsi": "صحیفه فاطمیه",
        "author": "",
        "category": "dua_book",
    },
    {
        "id": "nahjul_balagha",
        "file": "nahjul_balagha.json",
        "title": "Nahjul Balagha",
        "titleArabic": "نهج البلاغة",
        "titleUrdu": "نہج البلاغہ",
        "titleFarsi": "نهج البلاغه",
        "author": "Sharif al-Radi",
        "category": "sermons_letters_sayings",
    },
    {
        "id": "tohfatul_awam",
        "file": "tohfatal_awam.json",
        "title": "Tohfatul Awam",
        "titleArabic": "تحفة العوام",
        "titleUrdu": "تحفۃ العوام",
        "titleFarsi": "تحفة العوام",
        "author": "",
        "category": "fiqh_aamaal_book",
    },
    {
        "id": "mafateeh_naveen",
        "file": "mafateeh_naveen.json",
        "title": "Mafateeh Naveen",
        "titleArabic": "",
        "titleUrdu": "مفاتیح نوین",
        "titleFarsi": "مفاتیح نوین",
        "author": "",
        "category": "dua_book",
    },
    {
        "id": "hadiyat_us_saleheen",
        "file": "hadiyat_us_saleheen.json",
        "title": "Hadiyat-us-Saleheen",
        "titleArabic": "",
        "titleUrdu": "ہدیۃ الصالحین",
        "titleFarsi": "هدیة الصالحین",
        "author": "",
        "category": "dua_book",
    },
    {
        "id": "taqeebat_e_namaz",
        "file": "taqeebat_e_namaz.json",
        "title": "Taqeebat-e-Namaz",
        "titleArabic": "تعقيبات الصلاة",
        "titleUrdu": "تعقیبات نماز",
        "titleFarsi": "تعقیبات نماز",
        "author": "",
        "category": "taqeebat",
    },
    {
        "id": "munajaat_collection",
        "file": "munajaat_collection.json",
        "title": "Munajaat Collection",
        "titleArabic": "مجموعة المناجاة",
        "titleUrdu": "مناجات مجموعہ",
        "titleFarsi": "مجموعه مناجات",
        "author": "",
        "category": "munajaat",
    },
    {
        "id": "aamaal_ramadhan",
        "file": "aamaal_ramadhan.json",
        "title": "Aamaal-e-Ramadhan",
        "titleArabic": "أعمال شهر رمضان",
        "titleUrdu": "اعمال ماہ رمضان",
        "titleFarsi": "اعمال ماه رمضان",
        "author": "",
        "category": "aamaal",
    },
    {
        "id": "aamaal_rajab",
        "file": "aamaal_rajab.json",
        "title": "Aamaal-e-Rajab",
        "titleArabic": "أعمال شهر رجب",
        "titleUrdu": "اعمال ماہ رجب",
        "titleFarsi": "اعمال ماه رجب",
        "author": "",
        "category": "aamaal",
    },
    {
        "id": "aamaal_shaban",
        "file": "aamaal_shaban.json",
        "title": "Aamaal-e-Shaban",
        "titleArabic": "أعمال شهر شعبان",
        "titleUrdu": "اعمال ماہ شعبان",
        "titleFarsi": "اعمال ماه شعبان",
        "author": "",
        "category": "aamaal",
    },
    {
        "id": "aamaal_muharram",
        "file": "aamaal_muharram.json",
        "title": "Aamaal-e-Muharram",
        "titleArabic": "أعمال شهر محرم",
        "titleUrdu": "اعمال ماہ محرم",
        "titleFarsi": "اعمال ماه محرم",
        "author": "",
        "category": "aamaal",
    },
    {
        "id": "weekly_aamaal",
        "file": "weekly_aamaal.json",
        "title": "Weekly Aamaal",
        "titleArabic": "الأعمال الأسبوعية",
        "titleUrdu": "ہفتہ وار اعمال",
        "titleFarsi": "اعمال هفتگی",
        "author": "",
        "category": "aamaal",
    },
    {
        "id": "daily_duas",
        "file": "daily_duas.json",
        "title": "Daily Duas",
        "titleArabic": "الأدعية اليومية",
        "titleUrdu": "روزانہ دعائیں",
        "titleFarsi": "دعاهای روزانه",
        "author": "",
        "category": "daily_duas",
    },
    {
        "id": "ziyaraat_collection",
        "file": "ziyaraat_collection.json",
        "title": "Ziyaraat Collection",
        "titleArabic": "مجموعة الزيارات",
        "titleUrdu": "زیارات مجموعہ",
        "titleFarsi": "مجموعه زیارات",
        "author": "",
        "category": "ziyaraat",
    },
    {
        "id": "masoomeen_biographies",
        "file": "masoomeen_biographies.json",
        "title": "Masoomeen A.S Biographies",
        "titleArabic": "سير المعصومين عليهم السلام",
        "titleUrdu": "معصومین علیہم السلام سوانح",
        "titleFarsi": "زندگانی معصومین علیهم السلام",
        "author": "",
        "category": "biographies",
    },
    {
        "id": "islamic_calendar_events",
        "file": "islamic_calendar_events.json",
        "title": "Islamic Calendar Events Book",
        "titleArabic": "مناسبات التقويم الإسلامي",
        "titleUrdu": "اسلامی کیلنڈر واقعات",
        "titleFarsi": "مناسبت‌های تقویم اسلامی",
        "author": "",
        "category": "calendar_events",
    },
]

SURAH_NAMES = [
    "Al-Fatiha", "Al-Baqarah", "Aal-Imran", "An-Nisa", "Al-Maidah",
    "Al-Anam", "Al-Araf", "Al-Anfal", "At-Tawbah", "Yunus", "Hud",
    "Yusuf", "Ar-Rad", "Ibrahim", "Al-Hijr", "An-Nahl", "Al-Isra",
    "Al-Kahf", "Maryam", "Taha", "Al-Anbiya", "Al-Hajj", "Al-Muminun",
    "An-Nur", "Al-Furqan", "Ash-Shuara", "An-Naml", "Al-Qasas",
    "Al-Ankabut", "Ar-Rum", "Luqman", "As-Sajdah", "Al-Ahzab", "Saba",
    "Fatir", "Ya-Sin", "As-Saffat", "Sad", "Az-Zumar", "Ghafir",
    "Fussilat", "Ash-Shura", "Az-Zukhruf", "Ad-Dukhan", "Al-Jathiyah",
    "Al-Ahqaf", "Muhammad", "Al-Fath", "Al-Hujurat", "Qaf",
    "Adh-Dhariyat", "At-Tur", "An-Najm", "Al-Qamar", "Ar-Rahman",
    "Al-Waqiah", "Al-Hadid", "Al-Mujadilah", "Al-Hashr", "Al-Mumtahanah",
    "As-Saff", "Al-Jumuah", "Al-Munafiqun", "At-Taghabun", "At-Talaq",
    "At-Tahrim", "Al-Mulk", "Al-Qalam", "Al-Haqqah", "Al-Maarij",
    "Nuh", "Al-Jinn", "Al-Muzzammil", "Al-Muddaththir", "Al-Qiyamah",
    "Al-Insan", "Al-Mursalat", "An-Naba", "An-Naziat", "Abasa",
    "At-Takwir", "Al-Infitar", "Al-Mutaffifin", "Al-Inshiqaq",
    "Al-Buruj", "At-Tariq", "Al-Ala", "Al-Ghashiyah", "Al-Fajr",
    "Al-Balad", "Ash-Shams", "Al-Layl", "Ad-Duha", "Ash-Sharh",
    "At-Tin", "Al-Alaq", "Al-Qadr", "Al-Bayyinah", "Az-Zalzalah",
    "Al-Adiyat", "Al-Qariah", "At-Takathur", "Al-Asr", "Al-Humazah",
    "Al-Fil", "Quraysh", "Al-Maun", "Al-Kawthar", "Al-Kafirun",
    "An-Nasr", "Al-Masad", "Al-Ikhlas", "Al-Falaq", "An-Nas",
]


def empty_line(number: int) -> dict:
    return {
        "number": number,
        "textArabic": "",
        "textEnglish": "",
        "textUrdu": "",
        "textFarsi": "",
        "transliteration": "",
        "audioUrl": "",
        "audioStartTime": None,
        "audioEndTime": None,
    }


def base_book(meta: dict, chapters: list | None = None, status: str | None = None) -> dict:
    source_refs = meta.get("sourceRefs", SOURCE_POINTERS)
    content_status = status or meta.get("contentStatus", "awaiting_licensed_or_manual_text")
    return {
        "id": meta["id"],
        "title": meta["title"],
        "titleArabic": meta["titleArabic"],
        "titleUrdu": meta["titleUrdu"],
        "titleFarsi": meta["titleFarsi"],
        "author": meta["author"],
        "category": meta["category"],
        "languageAvailable": [
            "arabic",
            "english",
            "urdu",
            "farsi",
            "transliteration",
        ],
        "description": meta.get("description", ""),
        "coverImage": "",
        "contentStatus": content_status,
        "reuseNote": (
            "Only public-domain, open-source, explicitly licensed, or manually "
            "provided text should be inserted. Empty chapters/fields are intentional "
            "where reuse permission is not confirmed."
        ),
        "sourceRefs": source_refs,
        "textDirection": DIRECTION,
        "chapters": chapters or [],
    }


def write_json(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def download_quran_text() -> str:
    with urllib.request.urlopen(QURAN_DOWNLOAD_URL, timeout=45) as response:
        return response.read().decode("utf-8")


def quran_chapters() -> list:
    grouped: dict[int, list[dict]] = defaultdict(list)
    for raw_line in download_quran_text().splitlines():
        if not raw_line or raw_line.startswith("#"):
            continue
        surah_text, ayah_text, arabic = raw_line.split("|", 2)
        surah_number = int(surah_text)
        ayah_number = int(ayah_text)
        grouped[surah_number].append(
            {
                **empty_line(ayah_number),
                "textArabic": arabic,
            }
        )

    chapters = []
    for surah_number in range(1, 115):
        lines = grouped[surah_number]
        chapters.append(
            {
                "id": f"surah_{surah_number}",
                "number": surah_number,
                "title": SURAH_NAMES[surah_number - 1],
                "titleArabic": "",
                "titleUrdu": "",
                "titleFarsi": "",
                "sections": [
                    {
                        "id": f"surah_{surah_number}_verses",
                        "number": 1,
                        "title": "Verses",
                        "titleArabic": "آيات",
                        "titleUrdu": "آیات",
                        "titleFarsi": "آیات",
                        "lines": lines,
                    }
                ],
            }
        )
    return chapters


def ziyaraat_collection_chapters() -> list:
    if not ZIYARAAT_INDEX_PATH.exists():
        return []

    index = json.loads(ZIYARAAT_INDEX_PATH.read_text(encoding="utf-8"))
    chapters = []
    for chapter_number, item in enumerate(index.get("items", []), start=1):
        source_path = ZIYARAAT_INDEX_PATH.parent / item["file"]
        if source_path.exists():
            ziyarah = json.loads(source_path.read_text(encoding="utf-8"))
            lines = ziyarah.get("lines", [])
            title_farsi = ziyarah.get("titleFarsi", "")
        else:
            lines = []
            title_farsi = ""
        chapters.append(
            {
                "id": item["id"],
                "number": chapter_number,
                "title": item["title"],
                "titleArabic": item.get("titleArabic", ""),
                "titleUrdu": item.get("titleUrdu", ""),
                "titleFarsi": title_farsi,
                "sections": [
                    {
                        "id": f"{item['id']}_section_1",
                        "number": 1,
                        "title": item["title"],
                        "titleArabic": item.get("titleArabic", ""),
                        "titleUrdu": item.get("titleUrdu", ""),
                        "titleFarsi": title_farsi,
                        "lines": lines,
                    }
                ],
            }
        )
    return chapters


def generate() -> None:
    BOOKS_DIR.mkdir(parents=True, exist_ok=True)
    index_items = []
    aggregate_items = []

    for order, meta in enumerate(BOOKS, start=1):
        if meta["id"] == "holy_quran":
            chapters = quran_chapters()
            status = "complete_arabic_tanzil_attribution_required"
        elif meta["id"] == "ziyaraat_collection":
            chapters = ziyaraat_collection_chapters()
            status = "partial_manual_or_license_cleared_content"
        else:
            chapters = []
            status = "awaiting_licensed_or_manual_text"

        book = base_book(meta, chapters, status)
        write_json(BOOKS_DIR / meta["file"], book)
        line_count = sum(
            len(section.get("lines", []))
            for chapter in chapters
            for section in chapter.get("sections", [])
        )
        index_items.append(
            {
                "id": meta["id"],
                "title": meta["title"],
                "titleArabic": meta["titleArabic"],
                "titleUrdu": meta["titleUrdu"],
                "titleFarsi": meta["titleFarsi"],
                "file": meta["file"],
                "category": meta["category"],
                "contentStatus": status,
                "chapterCount": len(chapters),
                "lineCount": line_count,
                "order": order,
            }
        )
        aggregate_items.append(
            {
                "title": meta["title"],
                "titleArabic": meta["titleArabic"],
                "author": meta["author"],
                "description": meta.get("description", ""),
                "category": meta["category"],
                "sections": [],
            }
        )

    write_json(
        INDEX_PATH,
        {
            "version": "1.0.0",
            "updatedAt": "2026-04-29",
            "textDirection": DIRECTION,
            "items": index_items,
        },
    )
    write_json(AGGREGATE_PATH, {"books": aggregate_items})


def validate_line(line: dict, expected_number: int, path: Path) -> None:
    missing = [key for key in LINE_KEYS if key not in line]
    extra = [key for key in line.keys() if key not in LINE_KEYS]
    if missing or extra:
        raise ValueError(f"{path}: line {expected_number} keys mismatch; missing={missing}, extra={extra}")
    if line["number"] != expected_number:
        raise ValueError(f"{path}: expected line number {expected_number}, got {line['number']}")
    if line["audioStartTime"] is not None and not isinstance(line["audioStartTime"], (int, float)):
        raise ValueError(f"{path}: audioStartTime must be null or numeric")
    if line["audioEndTime"] is not None and not isinstance(line["audioEndTime"], (int, float)):
        raise ValueError(f"{path}: audioEndTime must be null or numeric")


def validate_book(path: Path) -> None:
    data = json.loads(path.read_text(encoding="utf-8"))
    missing = [key for key in TOP_LEVEL_KEYS if key not in data]
    if missing:
        raise ValueError(f"{path}: missing required keys {missing}")
    if not isinstance(data["chapters"], list):
        raise ValueError(f"{path}: chapters must be a list")
    for chapter_index, chapter in enumerate(data["chapters"], start=1):
        if chapter.get("number") != chapter_index:
            raise ValueError(f"{path}: chapter numbering must start at 1 and be sequential")
        for section_index, section in enumerate(chapter.get("sections", []), start=1):
            if section.get("number") != section_index:
                raise ValueError(f"{path}: section numbering must start at 1 and be sequential")
            for line_index, line in enumerate(section.get("lines", []), start=1):
                validate_line(line, line_index, path)


def validate() -> None:
    index = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    seen = set()
    for item in index["items"]:
        if item["id"] in seen:
            raise ValueError(f"duplicate book id in index: {item['id']}")
        seen.add(item["id"])
        path = BOOKS_DIR / item["file"]
        if not path.exists():
            raise ValueError(f"missing book JSON file: {path}")
        validate_book(path)
    json.loads(AGGREGATE_PATH.read_text(encoding="utf-8"))


def import_book(source_path: Path, book_id: str) -> None:
    source = json.loads(source_path.read_text(encoding="utf-8"))
    target_item = next((item for item in BOOKS if item["id"] == book_id), None)
    if target_item is None:
        raise ValueError(f"Unknown book id: {book_id}")
    target_path = BOOKS_DIR / target_item["file"]
    write_json(target_path, source)
    validate_book(target_path)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=["generate", "validate", "import"])
    parser.add_argument("--source", type=Path)
    parser.add_argument("--book-id")
    args = parser.parse_args()

    if args.command == "generate":
        generate()
        validate()
        print("Generated and validated 20 book JSON files.")
    elif args.command == "validate":
        validate()
        print("Validated 20 book JSON files.")
    else:
        if not args.source or not args.book_id:
            raise SystemExit("import requires --source and --book-id")
        import_book(args.source, args.book_id)
        validate()
        print(f"Imported and validated {args.book_id}.")


if __name__ == "__main__":
    main()
