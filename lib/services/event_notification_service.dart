import 'package:shared_preferences/shared_preferences.dart';

import 'islamic_event_calendar_service.dart';
import 'notification_service.dart';

class EventNotificationService {
  EventNotificationService({NotificationService? notificationService})
      : _notificationService = notificationService ?? NotificationService();

  final NotificationService _notificationService;

  static const int _firstEventNotificationId = 3000;
  static const int _maxScheduledEvents = 180;

  Future<void> scheduleUpcomingEventNotifications() async {
    final events = await IslamicEventCalendarService.instance.loadEvents();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('event_notification_legacy_range_cleared_v2') != true) {
      for (var id = _firstEventNotificationId;
          id < _firstEventNotificationId + 120;
          id++) {
        await _notificationService.cancelNotification(id);
      }
      await prefs.setBool('event_notification_legacy_range_cleared_v2', true);
    }

    final upcoming = events
        .where((event) => event.notificationEnabled)
        .map((event) => _ScheduledIslamicEvent(
              event: event,
              eventDate:
                  IslamicEventCalendarService.instance.nextGregorianDate(event),
            ))
        .where((item) => !item.eventDate.isBefore(today))
        .toList()
      ..sort((a, b) => a.eventDate.compareTo(b.eventDate));

    for (final item in upcoming.take(_maxScheduledEvents)) {
      var alertTime = _alertDateTime(item.event, item.eventDate);
      final title = 'Islamic Event - ${item.event.title}';
      final body = _eventNotificationBody(item.event, item.eventDate);
      final notificationId = _notificationIdForEvent(
        item.event,
        item.eventDate,
        item.event.notificationDaysBefore,
      );

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
      }
    }
  }

  int _notificationIdForEvent(
    IslamicCalendarEvent event,
    DateTime eventDate,
    int daysBefore,
  ) {
    final raw = '${event.id}|${eventDate.toIso8601String()}|$daysBefore';
    return _firstEventNotificationId + (raw.hashCode & 0x3fffffff);
  }

  DateTime _alertDateTime(
    IslamicCalendarEvent event,
    DateTime eventDate,
  ) {
    return _eventDayAlertDateTime(event, eventDate)
        .subtract(Duration(days: event.notificationDaysBefore));
  }

  DateTime _eventDayAlertDateTime(
    IslamicCalendarEvent event,
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
    IslamicCalendarEvent event,
    DateTime eventDate,
  ) {
    final date = '${eventDate.day.toString().padLeft(2, '0')}-'
        '${eventDate.month.toString().padLeft(2, '0')}-${eventDate.year}';
    final parts = [
      '${event.hijriDay} ${islamicMonthName(event.hijriMonthNumber)}',
      date,
      DateTime.now().timeZoneName,
      if (event.relatedPersonality.isNotEmpty) event.relatedPersonality,
    ];
    return parts.join(' - ');
  }
}

class _ScheduledIslamicEvent {
  final IslamicCalendarEvent event;
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
