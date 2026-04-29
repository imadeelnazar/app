import argparse
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ZIYARAAT_DIR = ROOT / "assets" / "json" / "ziyaraat"
INDEX_PATH = ZIYARAAT_DIR / "index.json"
AGGREGATE_PATH = ROOT / "assets" / "json" / "ziyaraat.json"

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

SOURCE_REFS = [
    {
        "title": "Duas.org All Ziyarats",
        "url": "https://www.duas.org/ziyarat.html",
        "usage": "Reference index and source pointer only unless reuse permission is confirmed.",
    },
    {
        "title": "Mafatih al-Jinan Arabic-English PDF",
        "url": "https://duas.org/downloads/mafatih_al_jinan.pdf",
        "usage": "Reference source pointer only; translations require license verification or manual permission.",
    },
]

ASHURA_MANUAL_LINE = {
    "number": 1,
    "textArabic": "السلام عليك يا أبا عبد الله",
    "textEnglish": "Peace be upon you, O Father of Abdullah",
    "textUrdu": "سلام ہو تم پر اے ابا عبداللہ",
    "textFarsi": "السلام علیک یا ابا عبد الله",
    "transliteration": "As-salāmu ʿalayka yā Abā ʿAbdillāh",
    "audioUrl": "",
    "audioStartTime": None,
    "audioEndTime": None,
}

ITEMS = [
    ("ziyarat_ashura", "Ziyarat Ashura", "زيارة عاشوراء", "زیارت عاشورہ", "زیارت عاشورا", "imam_hussain_as", ["ashura", "thursday", "daily"], "Manually seeded with the sample line provided in the request."),
    ("ziyarat_warith", "Ziyarat Warith", "زيارة وارث", "زیارت وارث", "زیارت وارث", "imam_hussain_as", ["thursday", "arbaeen", "daily"], ""),
    ("ziyarat_arbaeen", "Ziyarat Arbaeen", "زيارة الأربعين", "زیارت اربعین", "زیارت اربعین", "imam_hussain_as", ["arbaeen"], ""),
    ("ziyarat_ameenullah", "Ziyarat Ameenullah", "زيارة أمين الله", "زیارت امین اللہ", "زیارت امین الله", "general", ["thursday", "friday", "daily"], ""),
    ("ziyarat_ale_yasin", "Ziyarat Ale Yasin", "زيارة آل ياسين", "زیارت آل یاسین", "زیارت آل یاسین", "imam_mahdi_as", ["friday", "daily"], ""),
    ("ziyarat_jamia_kabira", "Ziyarat Jamia Kabira", "الزيارة الجامعة الكبيرة", "زیارت جامعہ کبیرہ", "زیارت جامعه کبیره", "ahlulbayt_as", ["daily"], ""),
    ("ziyarat_jamia_sagheera", "Ziyarat Jamia Sagheera", "الزيارة الجامعة الصغيرة", "زیارت جامعہ صغیرہ", "زیارت جامعه صغیره", "ahlulbayt_as", ["daily"], ""),
    ("ziyarat_nahiya", "Ziyarat Nahiya Muqaddasa", "زيارة الناحية المقدسة", "زیارت ناحیہ مقدسہ", "زیارت ناحیه مقدسه", "imam_hussain_as", ["ashura"], ""),
    ("ziyarat_rajabiyah", "Ziyarat Rajabiyah", "الزيارة الرجبية", "زیارت رجبیہ", "زیارت رجبیه", "rajab", ["rajab"], ""),
    ("ziyarat_imam_hussain", "Ziyarat Imam Hussain A.S", "زيارة الإمام الحسين عليه السلام", "زیارت امام حسینؑ", "زیارت امام حسین علیه‌السلام", "imam_hussain_as", ["thursday", "daily"], ""),
    ("ziyarat_imam_ali", "Ziyarat Imam Ali A.S", "زيارة الإمام علي عليه السلام", "زیارت امام علیؑ", "زیارت امام علی علیه‌السلام", "imam_ali_as", ["sunday", "daily"], ""),
    ("ziyarat_prophet_muhammad", "Ziyarat Prophet Muhammad S.A.W.W", "زيارة النبي محمد صلى الله عليه وآله", "زیارت حضرت محمد مصطفیٰؐ", "زیارت پیامبر اکرم صلی‌الله‌علیه‌وآله", "prophet_saww", ["saturday", "daily"], ""),
    ("ziyarat_fatima_zahra", "Ziyarat Janab-e-Fatima Zahra S.A", "زيارة السيدة فاطمة الزهراء عليها السلام", "زیارت جناب فاطمہ زہرا سلام اللہ علیہا", "زیارت حضرت فاطمه زهرا سلام‌الله‌علیها", "fatima_zahra_sa", ["sunday", "daily"], ""),
    ("ziyarat_imam_hasan", "Ziyarat Imam Hasan A.S", "زيارة الإمام الحسن عليه السلام", "زیارت امام حسنؑ", "زیارت امام حسن علیه‌السلام", "imam_hasan_as", ["monday", "daily"], ""),
    ("ziyarat_imam_sajjad", "Ziyarat Imam Sajjad A.S", "زيارة الإمام السجاد عليه السلام", "زیارت امام سجادؑ", "زیارت امام سجاد علیه‌السلام", "imam_sajjad_as", ["tuesday", "daily"], ""),
    ("ziyarat_imam_baqir", "Ziyarat Imam Baqir A.S", "زيارة الإمام الباقر عليه السلام", "زیارت امام باقرؑ", "زیارت امام باقر علیه‌السلام", "imam_baqir_as", ["tuesday", "daily"], ""),
    ("ziyarat_imam_sadiq", "Ziyarat Imam Sadiq A.S", "زيارة الإمام الصادق عليه السلام", "زیارت امام صادقؑ", "زیارت امام صادق علیه‌السلام", "imam_sadiq_as", ["tuesday", "daily"], ""),
    ("ziyarat_imam_kazim", "Ziyarat Imam Kazim A.S", "زيارة الإمام الكاظم عليه السلام", "زیارت امام کاظمؑ", "زیارت امام کاظم علیه‌السلام", "imam_kazim_as", ["wednesday", "daily"], ""),
    ("ziyarat_imam_raza", "Ziyarat Imam Raza A.S", "زيارة الإمام الرضا عليه السلام", "زیارت امام رضاؑ", "زیارت امام رضا علیه‌السلام", "imam_raza_as", ["wednesday", "daily"], ""),
    ("ziyarat_imam_taqi", "Ziyarat Imam Taqi A.S", "زيارة الإمام التقي الجواد عليه السلام", "زیارت امام تقی جوادؑ", "زیارت امام تقی جواد علیه‌السلام", "imam_taqi_as", ["wednesday", "daily"], ""),
    ("ziyarat_imam_naqi", "Ziyarat Imam Naqi A.S", "زيارة الإمام النقي الهادي عليه السلام", "زیارت امام نقی ہادیؑ", "زیارت امام نقی هادی علیه‌السلام", "imam_naqi_as", ["wednesday", "daily"], ""),
    ("ziyarat_imam_hasan_askari", "Ziyarat Imam Hasan Askari A.S", "زيارة الإمام الحسن العسكري عليه السلام", "زیارت امام حسن عسکریؑ", "زیارت امام حسن عسکری علیه‌السلام", "imam_hasan_askari_as", ["thursday", "daily"], ""),
    ("ziyarat_imam_mahdi", "Ziyarat Imam Mahdi A.S", "زيارة الإمام المهدي عجل الله تعالى فرجه", "زیارت امام مہدیؑ", "زیارت امام مهدی عجل‌الله‌تعالی‌فرجه", "imam_mahdi_as", ["friday", "daily"], ""),
    ("ziyarat_aimmat_ul_baqi", "Ziyarat Aimmat-ul-Baqi A.S", "زيارة أئمة البقيع عليهم السلام", "زیارت ائمہ بقیعؑ", "زیارت ائمه بقیع علیهم‌السلام", "baqi_as", ["daily"], ""),
    ("ziyarat_muslim_bin_aqeel", "Ziyarat Muslim Bin Aqeel A.S", "زيارة مسلم بن عقيل عليه السلام", "زیارت مسلم بن عقیلؑ", "زیارت مسلم بن عقیل علیه‌السلام", "kufa", ["daily"], ""),
    ("ziyarat_hazrat_abbas", "Ziyarat Hazrat Abbas A.S", "زيارة أبي الفضل العباس عليه السلام", "زیارت حضرت عباسؑ", "زیارت حضرت عباس علیه‌السلام", "hazrat_abbas_as", ["daily"], ""),
    ("ziyarat_shohada_e_karbala", "Ziyarat Shohada-e-Karbala", "زيارة شهداء كربلاء", "زیارت شہدائے کربلا", "زیارت شهدای کربلا", "karbala_martyrs", ["ashura", "arbaeen", "daily"], ""),
    ("ziyarat_hazrat_zainab", "Ziyarat Hazrat Zainab S.A", "زيارة السيدة زينب عليها السلام", "زیارت حضرت زینب سلام اللہ علیہا", "زیارت حضرت زینب سلام‌الله‌علیها", "hazrat_zainab_sa", ["daily"], ""),
    ("ziyarat_umme_kulsoom", "Ziyarat Umme Kulsoom S.A", "زيارة أم كلثوم عليها السلام", "زیارت ام کلثوم سلام اللہ علیہا", "زیارت ام کلثوم سلام‌الله‌علیها", "umme_kulsoom_sa", ["daily"], ""),
    ("ziyarat_weekly_saturday", "Saturday Ziyarat", "زيارة يوم السبت", "ہفتہ کی زیارت", "زیارت روز شنبه", "weekly", ["saturday"], "Weekly Ziyarat associated with the Holy Prophet S.A.W.W."),
    ("ziyarat_weekly_sunday", "Sunday Ziyarat", "زيارة يوم الأحد", "اتوار کی زیارت", "زیارت روز یکشنبه", "weekly", ["sunday"], "Weekly Ziyarat associated with Imam Ali A.S and Lady Fatima Zahra S.A."),
    ("ziyarat_weekly_monday", "Monday Ziyarat", "زيارة يوم الاثنين", "پیر کی زیارت", "زیارت روز دوشنبه", "weekly", ["monday"], "Weekly Ziyarat associated with Imam Hasan A.S and Imam Hussain A.S."),
    ("ziyarat_weekly_tuesday", "Tuesday Ziyarat", "زيارة يوم الثلاثاء", "منگل کی زیارت", "زیارت روز سه‌شنبه", "weekly", ["tuesday"], "Weekly Ziyarat associated with Imam Sajjad, Imam Baqir, and Imam Sadiq A.S."),
    ("ziyarat_weekly_wednesday", "Wednesday Ziyarat", "زيارة يوم الأربعاء", "بدھ کی زیارت", "زیارت روز چهارشنبه", "weekly", ["wednesday"], "Weekly Ziyarat associated with Imam Kazim, Imam Raza, Imam Taqi, and Imam Naqi A.S."),
    ("ziyarat_weekly_thursday", "Thursday Ziyarat", "زيارة يوم الخميس", "جمعرات کی زیارت", "زیارت روز پنجشنبه", "weekly", ["thursday"], "Weekly Ziyarat associated with Imam Hasan Askari A.S."),
    ("ziyarat_weekly_friday", "Friday Ziyarat", "زيارة يوم الجمعة", "جمعہ کی زیارت", "زیارت روز جمعه", "weekly", ["friday"], "Weekly Ziyarat associated with Imam Mahdi A.S."),
]


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


def make_ziyarat(item: tuple) -> dict:
    zid, title, title_ar, title_ur, title_fa, category, days, description = item
    lines = [ASHURA_MANUAL_LINE] if zid == "ziyarat_ashura" else []
    return {
        "id": zid,
        "title": title,
        "titleArabic": title_ar,
        "titleUrdu": title_ur,
        "titleFarsi": title_fa,
        "category": category,
        "recommendedDays": days,
        "description": description,
        "audioUrl": "",
        "offlineAudioPath": "",
        "contentStatus": "manual_seed" if lines else "awaiting_licensed_or_manual_text",
        "reuseNote": "Only manually provided or license-cleared text should be inserted. Empty fields are intentional where reuse permission is not confirmed.",
        "sourceRefs": SOURCE_REFS,
        "lines": lines,
    }


def write_json(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def generate() -> None:
    ZIYARAAT_DIR.mkdir(parents=True, exist_ok=True)
    index_items = []
    aggregate_items = []
    for item in ITEMS:
        ziyarat = make_ziyarat(item)
        filename = f"{ziyarat['id']}.json"
        write_json(ZIYARAAT_DIR / filename, ziyarat)
        index_items.append(
            {
                "id": ziyarat["id"],
                "title": ziyarat["title"],
                "titleArabic": ziyarat["titleArabic"],
                "titleUrdu": ziyarat["titleUrdu"],
                "file": filename,
                "category": ziyarat["category"],
            }
        )
        aggregate_items.append(
            {
                "name": ziyarat["title"],
                "nameArabic": ziyarat["titleArabic"],
                "description": ziyarat["description"],
                "category": ziyarat["category"],
                "occasion": ", ".join(ziyarat["recommendedDays"]),
                "audioUrl": ziyarat["audioUrl"],
                "lines": ziyarat["lines"],
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
    write_json(AGGREGATE_PATH, {"ziyaraat": aggregate_items})


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


def validate_file(path: Path) -> None:
    data = json.loads(path.read_text(encoding="utf-8"))
    required = [
        "id",
        "title",
        "titleArabic",
        "titleUrdu",
        "titleFarsi",
        "category",
        "recommendedDays",
        "description",
        "audioUrl",
        "offlineAudioPath",
        "lines",
    ]
    missing = [key for key in required if key not in data]
    if missing:
        raise ValueError(f"{path}: missing required keys {missing}")
    if not isinstance(data["lines"], list):
        raise ValueError(f"{path}: lines must be a list")
    for index, line in enumerate(data["lines"], start=1):
        validate_line(line, index, path)


def validate() -> None:
    index = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    seen = set()
    for item in index["items"]:
        path = ZIYARAAT_DIR / item["file"]
        if item["id"] in seen:
            raise ValueError(f"duplicate id in index: {item['id']}")
        seen.add(item["id"])
        if not path.exists():
            raise ValueError(f"missing JSON file: {path}")
        validate_file(path)
    json.loads(AGGREGATE_PATH.read_text(encoding="utf-8"))
    print(f"Validated {len(seen)} Ziyaraat files.")


def import_manual(source: Path) -> None:
    data = json.loads(source.read_text(encoding="utf-8"))
    validate_file(source)
    target = ZIYARAAT_DIR / f"{data['id']}.json"
    if not target.exists():
        raise ValueError(f"Unknown Ziyarat id: {data['id']}")
    existing = json.loads(target.read_text(encoding="utf-8"))
    merged = {**existing, **data, "contentStatus": "manual_or_license_cleared_text"}
    write_json(target, merged)
    validate()


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate, validate, or import Ziyaraat JSON content.")
    parser.add_argument("command", choices=["generate", "validate", "import"])
    parser.add_argument("--source", type=Path, help="Manual JSON file to import for the import command.")
    args = parser.parse_args()

    if args.command == "generate":
        generate()
        validate()
    elif args.command == "validate":
        validate()
    elif args.command == "import":
        if args.source is None:
            raise SystemExit("--source is required for import")
        import_manual(args.source)


if __name__ == "__main__":
    main()
