import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/services.dart';

enum EventThemeMood { normal, mourning, celebration }

class IslamicCalendarEvent {
  final String id;
  final String title;
  final String titleUrdu;
  final String category;
  final int hijriMonthNumber;
  final int hijriDay;
  final String eventType;
  final String relatedPersonality;
  final List<String> recommendedAamaal;
  final List<String> recommendedDuas;
  final List<String> recommendedZiyaraat;
  final bool notificationEnabled;
  final int notificationDaysBefore;
  final String notificationTime;

  const IslamicCalendarEvent({
    required this.id,
    required this.title,
    required this.titleUrdu,
    required this.category,
    required this.hijriMonthNumber,
    required this.hijriDay,
    required this.eventType,
    required this.relatedPersonality,
    required this.recommendedAamaal,
    required this.recommendedDuas,
    required this.recommendedZiyaraat,
    required this.notificationEnabled,
    required this.notificationDaysBefore,
    required this.notificationTime,
  });

  factory IslamicCalendarEvent.fromJson(Map<String, dynamic> json) {
    final notification = json['notification'] as Map<String, dynamic>? ?? {};
    return IslamicCalendarEvent(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Islamic Event',
      titleUrdu: json['titleUrdu'] as String? ?? '',
      category: json['category'] as String? ?? '',
      hijriMonthNumber: json['hijriMonthNumber'] as int? ?? 0,
      hijriDay: json['hijriDay'] as int? ?? 0,
      eventType: json['eventType'] as String? ?? '',
      relatedPersonality: json['relatedPersonality'] as String? ?? '',
      recommendedAamaal:
          List<String>.from(json['recommendedAamaal'] as List? ?? []),
      recommendedDuas:
          List<String>.from(json['recommendedDuas'] as List? ?? []),
      recommendedZiyaraat:
          List<String>.from(json['recommendedZiyaraat'] as List? ?? []),
      notificationEnabled: notification['enabled'] as bool? ?? true,
      notificationDaysBefore: notification['daysBefore'] as int? ?? 1,
      notificationTime: notification['time'] as String? ?? '09:00',
    );
  }

  bool get isMourning {
    final value = '$eventType $category $title'.toLowerCase();
    return value.contains('shahadat') ||
        value.contains('martyr') ||
        value.contains('ayyame_aza');
  }

  bool get isCelebration {
    final value = '$eventType $category $title'.toLowerCase();
    return value.contains('wiladat') ||
        value.contains('waladat') ||
        value.contains('birth') ||
        value.contains('eid');
  }
}

class HijriDate {
  final int year;
  final int month;
  final int day;

  const HijriDate(this.year, this.month, this.day);
}

class IslamicEventCalendarService {
  IslamicEventCalendarService._();

  static final IslamicEventCalendarService instance =
      IslamicEventCalendarService._();

  List<IslamicCalendarEvent>? _events;

  Future<List<IslamicCalendarEvent>> loadEvents() async {
    final cached = _events;
    if (cached != null) return cached;

    final indexString =
        await rootBundle.loadString('assets/json/events/index.json');
    final index = json.decode(indexString) as Map<String, dynamic>;
    final items =
        List<Map<String, dynamic>>.from(index['items'] as List? ?? []);
    final files = items.map((item) => item['file'] as String? ?? '').toSet()
      ..remove('');
    final events = <IslamicCalendarEvent>[];

    for (final file in files) {
      final fileString =
          await rootBundle.loadString('assets/json/events/$file');
      final data = json.decode(fileString) as Map<String, dynamic>;
      final monthEvents =
          List<Map<String, dynamic>>.from(data['events'] as List? ?? []);
      events.addAll(monthEvents.map(IslamicCalendarEvent.fromJson));
    }

    events.sort((a, b) {
      final monthCompare = a.hijriMonthNumber.compareTo(b.hijriMonthNumber);
      return monthCompare != 0
          ? monthCompare
          : a.hijriDay.compareTo(b.hijriDay);
    });
    _events = events;
    return events;
  }

  Future<List<IslamicCalendarEvent>> eventsForLocalDate(DateTime date) async {
    final localDate = DateTime(date.year, date.month, date.day);
    final hijri = hijriFromGregorian(localDate);
    final events = await loadEvents();
    return events
        .where(
          (event) =>
              event.hijriMonthNumber == hijri.month &&
              event.hijriDay == hijri.day,
        )
        .toList();
  }

  Future<EventThemeMood> moodForLocalDate(DateTime date) async {
    final events = await eventsForLocalDate(date);
    if (events.any((event) => event.isMourning)) {
      return EventThemeMood.mourning;
    }
    if (events.any((event) => event.isCelebration)) {
      return EventThemeMood.celebration;
    }
    return EventThemeMood.normal;
  }

  DateTime nextGregorianDate(
    IslamicCalendarEvent event, {
    DateTime? from,
  }) {
    final now = from ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentHijri = hijriFromGregorian(today);
    var hijriYear = currentHijri.year;
    var date =
        gregorianFromHijri(hijriYear, event.hijriMonthNumber, event.hijriDay);
    if (date.isBefore(today)) {
      hijriYear += 1;
      date =
          gregorianFromHijri(hijriYear, event.hijriMonthNumber, event.hijriDay);
    }
    return date;
  }

  HijriDate hijriFromGregorian(DateTime date) {
    final localDate = DateTime(date.year, date.month, date.day);
    final fixed = _fixedHijriFromGregorian(localDate);
    if (fixed != null) return fixed;

    final jd = _gregorianToJulianDay(date.year, date.month, date.day);
    final year = ((30 * (jd - 1948439.5) + 10646) / 10631).floor();
    final month = math.min(
      12,
      ((jd - (29 + _islamicToJulianDay(year, 1, 1))) / 29.5).ceil() + 1,
    );
    final day = (jd - _islamicToJulianDay(year, month, 1) + 1).floor();
    return HijriDate(year, month, day);
  }

  DateTime gregorianFromHijri(int year, int month, int day) {
    final fixed = _fixedGregorianFromHijri(year, month, day);
    if (fixed != null) return fixed;

    final jd = _islamicToJulianDay(year, month, day).floor();
    return _julianDayToGregorian(jd);
  }

  HijriDate? _fixedHijriFromGregorian(DateTime date) {
    for (var index = _fixedMonthStarts.length - 1; index >= 0; index--) {
      final start = _fixedMonthStarts[index];
      if (date.isBefore(start.gregorianStart)) continue;
      final nextStart = index == _fixedMonthStarts.length - 1
          ? null
          : _fixedMonthStarts[index + 1].gregorianStart;
      if (nextStart != null && !date.isBefore(nextStart)) continue;

      return HijriDate(
        start.hijriYear,
        start.hijriMonth,
        date.difference(start.gregorianStart).inDays + 1,
      );
    }
    return null;
  }

  DateTime? _fixedGregorianFromHijri(int year, int month, int day) {
    for (final start in _fixedMonthStarts) {
      if (start.hijriYear == year && start.hijriMonth == month) {
        return start.gregorianStart.add(Duration(days: day - 1));
      }
    }
    return null;
  }
}

class _HijriMonthStart {
  final int hijriYear;
  final int hijriMonth;
  final DateTime gregorianStart;

  const _HijriMonthStart(
    this.hijriYear,
    this.hijriMonth,
    this.gregorianStart,
  );
}

final List<_HijriMonthStart> _fixedMonthStarts = [
  _HijriMonthStart(1447, 7, DateTime(2025, 12, 21)),
  _HijriMonthStart(1447, 8, DateTime(2026, 1, 20)),
  _HijriMonthStart(1447, 9, DateTime(2026, 2, 19)),
  _HijriMonthStart(1447, 10, DateTime(2026, 3, 20)),
  _HijriMonthStart(1447, 11, DateTime(2026, 4, 18)),
  _HijriMonthStart(1447, 12, DateTime(2026, 5, 18)),
  _HijriMonthStart(1448, 1, DateTime(2026, 6, 16)),
  _HijriMonthStart(1448, 2, DateTime(2026, 7, 16)),
  _HijriMonthStart(1448, 3, DateTime(2026, 8, 14)),
  _HijriMonthStart(1448, 4, DateTime(2026, 9, 12)),
  _HijriMonthStart(1448, 5, DateTime(2026, 10, 12)),
  _HijriMonthStart(1448, 6, DateTime(2026, 11, 11)),
  _HijriMonthStart(1448, 7, DateTime(2026, 12, 10)),
];

double _islamicToJulianDay(int year, int month, int day) {
  return day +
      (29.5 * (month - 1)).ceil() +
      (year - 1) * 354 +
      ((3 + 11 * year) / 30).floor() +
      1948439.5 -
      1;
}

double _gregorianToJulianDay(int year, int month, int day) {
  final a = ((14 - month) / 12).floor();
  final y = year + 4800 - a;
  final m = month + 12 * a - 3;
  return day +
      ((153 * m + 2) / 5).floor() +
      365 * y +
      (y / 4).floor() -
      (y / 100).floor() +
      (y / 400).floor() -
      32045;
}

DateTime _julianDayToGregorian(int jd) {
  final a = jd + 32044;
  final b = ((4 * a + 3) / 146097).floor();
  final c = a - ((146097 * b) / 4).floor();
  final d = ((4 * c + 3) / 1461).floor();
  final e = c - ((1461 * d) / 4).floor();
  final m = ((5 * e + 2) / 153).floor();
  final day = e - ((153 * m + 2) / 5).floor() + 1;
  final month = m + 3 - 12 * (m / 10).floor();
  final year = 100 * b + d - 4800 + (m / 10).floor();
  return DateTime(year, month, day);
}

String islamicMonthName(int month) {
  const months = [
    'Muharram',
    'Safar',
    'Rabi ul Awwal',
    'Rabi us Sani',
    'Jamadi ul Awwal',
    'Jamadi us Sani',
    'Rajab',
    'Shaban',
    'Ramadhan',
    'Shawwal',
    'Zilqad',
    'Zilhajj',
  ];
  if (month < 1 || month > months.length) return '';
  return months[month - 1];
}

String islamicMonthShortName(int month) {
  const months = [
    'Muh',
    'Saf',
    'Rab I',
    'Rab II',
    'Jam I',
    'Jam II',
    'Raj',
    'Sha',
    'Ram',
    'Shaw',
    'Ziq',
    'Zih',
  ];
  if (month < 1 || month > months.length) return '';
  return months[month - 1];
}
