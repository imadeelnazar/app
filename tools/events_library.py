import argparse
import json
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
EVENTS_DIR = ROOT / "assets" / "json" / "events"
INDEX_PATH = EVENTS_DIR / "index.json"
AGGREGATE_PATH = ROOT / "assets" / "json" / "events.json"

MONTHS = [
    ("Muharram", 1, "muharram_events.json"),
    ("Safar", 2, "safar_events.json"),
    ("Rabi ul Awwal", 3, "rabi_ul_awwal_events.json"),
    ("Rabi us Sani", 4, "rabi_us_sani_events.json"),
    ("Jamadi ul Awwal", 5, "jamadi_ul_awwal_events.json"),
    ("Jamadi us Sani", 6, "jamadi_us_sani_events.json"),
    ("Rajab", 7, "rajab_events.json"),
    ("Shaban", 8, "shaban_events.json"),
    ("Ramadhan", 9, "ramadhan_events.json"),
    ("Shawwal", 10, "shawwal_events.json"),
    ("Zilqad", 11, "zilqad_events.json"),
    ("Zilhajj", 12, "zilhajj_events.json"),
]

MONTH_BY_NUMBER = {number: (name, filename) for name, number, filename in MONTHS}
MONTH_FILE_BY_NUMBER = {number: filename for _, number, filename in MONTHS}

EVENT_KEYS = [
    "id",
    "title",
    "titleArabic",
    "titleUrdu",
    "titleFarsi",
    "category",
    "hijriMonth",
    "hijriMonthNumber",
    "hijriDay",
    "gregorianDate",
    "isRecurringYearly",
    "eventType",
    "relatedPersonality",
    "shortDescription",
    "fullDescription",
    "recommendedAamaal",
    "recommendedDuas",
    "recommendedZiyaraat",
    "notification",
]

NOTIFICATION_KEYS = ["enabled", "daysBefore", "time"]

RAW_EVENTS = [
    (1, 1, "event_islamic_new_year", "Beginning of Islamic Year", "رأس السنة الهجرية", "اسلامی سال کا آغاز", "آغاز سال هجری", "historical_events", "historical", "", ["weekly_aamaal"], [], []),
    (1, 2, "event_arrival_karbala", "Arrival of Imam Hussain A.S in Karbala", "وصول الإمام الحسين عليه السلام إلى كربلاء", "امام حسینؑ کی کربلا آمد", "ورود امام حسین علیه السلام به کربلا", "muharram_events", "historical", "Imam Hussain A.S", ["aamaal_muharram"], [], ["ziyarat_imam_hussain"]),
    (1, 7, "event_water_stopped_karbala", "Water Stopped in Karbala", "منع الماء في كربلاء", "کربلا میں پانی بند کیا گیا", "بستن آب در کربلا", "ayyame_aza", "historical", "Ahlul Bayt A.S", ["aamaal_muharram"], [], ["ziyarat_imam_hussain"]),
    (1, 9, "event_shab_e_ashur", "Shab-e-Ashur", "ليلة عاشوراء", "شب عاشور", "شب عاشورا", "ayyame_aza", "special_aamaal", "Imam Hussain A.S", ["aamaal_muharram"], ["dua_tawassul"], ["ziyarat_ashura"]),
    (1, 10, "event_ashura", "Ashura", "عاشوراء", "عاشورہ", "عاشورا", "ayyame_aza", "shahadat", "Imam Hussain A.S", ["aamaal_muharram"], ["dua_alqama"], ["ziyarat_ashura", "ziyarat_warith"]),
    (1, 11, "event_sham_e_ghareeban", "Sham-e-Ghareeban", "شام الغريبان", "شام غریباں", "شام غریبان", "ayyame_aza", "ayyame_aza", "Ahlul Bayt A.S", ["aamaal_muharram"], [], ["ziyarat_shohada_e_karbala"]),
    (1, 25, "event_shahadat_imam_sajjad", "Shahadat Imam Sajjad A.S", "شهادة الإمام السجاد عليه السلام", "شہادت امام سجادؑ", "شهادت امام سجاد علیه السلام", "shahadat_events", "shahadat", "Imam Sajjad A.S", ["aamaal_muharram"], [], ["ziyarat_imam_sajjad"]),
    (2, 20, "event_arbaeen", "Arbaeen", "الأربعين", "اربعین", "اربعین", "ayyame_aza", "ayyame_aza", "Imam Hussain A.S", [], [], ["ziyarat_arbaeen"]),
    (2, 28, "event_wafat_prophet_shahadat_imam_hasan", "Wafat Prophet Muhammad S.A.W.W and Shahadat Imam Hasan A.S", "وفاة النبي محمد صلى الله عليه وآله وشهادة الإمام الحسن عليه السلام", "وفات رسول اکرمؐ اور شہادت امام حسنؑ", "رحلت پیامبر اکرم صلی الله علیه وآله و شهادت امام حسن علیه السلام", "wafat_events", "wafat", "Prophet Muhammad S.A.W.W; Imam Hasan A.S", [], [], ["ziyarat_prophet_muhammad", "ziyarat_imam_hasan"]),
    (2, 30, "event_shahadat_imam_raza", "Shahadat Imam Raza A.S", "شهادة الإمام الرضا عليه السلام", "شہادت امام رضاؑ", "شهادت امام رضا علیه السلام", "shahadat_events", "shahadat", "Imam Raza A.S", [], [], ["ziyarat_imam_raza"]),
    (3, 8, "event_shahadat_imam_hasan_askari", "Shahadat Imam Hasan Askari A.S", "شهادة الإمام الحسن العسكري عليه السلام", "شہادت امام حسن عسکریؑ", "شهادت امام حسن عسکری علیه السلام", "shahadat_events", "shahadat", "Imam Hasan Askari A.S", [], [], ["ziyarat_imam_hasan_askari"]),
    (3, 17, "event_wiladat_prophet_imam_sadiq", "Wiladat Prophet Muhammad S.A.W.W and Imam Jafar Sadiq A.S", "ولادة النبي محمد صلى الله عليه وآله والإمام جعفر الصادق عليه السلام", "ولادت رسول اکرمؐ و امام جعفر صادقؑ", "ولادت پیامبر اکرم صلی الله علیه وآله و امام جعفر صادق علیه السلام", "wiladat_events", "wiladat", "Prophet Muhammad S.A.W.W; Imam Jafar Sadiq A.S", [], ["dua_tawassul"], ["ziyarat_prophet_muhammad", "ziyarat_imam_sadiq"]),
    (4, 10, "event_wafat_bibi_masooma", "Wafat Bibi Fatima Masooma S.A", "وفاة السيدة فاطمة المعصومة عليها السلام", "وفات بی بی فاطمہ معصومہؑ", "وفات حضرت فاطمه معصومه سلام الله علیها", "wafat_events", "wafat", "Bibi Fatima Masooma S.A", [], [], []),
    (4, 11, "event_wiladat_imam_hasan_askari", "Wiladat Imam Hasan Askari A.S", "ولادة الإمام الحسن العسكري عليه السلام", "ولادت امام حسن عسکریؑ", "ولادت امام حسن عسکری علیه السلام", "wiladat_events", "wiladat", "Imam Hasan Askari A.S", [], [], ["ziyarat_imam_hasan_askari"]),
    (5, 5, "event_wiladat_hazrat_zainab", "Wiladat Hazrat Zainab S.A", "ولادة السيدة زينب عليها السلام", "ولادت حضرت زینبؑ", "ولادت حضرت زینب سلام الله علیها", "wiladat_events", "wiladat", "Hazrat Zainab S.A", [], [], ["ziyarat_hazrat_zainab"]),
    (5, 13, "event_shahadat_fatima_first_narration", "Shahadat Janab-e-Fatima Zahra S.A", "شهادة السيدة فاطمة الزهراء عليها السلام", "شہادت جناب فاطمہ زہراؑ", "شهادت حضرت فاطمه زهرا سلام الله علیها", "shahadat_events", "shahadat", "Janab-e-Fatima Zahra S.A", [], [], ["ziyarat_fatima_zahra"]),
    (6, 3, "event_shahadat_fatima", "Shahadat Janab-e-Fatima Zahra S.A", "شهادة السيدة فاطمة الزهراء عليها السلام", "شہادت جناب فاطمہ زہراؑ", "شهادت حضرت فاطمه زهرا سلام الله علیها", "shahadat_events", "shahadat", "Janab-e-Fatima Zahra S.A", [], [], ["ziyarat_fatima_zahra"]),
    (6, 20, "event_wiladat_fatima_zahra", "Wiladat Janab-e-Fatima Zahra S.A", "ولادة السيدة فاطمة الزهراء عليها السلام", "ولادت جناب فاطمہ زہراؑ", "ولادت حضرت فاطمه زهرا سلام الله علیها", "wiladat_events", "wiladat", "Janab-e-Fatima Zahra S.A", [], [], ["ziyarat_fatima_zahra"]),
    (7, 1, "event_wiladat_imam_baqir", "Wiladat Imam Baqir A.S", "ولادة الإمام الباقر عليه السلام", "ولادت امام باقرؑ", "ولادت امام باقر علیه السلام", "wiladat_events", "wiladat", "Imam Baqir A.S", ["aamaal_rajab"], [], ["ziyarat_imam_baqir"]),
    (7, 3, "event_shahadat_imam_hadi", "Shahadat Imam Hadi A.S", "شهادة الإمام الهادي عليه السلام", "شہادت امام ہادیؑ", "شهادت امام هادی علیه السلام", "shahadat_events", "shahadat", "Imam Hadi A.S", ["aamaal_rajab"], [], ["ziyarat_imam_naqi"]),
    (7, 10, "event_wiladat_imam_jawad", "Wiladat Imam Jawad A.S", "ولادة الإمام الجواد عليه السلام", "ولادت امام جوادؑ", "ولادت امام جواد علیه السلام", "wiladat_events", "wiladat", "Imam Jawad A.S", ["aamaal_rajab"], [], ["ziyarat_imam_taqi"]),
    (7, 13, "event_wiladat_imam_ali", "Wiladat Imam Ali A.S", "ولادة الإمام علي عليه السلام", "ولادت امام علیؑ", "ولادت امام علی علیه السلام", "wiladat_events", "wiladat", "Imam Ali A.S", ["aamaal_rajab"], ["dua_tawassul"], ["ziyarat_imam_ali"]),
    (7, 15, "event_wafat_hazrat_zainab", "Wafat Hazrat Zainab S.A", "وفاة السيدة زينب عليها السلام", "وفات حضرت زینبؑ", "وفات حضرت زینب سلام الله علیها", "wafat_events", "wafat", "Hazrat Zainab S.A", ["aamaal_rajab"], [], ["ziyarat_hazrat_zainab"]),
    (7, 25, "event_shahadat_imam_kazim", "Shahadat Imam Kazim A.S", "شهادة الإمام الكاظم عليه السلام", "شہادت امام کاظمؑ", "شهادت امام کاظم علیه السلام", "shahadat_events", "shahadat", "Imam Kazim A.S", ["aamaal_rajab"], [], ["ziyarat_imam_kazim"]),
    (7, 27, "event_mabath", "Mabath", "المبعث النبوي", "مبعث", "مبعث", "special_aamaal_days", "historical", "Prophet Muhammad S.A.W.W", ["aamaal_rajab"], ["dua_tawassul"], ["ziyarat_prophet_muhammad"]),
    (8, 3, "event_wiladat_imam_hussain", "Wiladat Imam Hussain A.S", "ولادة الإمام الحسين عليه السلام", "ولادت امام حسینؑ", "ولادت امام حسین علیه السلام", "wiladat_events", "wiladat", "Imam Hussain A.S", ["aamaal_shaban"], [], ["ziyarat_imam_hussain"]),
    (8, 4, "event_wiladat_hazrat_abbas", "Wiladat Hazrat Abbas A.S", "ولادة العباس عليه السلام", "ولادت حضرت عباسؑ", "ولادت حضرت عباس علیه السلام", "wiladat_events", "wiladat", "Hazrat Abbas A.S", ["aamaal_shaban"], [], ["ziyarat_hazrat_abbas"]),
    (8, 5, "event_wiladat_imam_sajjad", "Wiladat Imam Sajjad A.S", "ولادة الإمام السجاد عليه السلام", "ولادت امام سجادؑ", "ولادت امام سجاد علیه السلام", "wiladat_events", "wiladat", "Imam Sajjad A.S", ["aamaal_shaban"], [], ["ziyarat_imam_sajjad"]),
    (8, 11, "event_wiladat_ali_akbar", "Wiladat Ali Akbar A.S", "ولادة علي الأكبر عليه السلام", "ولادت علی اکبرؑ", "ولادت علی اکبر علیه السلام", "wiladat_events", "wiladat", "Ali Akbar A.S", ["aamaal_shaban"], [], []),
    (8, 15, "event_wiladat_imam_mahdi", "Wiladat Imam Mahdi A.S", "ولادة الإمام المهدي عجل الله فرجه", "ولادت امام مہدیؑ", "ولادت امام مهدی عجل الله فرجه", "wiladat_events", "wiladat", "Imam Mahdi A.S", ["aamaal_shaban"], ["dua_ahad", "dua_nudba", "dua_faraj"], ["ziyarat_ale_yasin", "ziyarat_imam_mahdi"]),
    (9, 15, "event_wiladat_imam_hasan", "Wiladat Imam Hasan A.S", "ولادة الإمام الحسن عليه السلام", "ولادت امام حسنؑ", "ولادت امام حسن علیه السلام", "wiladat_events", "wiladat", "Imam Hasan A.S", ["aamaal_ramadhan"], ["dua_iftitah"], ["ziyarat_imam_hasan"]),
    (9, 19, "event_zarbat_imam_ali", "Zarbat Imam Ali A.S", "ضربة الإمام علي عليه السلام", "ضربت امام علیؑ", "ضربت خوردن امام علی علیه السلام", "ayyame_aza", "shahadat", "Imam Ali A.S", ["aamaal_ramadhan"], ["dua_jawshan_kabeer", "dua_iftitah"], ["ziyarat_imam_ali"]),
    (9, 21, "event_shahadat_imam_ali", "Shahadat Imam Ali A.S", "شهادة الإمام علي عليه السلام", "شہادت امام علیؑ", "شهادت امام علی علیه السلام", "shahadat_events", "shahadat", "Imam Ali A.S", ["aamaal_ramadhan"], ["dua_jawshan_kabeer", "dua_iftitah"], ["ziyarat_imam_ali"]),
    (9, 23, "event_laylatul_qadr", "Laylatul Qadr", "ليلة القدر", "شب قدر", "شب قدر", "special_aamaal_days", "special_night", "", ["aamaal_ramadhan"], ["dua_jawshan_kabeer", "dua_iftitah", "dua_sahar"], []),
    (10, 1, "event_eid_ul_fitr", "Eid ul Fitr", "عيد الفطر", "عید الفطر", "عید فطر", "eid_events", "eid", "", [], ["eid_duas"], []),
    (10, 8, "event_jannat_ul_baqi_demolition", "Demolition of Jannat-ul-Baqi", "هدم جنة البقيع", "انہدام جنت البقیع", "تخریب بقیع", "ayyame_aza", "historical", "Aimmat-ul-Baqi A.S", [], [], ["ziyarat_aimmat_ul_baqi"]),
    (10, 25, "event_shahadat_imam_sadiq", "Shahadat Imam Sadiq A.S", "شهادة الإمام الصادق عليه السلام", "شہادت امام صادقؑ", "شهادت امام صادق علیه السلام", "shahadat_events", "shahadat", "Imam Sadiq A.S", [], [], ["ziyarat_imam_sadiq"]),
    (11, 1, "event_wiladat_bibi_masooma", "Wiladat Bibi Fatima Masooma S.A", "ولادة السيدة فاطمة المعصومة عليها السلام", "ولادت بی بی فاطمہ معصومہؑ", "ولادت حضرت فاطمه معصومه سلام الله علیها", "wiladat_events", "wiladat", "Bibi Fatima Masooma S.A", [], [], []),
    (11, 11, "event_wiladat_imam_raza", "Wiladat Imam Raza A.S", "ولادة الإمام الرضا عليه السلام", "ولادت امام رضاؑ", "ولادت امام رضا علیه السلام", "wiladat_events", "wiladat", "Imam Raza A.S", [], [], ["ziyarat_imam_raza"]),
    (11, 25, "event_dahwul_arz", "Dahwul Arz", "دحو الأرض", "دحو الارض", "دحو الارض", "special_aamaal_days", "special_aamaal", "", [], ["dua_tawassul"], []),
    (11, 29, "event_shahadat_imam_jawad", "Shahadat Imam Jawad A.S", "شهادة الإمام الجواد عليه السلام", "شہادت امام جوادؑ", "شهادت امام جواد علیه السلام", "shahadat_events", "shahadat", "Imam Jawad A.S", [], [], ["ziyarat_imam_taqi"]),
    (12, 7, "event_shahadat_imam_baqir", "Shahadat Imam Baqir A.S", "شهادة الإمام الباقر عليه السلام", "شہادت امام باقرؑ", "شهادت امام باقر علیه السلام", "shahadat_events", "shahadat", "Imam Baqir A.S", [], [], ["ziyarat_imam_baqir"]),
    (12, 8, "event_yawm_e_tarwiyah", "Yawm-e-Tarwiyah", "يوم التروية", "یوم ترویہ", "روز ترویه", "hajj_zilhajj_events", "special_aamaal", "", [], ["hajj_ziyarat_duas"], []),
    (12, 9, "event_arafah", "Arafah", "عرفة", "عرفہ", "عرفه", "hajj_zilhajj_events", "special_aamaal", "", [], ["hajj_ziyarat_duas"], []),
    (12, 10, "event_eid_ul_adha", "Eid ul Adha", "عيد الأضحى", "عید الاضحیٰ", "عید قربان", "eid_events", "eid", "", [], ["eid_duas"], []),
    (12, 18, "event_eid_e_ghadeer", "Eid-e-Ghadeer", "عيد الغدير", "عید غدیر", "عید غدیر", "eid_events", "eid", "Imam Ali A.S", [], ["dua_tawassul"], ["ziyarat_imam_ali"]),
    (12, 24, "event_mubahila", "Mubahila", "المباهلة", "مباہلہ", "مباهله", "historical_events", "historical", "Ahlul Bayt A.S", [], ["dua_tawassul"], []),
]


def make_event(raw: tuple) -> dict:
    month_number, day, event_id, title, title_ar, title_ur, title_fa, category, event_type, personality, aamaal, duas, ziyaraat = raw
    month_name = MONTH_BY_NUMBER[month_number][0]
    return {
        "id": event_id,
        "title": title,
        "titleArabic": title_ar,
        "titleUrdu": title_ur,
        "titleFarsi": title_fa,
        "category": category,
        "hijriMonth": month_name,
        "hijriMonthNumber": month_number,
        "hijriDay": day,
        "gregorianDate": "",
        "isRecurringYearly": True,
        "eventType": event_type,
        "relatedPersonality": personality,
        "shortDescription": "",
        "fullDescription": "",
        "recommendedAamaal": aamaal,
        "recommendedDuas": duas,
        "recommendedZiyaraat": ziyaraat,
        "notification": {
            "enabled": True,
            "daysBefore": 1,
            "time": "09:00",
        },
    }


def write_json(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def generate() -> None:
    grouped = defaultdict(list)
    for raw in RAW_EVENTS:
        event = make_event(raw)
        grouped[event["hijriMonthNumber"]].append(event)

    index_items = []
    aggregate_events = []
    for month_name, month_number, filename in MONTHS:
        events = sorted(grouped[month_number], key=lambda item: item["hijriDay"])
        write_json(
            EVENTS_DIR / filename,
            {
                "version": "1.0.0",
                "updatedAt": "2026-04-29",
                "hijriMonth": month_name,
                "hijriMonthNumber": month_number,
                "events": events,
            },
        )
        for event in events:
            index_items.append(
                {
                    "id": event["id"],
                    "title": event["title"],
                    "titleUrdu": event["titleUrdu"],
                    "file": filename,
                    "category": event["category"],
                    "hijriMonth": event["hijriMonth"],
                    "hijriMonthNumber": event["hijriMonthNumber"],
                    "hijriDay": event["hijriDay"],
                    "eventType": event["eventType"],
                    "relatedPersonality": event["relatedPersonality"],
                }
            )
            aggregate_events.append(
                {
                    "month": event["hijriMonth"],
                    "day": event["hijriDay"],
                    "title": event["title"],
                    "titleArabic": event["titleArabic"],
                    "description": event["shortDescription"],
                    "content": event["fullDescription"],
                    "contentArabic": "",
                    "contentUrdu": "",
                    "contentFarsi": "",
                }
            )

    write_json(
        INDEX_PATH,
        {
            "version": "1.0.0",
            "updatedAt": "2026-04-29",
            "calendar": "hijri",
            "gregorianDatePolicy": "calculate dynamically each year; JSON keeps gregorianDate empty by design",
            "items": index_items,
        },
    )
    write_json(AGGREGATE_PATH, {"events": aggregate_events})


def validate_event(event: dict, path: Path) -> None:
    missing = [key for key in EVENT_KEYS if key not in event]
    extra = [key for key in event.keys() if key not in EVENT_KEYS]
    if missing or extra:
        raise ValueError(f"{path}: event keys mismatch for {event.get('id')}; missing={missing}, extra={extra}")
    if event["gregorianDate"] != "":
        raise ValueError(f"{path}: gregorianDate must stay empty for dynamic yearly calculation")
    if event["hijriMonthNumber"] not in MONTH_BY_NUMBER:
        raise ValueError(f"{path}: invalid hijriMonthNumber {event['hijriMonthNumber']}")
    if event["hijriMonth"] != MONTH_BY_NUMBER[event["hijriMonthNumber"]][0]:
        raise ValueError(f"{path}: hijriMonth and hijriMonthNumber do not match")
    if not 1 <= event["hijriDay"] <= 30:
        raise ValueError(f"{path}: invalid hijriDay {event['hijriDay']}")
    notification = event["notification"]
    missing_notification = [key for key in NOTIFICATION_KEYS if key not in notification]
    extra_notification = [key for key in notification.keys() if key not in NOTIFICATION_KEYS]
    if missing_notification or extra_notification:
        raise ValueError(f"{path}: notification keys mismatch for {event['id']}")


def validate() -> None:
    index = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    seen = set()
    total = 0
    for _, month_number, filename in MONTHS:
        path = EVENTS_DIR / filename
        if not path.exists():
            raise ValueError(f"missing month file: {path}")
        data = json.loads(path.read_text(encoding="utf-8"))
        if data["hijriMonthNumber"] != month_number:
            raise ValueError(f"{path}: wrong month number")
        previous_day = 0
        for event in data.get("events", []):
            validate_event(event, path)
            if event["id"] in seen:
                raise ValueError(f"duplicate event id: {event['id']}")
            if event["hijriDay"] < previous_day:
                raise ValueError(f"{path}: events must be sorted by hijriDay")
            previous_day = event["hijriDay"]
            seen.add(event["id"])
            total += 1

    if len(index.get("items", [])) != total:
        raise ValueError("index item count does not match month files")
    for item in index["items"]:
        if item["id"] not in seen:
            raise ValueError(f"index references unknown event: {item['id']}")
        if item["file"] != MONTH_FILE_BY_NUMBER[item["hijriMonthNumber"]]:
            raise ValueError(f"index file mismatch for {item['id']}")
    json.loads(AGGREGATE_PATH.read_text(encoding="utf-8"))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=["generate", "validate"])
    args = parser.parse_args()

    if args.command == "generate":
        generate()
        validate()
        print(f"Generated and validated {len(RAW_EVENTS)} Islamic event records.")
    else:
        validate()
        print(f"Validated {len(RAW_EVENTS)} Islamic event records.")


if __name__ == "__main__":
    main()
