import argparse
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DUAS_DIR = ROOT / "assets" / "json" / "duas"
INDEX_PATH = DUAS_DIR / "index.json"
AGGREGATE_PATH = ROOT / "assets" / "json" / "duas.json"

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

REQUIRED_KEYS = [
    "id",
    "title",
    "titleArabic",
    "titleUrdu",
    "titleFarsi",
    "category",
    "recommendedDays",
    "description",
    "sourceBook",
    "audioUrl",
    "offlineAudioPath",
    "tags",
    "searchText",
    "contentStatus",
    "reuseNote",
    "sourceRefs",
    "lines",
]

SOURCE_REFS = [
    {
        "title": "Duas.org",
        "url": "https://www.duas.org/",
        "usage": "Reference pointer only unless reuse permission is confirmed.",
    },
    {
        "title": "Mafatih al-Jinan",
        "url": "https://www.duas.org/downloads/mafatih_al_jinan.pdf",
        "usage": "Reference pointer only; translations require license verification or manual permission.",
    },
]

DUAS = [
    ("daily_duas", "Daily Duas", "الأدعية اليومية", "روزانہ دعائیں", "دعاهای روزانه", "daily_duas", ["daily"], ""),
    ("morning_duas", "Morning Duas", "أدعية الصباح", "صبح کی دعائیں", "دعاهای صبح", "daily_duas", ["morning"], ""),
    ("evening_duas", "Evening Duas", "أدعية المساء", "شام کی دعائیں", "دعاهای شب", "daily_duas", ["evening"], ""),
    ("taqeebat_e_namaz", "Taqeebat-e-Namaz", "تعقيبات الصلاة", "تعقیبات نماز", "تعقیبات نماز", "taqeebat", ["after_prayer"], "Mafatih al-Jinan"),
    ("dua_after_wajib_prayers", "Dua After Each Wajib Prayer", "دعاء بعد كل صلاة واجبة", "ہر واجب نماز کے بعد دعا", "دعا پس از هر نماز واجب", "taqeebat", ["after_wajib_prayer"], "Mafatih al-Jinan"),
    ("dua_kumail", "Dua Kumail", "دعاء كميل", "دعائے کمیل", "دعای کمیل", "weekly_duas", ["thursday_night"], "Mafatih al-Jinan"),
    ("dua_tawassul", "Dua Tawassul", "دعاء التوسل", "دعائے توسل", "دعای توسل", "weekly_duas", ["tuesday_night", "anytime"], "Mafatih al-Jinan"),
    ("dua_nudba", "Dua Nudba", "دعاء الندبة", "دعائے ندبہ", "دعای ندبه", "weekly_duas", ["friday", "eid_fitr", "eid_adha", "eid_ghadeer", "ashura"], "Mafatih al-Jinan"),
    ("dua_ahad", "Dua Ahad", "دعاء العهد", "دعائے عہد", "دعای عهد", "daily_duas", ["daily_after_fajr"], "Mafatih al-Jinan"),
    ("dua_faraj", "Dua Faraj", "دعاء الفرج", "دعائے فرج", "دعای فرج", "imam_mahdi_duas", ["anytime"], "Mafatih al-Jinan"),
    ("dua_mashlool", "Dua Mashlool", "دعاء المشلول", "دعائے مشلول", "دعای مشلول", "special_duas", ["anytime"], "Mafatih al-Jinan"),
    ("dua_mujeer", "Dua Mujeer", "دعاء المجير", "دعائے مجیر", "دعای مجیر", "ramadhan_duas", ["ramadhan_13", "ramadhan_14", "ramadhan_15"], "Mafatih al-Jinan"),
    ("dua_jawshan_kabeer", "Dua Jawshan Kabeer", "دعاء الجوشن الكبير", "دعائے جوشن کبیر", "دعای جوشن کبیر", "ramadhan_duas", ["ramadhan_nights"], "Mafatih al-Jinan"),
    ("dua_jawshan_sagheer", "Dua Jawshan Sagheer", "دعاء الجوشن الصغير", "دعائے جوشن صغیر", "دعای جوشن صغیر", "special_duas", ["anytime"], "Mafatih al-Jinan"),
    ("dua_abu_hamza_thumali", "Dua Abu Hamza Thumali", "دعاء أبي حمزة الثمالي", "دعائے ابو حمزہ ثمالی", "دعای ابوحمزه ثمالی", "ramadhan_duas", ["ramadhan_sahar"], "Mafatih al-Jinan"),
    ("dua_iftitah", "Dua Iftitah", "دعاء الافتتاح", "دعائے افتتاح", "دعای افتتاح", "ramadhan_duas", ["ramadhan_nights"], "Mafatih al-Jinan"),
    ("dua_sahar", "Dua Sahar", "دعاء السحر", "دعائے سحر", "دعای سحر", "ramadhan_duas", ["ramadhan_sahar"], "Mafatih al-Jinan"),
    ("dua_simaat", "Dua Simaat", "دعاء السمات", "دعائے سمات", "دعای سمات", "weekly_duas", ["friday_evening"], "Mafatih al-Jinan"),
    ("dua_yastasheer", "Dua Yastasheer", "دعاء يستشير", "دعائے یستشیر", "دعای یستشیر", "special_duas", ["anytime"], "Mafatih al-Jinan"),
    ("dua_adeela", "Dua Adeela", "دعاء العديلة", "دعائے عدیلہ", "دعای عدیله", "faith_duas", ["anytime"], "Mafatih al-Jinan"),
    ("dua_alqama", "Dua Alqama", "دعاء علقمة", "دعائے علقمہ", "دعای علقمه", "ziyarat_duas", ["after_ziyarat_ashura"], "Mafatih al-Jinan"),
    ("dua_makarim_ul_akhlaq", "Dua Makarim-ul-Akhlaq", "دعاء مكارم الأخلاق", "دعائے مکارم الاخلاق", "دعای مکارم الاخلاق", "sahifa_sajjadiya", ["anytime"], "Sahifa Sajjadiya"),
    ("dua_hujjat", "Dua Hujjat", "دعاء الحجة", "دعائے حجت", "دعای حجت", "imam_mahdi_duas", ["anytime"], "Mafatih al-Jinan"),
    ("dua_imam_zaman", "Dua Imam Zaman A.S", "دعاء الإمام الزمان عليه السلام", "دعائے امام زمانہ عجل اللہ فرجہ", "دعای امام زمان عجل الله فرجه", "imam_mahdi_duas", ["friday", "anytime"], "Mafatih al-Jinan"),
    ("dua_for_rizq", "Dua for Rizq", "دعاء الرزق", "رزق کے لیے دعا", "دعا برای رزق", "need_duas", ["anytime"], ""),
    ("dua_for_illness_shifa", "Dua for Illness/Shifa", "دعاء الشفاء", "شفا کے لیے دعا", "دعا برای شفا", "need_duas", ["illness"], ""),
    ("dua_for_protection", "Dua for Protection", "دعاء الحفظ", "حفاظت کے لیے دعا", "دعای حفاظت", "need_duas", ["anytime"], ""),
    ("dua_for_parents", "Dua for Parents", "دعاء للوالدين", "والدین کے لیے دعا", "دعا برای والدین", "family_duas", ["anytime"], ""),
    ("dua_for_children", "Dua for Children", "دعاء للأولاد", "اولاد کے لیے دعا", "دعا برای فرزندان", "family_duas", ["anytime"], ""),
    ("dua_for_forgiveness", "Dua for Forgiveness", "دعاء الاستغفار", "مغفرت کے لیے دعا", "دعای آمرزش", "need_duas", ["anytime"], ""),
    ("dua_for_marriage", "Dua for Marriage", "دعاء الزواج", "شادی کے لیے دعا", "دعا برای ازدواج", "need_duas", ["anytime"], ""),
    ("dua_for_travel", "Dua for Travel", "دعاء السفر", "سفر کے لیے دعا", "دعای سفر", "travel_duas", ["travel"], ""),
    ("dua_before_after_food", "Dua Before/After Food", "دعاء قبل وبعد الطعام", "کھانے سے پہلے/بعد دعا", "دعا قبل و بعد از غذا", "daily_duas", ["food"], ""),
    ("dua_before_after_sleep", "Dua Before/After Sleep", "دعاء قبل وبعد النوم", "سونے سے پہلے/بعد دعا", "دعا قبل و بعد از خواب", "daily_duas", ["sleep"], ""),
    ("dua_thursday_night", "Dua for Thursday Night", "دعاء ليلة الجمعة", "شب جمعہ کی دعا", "دعای شب جمعه", "weekly_duas", ["thursday_night"], "Mafatih al-Jinan"),
    ("dua_friday", "Dua for Friday", "دعاء يوم الجمعة", "جمعہ کے دن کی دعا", "دعای روز جمعه", "weekly_duas", ["friday"], "Mafatih al-Jinan"),
    ("ramadhan_duas", "Ramadhan Duas", "أدعية شهر رمضان", "رمضان کی دعائیں", "دعاهای ماه رمضان", "ramadhan_duas", ["ramadhan"], "Mafatih al-Jinan"),
    ("rajab_duas", "Rajab Duas", "أدعية شهر رجب", "رجب کی دعائیں", "دعاهای ماه رجب", "rajab_duas", ["rajab"], "Mafatih al-Jinan"),
    ("shaban_duas", "Shaban Duas", "أدعية شهر شعبان", "شعبان کی دعائیں", "دعاهای ماه شعبان", "shaban_duas", ["shaban"], "Mafatih al-Jinan"),
    ("muharram_duas", "Muharram Duas", "أدعية شهر محرم", "محرم کی دعائیں", "دعاهای ماه محرم", "muharram_duas", ["muharram"], "Mafatih al-Jinan"),
    ("eid_duas", "Eid Duas", "أدعية العيد", "عید کی دعائیں", "دعاهای عید", "eid_duas", ["eid_fitr", "eid_adha", "eid_ghadeer"], "Mafatih al-Jinan"),
    ("hajj_ziyarat_duas", "Hajj/Ziyarat Duas", "أدعية الحج والزيارة", "حج/زیارت کی دعائیں", "دعاهای حج و زیارت", "hajj_ziyarat_duas", ["hajj", "ziyarat"], "Mafatih al-Jinan"),
    ("munajaat_collection", "Munajaat Collection", "مجموعة المناجاة", "مناجات مجموعہ", "مجموعه مناجات", "munajaat", ["anytime"], "Sahifa Sajjadiya"),
    ("quranic_duas", "Quranic Duas", "الأدعية القرآنية", "قرآنی دعائیں", "دعاهای قرآنی", "quranic_duas", ["anytime"], "Holy Quran"),
    ("short_duas", "Short Duas", "الأدعية القصيرة", "مختصر دعائیں", "دعاهای کوتاه", "short_duas", ["anytime"], ""),
]


def file_name(dua_id: str) -> str:
    return f"{dua_id}.json"


def empty_line(number: int = 1) -> dict:
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


def search_text(dua: dict) -> str:
    pieces = [
        dua.get("title", ""),
        dua.get("titleArabic", ""),
        dua.get("titleUrdu", ""),
        dua.get("titleFarsi", ""),
        dua.get("category", ""),
        " ".join(dua.get("recommendedDays", [])),
        " ".join(dua.get("tags", [])),
    ]
    for line in dua.get("lines", []):
        pieces.extend(
            [
                line.get("textArabic", ""),
                line.get("textEnglish", ""),
                line.get("textUrdu", ""),
                line.get("textFarsi", ""),
                line.get("transliteration", ""),
            ]
        )
    return " ".join(piece for piece in pieces if piece).lower()


def make_dua(item: tuple, existing: dict | None = None) -> dict:
    dua_id, title, title_ar, title_ur, title_fa, category, days, source_book = item
    lines = existing.get("lines", []) if existing else []
    dua = {
        "id": dua_id,
        "title": title,
        "titleArabic": title_ar,
        "titleUrdu": title_ur,
        "titleFarsi": title_fa,
        "category": category,
        "recommendedDays": days,
        "description": existing.get("description", "") if existing else "",
        "sourceBook": existing.get("sourceBook", source_book) if existing else source_book,
        "audioUrl": existing.get("audioUrl", "") if existing else "",
        "offlineAudioPath": existing.get("offlineAudioPath", "") if existing else "",
        "tags": sorted(set([category, *days, title.lower().replace(" ", "_").replace("/", "_")])),
        "contentStatus": "existing_workspace_content" if lines else "awaiting_licensed_or_manual_text",
        "reuseNote": (
            "Only public-domain, open-source, explicitly licensed, or manually "
            "provided text should be inserted. Empty lines are intentional where "
            "reuse permission is not confirmed."
        ),
        "sourceRefs": SOURCE_REFS,
        "lines": lines,
    }
    dua["searchText"] = search_text(dua)
    return dua


def write_json(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def read_existing(path: Path) -> dict | None:
    if not path.exists():
        return None
    return json.loads(path.read_text(encoding="utf-8"))


def generate() -> None:
    DUAS_DIR.mkdir(parents=True, exist_ok=True)
    index_items = []
    aggregate_items = []

    for item in DUAS:
        dua_id = item[0]
        path = DUAS_DIR / file_name(dua_id)
        existing = read_existing(path)
        dua = make_dua(item, existing)
        write_json(path, dua)
        index_items.append(
            {
                "id": dua["id"],
                "title": dua["title"],
                "titleArabic": dua["titleArabic"],
                "titleUrdu": dua["titleUrdu"],
                "titleFarsi": dua["titleFarsi"],
                "file": file_name(dua_id),
                "category": dua["category"],
                "recommendedDays": dua["recommendedDays"],
                "tags": dua["tags"],
                "searchText": dua["searchText"],
                "contentStatus": dua["contentStatus"],
                "lineCount": len(dua["lines"]),
            }
        )
        aggregate_items.append(
            {
                "name": dua["title"],
                "nameArabic": dua["titleArabic"],
                "description": dua["description"],
                "category": dua["category"],
                "audioUrl": dua["audioUrl"],
                "lines": dua["lines"],
            }
        )

    write_json(
        INDEX_PATH,
        {
            "version": "1.0.0",
            "updatedAt": "2026-04-29",
            "items": index_items,
        },
    )
    write_json(AGGREGATE_PATH, {"duas": aggregate_items})


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


def validate_dua(path: Path) -> None:
    data = json.loads(path.read_text(encoding="utf-8"))
    missing = [key for key in REQUIRED_KEYS if key not in data]
    if missing:
        raise ValueError(f"{path}: missing required keys {missing}")
    if not isinstance(data["lines"], list):
        raise ValueError(f"{path}: lines must be a list")
    for index, line in enumerate(data["lines"], start=1):
        validate_line(line, index, path)


def validate() -> None:
    index = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    if len(index.get("items", [])) != len(DUAS):
        raise ValueError(f"Expected {len(DUAS)} duas, found {len(index.get('items', []))}")
    seen = set()
    for item in index["items"]:
        if item["id"] in seen:
            raise ValueError(f"duplicate dua id in index: {item['id']}")
        seen.add(item["id"])
        path = DUAS_DIR / item["file"]
        if not path.exists():
            raise ValueError(f"missing dua JSON file: {path}")
        validate_dua(path)
    json.loads(AGGREGATE_PATH.read_text(encoding="utf-8"))


def import_dua(source_path: Path, dua_id: str) -> None:
    source = json.loads(source_path.read_text(encoding="utf-8"))
    path = DUAS_DIR / file_name(dua_id)
    source["id"] = dua_id
    source["searchText"] = search_text(source)
    write_json(path, source)
    validate_dua(path)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=["generate", "validate", "import"])
    parser.add_argument("--source", type=Path)
    parser.add_argument("--dua-id")
    args = parser.parse_args()

    if args.command == "generate":
        generate()
        validate()
        print(f"Generated and validated {len(DUAS)} Dua JSON files.")
    elif args.command == "validate":
        validate()
        print(f"Validated {len(DUAS)} Dua JSON files.")
    else:
        if not args.source or not args.dua_id:
            raise SystemExit("import requires --source and --dua-id")
        import_dua(args.source, args.dua_id)
        validate()
        print(f"Imported and validated {args.dua_id}.")


if __name__ == "__main__":
    main()
