import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_service.dart';

class EventNotificationService {
  EventNotificationService({NotificationService? notificationService})
      : _notificationService = notificationService ?? NotificationService();

  final NotificationService _notificationService;

  static const int _firstEventNotificationId = 3000;
  static const int _maxScheduledEvents = 120;

  Future<void> scheduleUpcomingEventNotifications() async {
    final events = await _loadEvents();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentHijri = _hijriFromGregorian(now);
    final prefs = await SharedPreferences.getInstance();

    for (var id = _firstEventNotificationId;
        id < _firstEventNotificationId + _maxScheduledEvents;
        id++) {
      await _notificationService.cancelNotification(id);
    }

    final upcoming = events
        .where((event) => event.notificationEnabled)
        .map((event) => _ScheduledIslamicEvent(
              event: event,
              eventDate: _nextGregorianDate(event, currentHijri),
            ))
        .where((item) => !item.eventDate.isBefore(today))
        .toList()
      ..sort((a, b) => a.eventDate.compareTo(b.eventDate));

    var notificationId = _firstEventNotificationId;
    for (final item in upcoming.take(_maxScheduledEvents)) {
      var alertTime = _alertDateTime(item.event, item.eventDate);
      final title = 'Islamic Event - ${item.event.title}';
      final body = _eventNotificationBody(item.event, item.eventDate);

      if (!alertTime.isAfter(now) && item.eventDate.isAfter(today)) {
        final eventDayAlertTime = _eventDayAlertDateTime(
          item.event,
          item.eventDate,
        );
        if (eventDayAlertTime.isAfter(now)) {
          alertTime = eventDayAlertTime;
        }
      }

      if (alertTime.isAfter(now)) {
        await _notificationService.scheduleEventNotification(
          id: notificationId,
          eventName: title,
          scheduledTime: alertTime,
          description: body,
        );
        notificationId += 1;
        continue;
      }

      final isToday = item.eventDate.year == today.year &&
          item.eventDate.month == today.month &&
          item.eventDate.day == today.day;
      final shownKey =
          'event_notification_shown_${item.event.id}_${today.toIso8601String()}';
      if (isToday && prefs.getBool(shownKey) != true) {
        await _notificationService.showEventNow(
          id: notificationId,
          title: title,
          body: body,
        );
        await prefs.setBool(shownKey, true);
        notificationId += 1;
      }
    }
  }

  Future<List<_IslamicEventNotificationItem>> _loadEvents() async {
    final indexString =
        await rootBundle.loadString('assets/json/events/index.json');
    final index = json.decode(indexString) as Map<String, dynamic>;
    final items =
        List<Map<String, dynamic>>.from(index['items'] as List? ?? []);
    final files = items.map((item) => item['file'] as String? ?? '').toSet()
      ..remove('');
    final events = <_IslamicEventNotificationItem>[];

    for (final file in files) {
      final fileString =
          await rootBundle.loadString('assets/json/events/$file');
      final data = json.decode(fileString) as Map<String, dynamic>;
      final monthEvents =
          List<Map<String, dynamic>>.from(data['events'] as List? ?? []);
      events.addAll(monthEvents.map(_IslamicEventNotificationItem.fromJson));
    }

    return events;
  }

  DateTime _alertDateTime(
    _IslamicEventNotificationItem event,
    DateTime eventDate,
  ) {
    return _eventDayAlertDateTime(event, eventDate)
        .subtract(Duration(days: event.notificationDaysBefore));
  }

  DateTime _eventDayAlertDateTime(
    _IslamicEventNotificationItem event,
    DateTime eventDate,
  ) {
    final notificationTime = _parseNotificationTime(event.notificationTime);
    return DateTime(
      eventDate.year,
      eventDate.month,
      eventDate.day,
      notificationTime.hour,
      notificationTime.minute,
    );
  }

  _ClockTime _parseNotificationTime(String raw) {
    final match = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(raw.trim());
    if (match == null) return const _ClockTime(9, 0);

    final hour = int.tryParse(match.group(1)!) ?? 9;
    final minute = int.tryParse(match.group(2)!) ?? 0;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return const _ClockTime(9, 0);
    }
    return _ClockTime(hour, minute);
  }

  String _eventNotificationBody(
    _IslamicEventNotificationItem event,
    DateTime eventDate,
  ) {
    final date = '${eventDate.day.toString().padLeft(2, '0')}-'
        '${eventDate.month.toString().padLeft(2, '0')}-${eventDate.year}';
    final parts = [
      '${event.hijriDay} ${_monthName(event.hijriMonthNumber)}',
      date,
      DateTime.now().timeZoneName,
      if (event.relatedPersonality.isNotEmpty) event.relatedPersonality,
    ];
    return parts.join(' - ');
  }
}

class _IslamicEventNotificationItem {
  final String id;
  final String title;
  final int hijriMonthNumber;
  final int hijriDay;
  final String relatedPersonality;
  final bool notificationEnabled;
  final int notificationDaysBefore;
  final String notificationTime;

  const _IslamicEventNotificationItem({
    required this.id,
    required this.title,
    required this.hijriMonthNumber,
    required this.hijriDay,
    required this.relatedPersonality,
    required this.notificationEnabled,
    required this.notificationDaysBefore,
    required this.notificationTime,
  });

  factory _IslamicEventNotificationItem.fromJson(Map<String, dynamic> json) {
    final notification = json['notification'] as Map<String, dynamic>? ?? {};
    return _IslamicEventNotificationItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Islamic Event',
      hijriMonthNumber: json['hijriMonthNumber'] as int? ?? 0,
      hijriDay: json['hijriDay'] as int? ?? 0,
      relatedPersonality: json['relatedPersonality'] as String? ?? '',
      notificationEnabled: notification['enabled'] as bool? ?? true,
      notificationDaysBefore: notification['daysBefore'] as int? ?? 1,
      notificationTime: notification['time'] as String? ?? '09:00',
    );
  }
}

class _ScheduledIslamicEvent {
  final _IslamicEventNotificationItem event;
  final DateTime eventDate;

  const _ScheduledIslamicEvent({
    required this.event,
    required this.eventDate,
  });
}

class _ClockTime {
  final int hour;
  final int minute;

  const _ClockTime(this.hour, this.minute);
}

class _HijriDate {
  final int year;
  final int month;
  final int day;

  const _HijriDate(this.year, this.month, this.day);
}

DateTime _nextGregorianDate(
  _IslamicEventNotificationItem event,
  _HijriDate currentHijri,
) {
  var hijriYear = currentHijri.year;
  var date =
      _gregorianFromHijri(hijriYear, event.hijriMonthNumber, event.hijriDay);
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  if (date.isBefore(todayDate)) {
    hijriYear += 1;
    date =
        _gregorianFromHijri(hijriYear, event.hijriMonthNumber, event.hijriDay);
  }
  return date;
}

_HijriDate _hijriFromGregorian(DateTime date) {
  final jd = _gregorianToJulianDay(date.year, date.month, date.day);
  final year = ((30 * (jd - 1948439.5) + 10646) / 10631).floor();
  final month = math.min(
    12,
    ((jd - (29 + _islamicToJulianDay(year, 1, 1))) / 29.5).ceil() + 1,
  );
  final day = (jd - _islamicToJulianDay(year, month, 1) + 1).floor();
  return _HijriDate(year, month, day);
}

DateTime _gregorianFromHijri(int year, int month, int day) {
  final jd = _islamicToJulianDay(year, month, day).floor();
  return _julianDayToGregorian(jd);
}

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

String _monthName(int month) {
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
