import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../data/models/models.dart';

class NotificationScheduleDebugEntry {
  final int id;
  final String title;
  final DateTime scheduledTime;
  final bool pendingInOs;

  const NotificationScheduleDebugEntry({
    required this.id,
    required this.title,
    required this.scheduledTime,
    required this.pendingInOs,
  });
}

class NotificationRuntimeStatus {
  final bool notificationsEnabled;
  final bool exactAlarmsEnabled;

  const NotificationRuntimeStatus({
    required this.notificationsEnabled,
    required this.exactAlarmsEnabled,
  });
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  static const String _azanChannelId = 'shia_jafria_azan_channel_v6';
  static const String azanChannelId = _azanChannelId;
  static const String _eventChannelId = 'event_channel_v2';
  static const String _generalChannelId = 'general_channel';
  static const String _azanSound = 'shia_azan_01';
  static const List<String> _legacyAzanChannelIds = <String>[
    'shia_jafria_azan_channel',
    'shia_jafria_azan_channel_v2',
    'shia_jafria_azan_channel_v3',
    'shia_jafria_azan_channel_v4',
    'shia_jafria_azan_channel_v5',
  ];
  static const int _notificationFlagInsistent = 4;
  static const int _maxPrayerScheduleDays = 30;
  static const String _prayerSchedulePrefsKey = 'scheduled_prayer_alerts_v3';
  static const String _eventSchedulePrefsKey = 'scheduled_event_alerts_v2';

  late FlutterLocalNotificationsPlugin _notificationsPlugin;
  bool _initialized = false;

  factory NotificationService() => _instance;

  NotificationService._internal();

  Future<void> initialize({String? timeZoneName}) async {
    if (_initialized) {
      if (timeZoneName != null) await setLocalTimeZone(timeZoneName);
      return;
    }

    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    tzdata.initializeTimeZones();
    await setLocalTimeZone(timeZoneName);

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _notificationsPlugin.initialize(settings: settings);
    await _createAndroidChannels();
    _initialized = true;
  }

  Future<bool> requestNotificationPermissions() async {
    var allowed = true;
    final android = _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      // Some Huawei Android builds crash inside the plugin permission method
      // because the platform side receives a null Activity context. Android 12
      // and below do not need POST_NOTIFICATIONS, while Android 13+ users can
      // still enable alerts from system settings if the OEM blocks prompting.
      return allowed;
    }

    final iOS = _notificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (iOS != null) {
      allowed = await iOS.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          allowed;
    }
    return allowed;
  }

  Future<void> setLocalTimeZone(String? timeZoneName) async {
    final resolved = timeZoneName ?? await _resolveDeviceTimeZoneName();
    try {
      tz.setLocalLocation(tz.getLocation(resolved));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  Future<void> schedulePrayerNotifications(PrayerTime prayerTime) async {
    await schedulePrayerNotificationsForDays([prayerTime]);
  }

  Future<void> schedulePrayerNotificationsForDays(
    List<PrayerTime> prayerTimes, {
    String? timeZoneName,
  }) async {
    await initialize(timeZoneName: timeZoneName);
    final now = DateTime.now();
    final pendingIds =
        (await getPendingNotifications()).map((item) => item.id).toSet();
    final previousRecords = await _loadScheduleRecords(_prayerSchedulePrefsKey);
    final expectedRecords = <_ScheduleRecord>[];
    final sortedPrayerTimes = prayerTimes.toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    for (var dayIndex = 0;
        dayIndex < sortedPrayerTimes.length &&
            dayIndex < _maxPrayerScheduleDays;
        dayIndex++) {
      final prayerTime = sortedPrayerTimes[dayIndex];
      final prayers = <String, String>{
        'Fajar': prayerTime.fajr,
        'Zuhr': prayerTime.dhuhr,
        'Asr': prayerTime.asr,
        'Maghrib': prayerTime.maghrib,
        'Isha': prayerTime.isha,
      };

      for (final entry in prayers.entries) {
        final scheduledTime = _dateTimeForPrayer(prayerTime.date, entry.value);
        if (scheduledTime == null) continue;
        final id = prayerNotificationId(prayerTime.date, entry.key);
        final title = 'Azan - ${entry.key}';
        final body = '${entry.key} namaz ka waqt ho gaya hai.';
        final record = _ScheduleRecord(
          id: id,
          title: title,
          scheduledTime: scheduledTime,
          category: 'prayer',
        );
        expectedRecords.add(record);

        final previous = previousRecords[id];
        final alreadyScheduled =
            previous?.scheduledTime.millisecondsSinceEpoch ==
                    scheduledTime.millisecondsSinceEpoch &&
                pendingIds.contains(id);

        if (scheduledTime.isBefore(now)) {
          continue;
        }
        if (alreadyScheduled) {
          continue;
        }

        await cancelNotification(id);
        await _zonedScheduleWithFallback(
          id: id,
          title: title,
          body: body,
          scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
          preferAlarmClock: true,
          notificationDetails: NotificationDetails(
            android: _azanAndroidNotificationDetails(),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentSound: true,
              interruptionLevel: InterruptionLevel.timeSensitive,
            ),
          ),
        );
      }
    }

    final expectedIds = expectedRecords.map((record) => record.id).toSet();
    for (final oldId in previousRecords.keys) {
      if (!expectedIds.contains(oldId)) {
        await cancelNotification(oldId);
      }
    }
    await _saveScheduleRecords(_prayerSchedulePrefsKey, expectedRecords);
  }

  int prayerNotificationId(DateTime date, String prayerName) {
    final dateKey = date.year * 10000 + date.month * 100 + date.day;
    final prayerIndex = switch (prayerName.toLowerCase()) {
      'fajr' => 1,
      'fajar' => 1,
      'dhuhr' => 2,
      'zuhr' => 2,
      'asr' => 3,
      'maghrib' => 4,
      'isha' => 5,
      _ => 9,
    };
    return dateKey * 10 + prayerIndex;
  }

  Future<void> scheduleAzanNotification({
    required int id,
    required String prayerName,
    required DateTime scheduledTime,
  }) async {
    await initialize();
    await _zonedScheduleWithFallback(
      id: id,
      title: 'Azan - $prayerName',
      body: '$prayerName namaz ka waqt ho gaya hai.',
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      preferAlarmClock: true,
      notificationDetails: NotificationDetails(
        android: _azanAndroidNotificationDetails(),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      ),
    );
  }

  Future<void> showAzanNow({
    required int id,
    required String prayerName,
  }) async {
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
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      ),
    );
  }

  Future<void> showAzanPushNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await initialize();
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: _azanAndroidNotificationDetails(),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      ),
    );
  }

  Future<void> scheduleEventNotification({
    required int id,
    required String eventName,
    required DateTime scheduledTime,
    String? description,
  }) async {
    await initialize();
    final records = await _loadScheduleRecords(_eventSchedulePrefsKey);
    final existing = records[id];
    final pendingIds =
        (await getPendingNotifications()).map((item) => item.id).toSet();
    if (existing?.scheduledTime.millisecondsSinceEpoch ==
            scheduledTime.millisecondsSinceEpoch &&
        pendingIds.contains(id)) {
      return;
    }

    await cancelNotification(id);
    await _zonedScheduleWithFallback(
      id: id,
      title: eventName,
      body: description ?? 'Islamic Event',
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _eventChannelId,
          'Event Notifications',
          channelDescription: 'Notifications for Islamic events',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          category: AndroidNotificationCategory.reminder,
          visibility: NotificationVisibility.public,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
    );
    records[id] = _ScheduleRecord(
      id: id,
      title: eventName,
      scheduledTime: scheduledTime,
      category: 'event',
    );
    await _saveScheduleRecords(_eventSchedulePrefsKey, records.values.toList());
  }

  Future<void> showEventNow({
    required int id,
    required String title,
    required String body,
  }) async {
    await initialize();
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _eventChannelId,
          'Event Notifications',
          channelDescription: 'Notifications for Islamic events',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await initialize();
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _generalChannelId,
          'General Notifications',
          channelDescription: 'General app notifications',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> cancelNotification(int id) async {
    await initialize();
    await _notificationsPlugin.cancel(id: id);
  }

  Future<void> cancelAllNotifications() async {
    await initialize();
    await _notificationsPlugin.cancelAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prayerSchedulePrefsKey);
    await prefs.remove(_eventSchedulePrefsKey);
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    await initialize();
    return _notificationsPlugin.pendingNotificationRequests();
  }

  Future<NotificationRuntimeStatus> getRuntimeStatus() async {
    await initialize();
    final android = _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) {
      return const NotificationRuntimeStatus(
        notificationsEnabled: true,
        exactAlarmsEnabled: true,
      );
    }

    var notificationsEnabled = true;
    var exactAlarmsEnabled = true;
    try {
      notificationsEnabled = await android.areNotificationsEnabled() ?? true;
    } catch (_) {}
    try {
      exactAlarmsEnabled =
          await android.canScheduleExactNotifications() ?? true;
    } catch (_) {}
    return NotificationRuntimeStatus(
      notificationsEnabled: notificationsEnabled,
      exactAlarmsEnabled: exactAlarmsEnabled,
    );
  }

  Future<List<NotificationScheduleDebugEntry>> getPrayerScheduleDebug() async {
    await initialize();
    final records = await _loadScheduleRecords(_prayerSchedulePrefsKey);
    final pendingIds =
        (await getPendingNotifications()).map((item) => item.id).toSet();
    final upcoming = records.values
        .where((record) => record.scheduledTime.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    return upcoming
        .map(
          (record) => NotificationScheduleDebugEntry(
            id: record.id,
            title: record.title,
            scheduledTime: record.scheduledTime,
            pendingInOs: pendingIds.contains(record.id),
          ),
        )
        .toList();
  }

  AndroidNotificationDetails _azanAndroidNotificationDetails() {
    return AndroidNotificationDetails(
      _azanChannelId,
      'Fiqa Jafria Azan Notifications',
      channelDescription: 'Prayer time alerts with Shia azan sound',
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
      usesChronometer: false,
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
    bool preferAlarmClock = false,
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        androidScheduleMode: preferAlarmClock
            ? AndroidScheduleMode.alarmClock
            : AndroidScheduleMode.exactAllowWhileIdle,
        notificationDetails: notificationDetails,
      );
    } catch (error, stackTrace) {
      developer.log(
        'Exact notification scheduling failed; using inexact fallback',
        error: error,
        stackTrace: stackTrace,
        name: 'NotificationService',
      );
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

  Future<void> _createAndroidChannels() async {
    final android = _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return;

    for (final channelId in _legacyAzanChannelIds) {
      try {
        await android.deleteNotificationChannel(channelId: channelId);
      } catch (_) {}
    }

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _azanChannelId,
        'Fiqa Jafria Azan Notifications',
        description: 'Prayer time alerts with Shia azan sound',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(_azanSound),
        audioAttributesUsage: AudioAttributesUsage.alarm,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _eventChannelId,
        'Event Notifications',
        description: 'Notifications for Islamic events',
        importance: Importance.high,
        playSound: true,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        _generalChannelId,
        'General Notifications',
        description: 'General app notifications',
        importance: Importance.defaultImportance,
      ),
    );
  }

  Future<String> _resolveDeviceTimeZoneName() async {
    try {
      return (await FlutterTimezone.getLocalTimezone()).identifier;
    } catch (_) {
      final now = DateTime.now();
      final abbreviation = now.timeZoneName.toUpperCase();
      final minutes = now.timeZoneOffset.inMinutes;
      if (abbreviation == 'PKT' || minutes == 300) return 'Asia/Karachi';
      if (abbreviation == 'IST' && minutes == 330) return 'Asia/Kolkata';
      if (abbreviation == 'BST' && minutes == 360) return 'Asia/Dhaka';
      if (abbreviation == 'GST' && minutes == 240) return 'Asia/Dubai';
      if (abbreviation == 'EST' && minutes == -300) return 'America/New_York';
      if (abbreviation == 'EDT' && minutes == -240) return 'America/New_York';
      return 'UTC';
    }
  }

  DateTime? _dateTimeForPrayer(DateTime date, String displayTime) {
    final parts = displayTime.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    if (hour > 23 || minute > 59) return null;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  Future<Map<int, _ScheduleRecord>> _loadScheduleRecords(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return {};
    try {
      final items = json.decode(raw) as List<dynamic>;
      return {
        for (final item in items.whereType<Map<String, dynamic>>())
          _ScheduleRecord.fromJson(item).id: _ScheduleRecord.fromJson(item),
      };
    } catch (_) {
      return {};
    }
  }

  Future<void> _saveScheduleRecords(
    String key,
    List<_ScheduleRecord> records,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      key,
      json.encode(records.map((record) => record.toJson()).toList()),
    );
  }
}

class _ScheduleRecord {
  final int id;
  final String title;
  final DateTime scheduledTime;
  final String category;

  const _ScheduleRecord({
    required this.id,
    required this.title,
    required this.scheduledTime,
    required this.category,
  });

  factory _ScheduleRecord.fromJson(Map<String, dynamic> json) {
    return _ScheduleRecord(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      scheduledTime:
          DateTime.tryParse(json['scheduledTime'] as String? ?? '') ??
              DateTime.fromMillisecondsSinceEpoch(0),
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'scheduledTime': scheduledTime.toIso8601String(),
      'category': category,
    };
  }
}
