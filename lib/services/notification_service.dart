import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../data/models/models.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static const String _azanChannelId = 'shia_jafria_azan_channel_v4';
  static const String _azanSound = 'shia_azan_01';
  static const int _notificationFlagInsistent = 4;
  late FlutterLocalNotificationsPlugin _notificationsPlugin;
  bool _initialized = false;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize() async {
    if (_initialized) return;
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    tzdata.initializeTimeZones();
    _setLocalTimeZone();

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
    await _createAndroidChannels();

    // Android 13+ needs runtime notification permission. Some Android 10/11
    // vendor builds throw here, so never let permission probing block alarms.
    try {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } catch (error, stackTrace) {
      developer.log(
        'Notification permission request was skipped/failed',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
    }
    try {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestFullScreenIntentPermission();
    } catch (error, stackTrace) {
      developer.log(
        'Full screen alert permission request was skipped/failed',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
    }
    await _requestExactAlarmPermissionIfNeeded();
    _initialized = true;
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
      final now = DateTime.now();
      if (scheduledTime != null && scheduledTime.isAfter(now)) {
        await scheduleAzanNotification(
          id: id,
          prayerName: entry.key,
          scheduledTime: scheduledTime,
        );
      } else if (scheduledTime != null &&
          now.difference(scheduledTime).inMinutes >= 0 &&
          now.difference(scheduledTime).inMinutes <= 2) {
        await showAzanNow(id: id, prayerName: entry.key);
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
      await initialize();
      await _zonedScheduleWithFallback(
        id: id,
        title: 'Azan - $prayerName',
        body: '$prayerName namaz ka waqt ho gaya hai.',
        scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
        notificationDetails: NotificationDetails(
          android: _azanAndroidNotificationDetails(),
          iOS: const DarwinNotificationDetails(
            presentSound: true,
          ),
        ),
      );
    } catch (error, stackTrace) {
      developer.log(
        'Failed to schedule azan notification',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
    }
  }

  Future<void> showAzanNow({
    required int id,
    required String prayerName,
  }) async {
    try {
      await initialize();
      await _notificationsPlugin.show(
        id: id,
        title: 'Azan - $prayerName',
        body: '$prayerName namaz ka waqt ho gaya hai.',
        notificationDetails: NotificationDetails(
          android: _azanAndroidNotificationDetails(),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
          ),
        ),
      );
    } catch (error, stackTrace) {
      developer.log(
        'Failed to show azan notification now',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
    }
  }

  AndroidNotificationDetails _azanAndroidNotificationDetails() {
    return AndroidNotificationDetails(
      _azanChannelId,
      'Fiqa Jafria Azan Notifications',
      channelDescription:
          'Prayer time alerts with Shia Fiqa Jafria azan sound until stopped',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound(_azanSound),
      audioAttributesUsage: AudioAttributesUsage.alarm,
      enableVibration: true,
      category: AndroidNotificationCategory.alarm,
      ticker: 'Azan - Namaz time',
      visibility: NotificationVisibility.public,
      fullScreenIntent: true,
      autoCancel: true,
      ongoing: false,
      showWhen: true,
      usesChronometer: true,
      colorized: true,
      additionalFlags: Int32List.fromList(<int>[_notificationFlagInsistent]),
      actions: const <AndroidNotificationAction>[
        AndroidNotificationAction(
          'stop_azan',
          'Stop Azan',
          cancelNotification: true,
        ),
      ],
    );
  }

  Future<void> _zonedScheduleWithFallback({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails notificationDetails,
  }) async {
    try {
      await initialize();
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        notificationDetails: notificationDetails,
      );
    } catch (_) {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        notificationDetails: notificationDetails,
      );
    }
  }

  Future<void> _requestExactAlarmPermissionIfNeeded() async {
    final android = _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return;

    try {
      final canSchedule = await android.canScheduleExactNotifications();
      if (canSchedule == false) {
        await android.requestExactAlarmsPermission();
      }
    } catch (error, stackTrace) {
      developer.log(
        'Failed to schedule event notification',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
    }
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

  Future<void> showEventNow({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      await initialize();
      await _notificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'event_channel',
            'Event Notifications',
            channelDescription: 'Notifications for Islamic events',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
          ),
        ),
      );
    } catch (error, stackTrace) {
      developer.log(
        'Failed to show event notification',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      await initialize();
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
    } catch (error, stackTrace) {
      developer.log(
        'Failed to show notification',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
    }
  }

  Future<void> cancelNotification(int id) async {
    await initialize();
    await _notificationsPlugin.cancel(id: id);
  }

  Future<void> cancelAllNotifications() async {
    await initialize();
    await _notificationsPlugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    await initialize();
    return await _notificationsPlugin.pendingNotificationRequests();
  }

  Future<void> _createAndroidChannels() async {
    final android = _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return;

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _azanChannelId,
        'Fiqa Jafria Azan Notifications',
        description: 'Prayer time alerts with Shia Fiqa Jafria azan sound',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(_azanSound),
        audioAttributesUsage: AudioAttributesUsage.alarm,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        'event_channel',
        'Event Notifications',
        description: 'Notifications for Islamic events',
        importance: Importance.high,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        'general_channel',
        'General Notifications',
        description: 'General app notifications',
        importance: Importance.defaultImportance,
      ),
    );
  }

  void _setLocalTimeZone() {
    final timeZoneName = _resolveDeviceTimeZoneName();
    try {
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  String _resolveDeviceTimeZoneName() {
    final now = DateTime.now();
    final abbreviation = now.timeZoneName.toUpperCase();
    final minutes = now.timeZoneOffset.inMinutes;

    if (abbreviation == 'PKT' || minutes == 300) return 'Asia/Karachi';
    if (abbreviation == 'IST' && minutes == 330) return 'Asia/Kolkata';
    if (abbreviation == 'BST' && minutes == 360) return 'Asia/Dhaka';
    if (abbreviation == 'GST' && minutes == 240) return 'Asia/Dubai';
    if (abbreviation == 'AST' && minutes == 180) return 'Asia/Riyadh';
    if (abbreviation == 'CET' && minutes == 60) return 'Europe/Paris';
    if (abbreviation == 'CEST' && minutes == 120) return 'Europe/Paris';
    if (abbreviation == 'EET' && minutes == 120) return 'Europe/Cairo';
    if (abbreviation == 'EEST' && minutes == 180) return 'Europe/Athens';
    if (abbreviation == 'EST' && minutes == -300) return 'America/New_York';
    if (abbreviation == 'EDT' && minutes == -240) return 'America/New_York';
    if (abbreviation == 'CST' && minutes == -360) return 'America/Chicago';
    if (abbreviation == 'CDT' && minutes == -300) return 'America/Chicago';
    if (abbreviation == 'MST' && minutes == -420) return 'America/Denver';
    if (abbreviation == 'MDT' && minutes == -360) return 'America/Denver';
    if (abbreviation == 'PST' && minutes == -480) return 'America/Los_Angeles';
    if (abbreviation == 'PDT' && minutes == -420) return 'America/Los_Angeles';

    return 'UTC';
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
