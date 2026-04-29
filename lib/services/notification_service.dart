import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../data/models/models.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static const String _azanChannelId = 'shia_jafria_azan_channel_v1';
  static const String _azanSound = 'shia_azan_01';
  late FlutterLocalNotificationsPlugin _notificationsPlugin;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize() async {
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    tzdata.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _notificationsPlugin.initialize(settings: settings);

    // Request permissions
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> schedulePrayerNotifications(PrayerTime prayerTime) async {
    final prayers = <String, String>{
      'Fajr': prayerTime.fajr,
      'Dhuhr': prayerTime.dhuhr,
      'Asr': prayerTime.asr,
      'Maghrib': prayerTime.maghrib,
      'Isha': prayerTime.isha,
    };

    var id = 2100;
    for (final entry in prayers.entries) {
      await cancelNotification(id);
      final scheduledTime = _dateTimeForPrayer(prayerTime.date, entry.value);
      if (scheduledTime != null && scheduledTime.isAfter(DateTime.now())) {
        await scheduleAzanNotification(
          id: id,
          prayerName: entry.key,
          scheduledTime: scheduledTime,
        );
      }
      id += 1;
    }
  }

  Future<void> scheduleAzanNotification({
    required int id,
    required String prayerName,
    required DateTime scheduledTime,
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: 'Azan - $prayerName',
        body: 'Time for $prayerName prayer. Hayya alas-salah.',
        scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _azanChannelId,
            'Fiqa Jafria Azan Notifications',
            channelDescription:
                'Prayer time alerts with Shia Fiqa Jafria azan sound',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            sound: RawResourceAndroidNotificationSound(_azanSound),
            audioAttributesUsage: AudioAttributesUsage.alarm,
            enableVibration: true,
            category: AndroidNotificationCategory.alarm,
          ),
          iOS: DarwinNotificationDetails(
            presentSound: true,
          ),
        ),
      );
    } catch (_) {}
  }

  Future<void> scheduleEventNotification({
    required int id,
    required String eventName,
    required DateTime scheduledTime,
    String? description,
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: eventName,
        body: description ?? 'Islamic Event',
        scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'event_channel',
            'Event Notifications',
            channelDescription: 'Notifications for Islamic events',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
    } catch (_) {}
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      await _notificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'general_channel',
            'General Notifications',
            channelDescription: 'General app notifications',
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
    } catch (_) {}
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notificationsPlugin.pendingNotificationRequests();
  }

  DateTime? _dateTimeForPrayer(DateTime date, String displayTime) {
    final match =
        RegExp(r'^(\d{1,2}):(\d{2})(?:\s*(AM|PM))?$', caseSensitive: false)
            .firstMatch(displayTime.trim());
    if (match == null) return null;

    var hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final period = match.group(3)?.toUpperCase();
    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;
    if (hour > 23 || minute > 59) return null;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
