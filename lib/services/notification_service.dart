import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
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

  Future<void> scheduleAzanNotification({
    required int id,
    required String prayerName,
    required DateTime scheduledTime,
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: 'Azan Time',
        body: 'Time for $prayerName Prayer',
        scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'azan_channel',
            'Azan Notifications',
            channelDescription: 'Notifications for prayer times',
            importance: Importance.high,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound('azan'),
          ),
          iOS: DarwinNotificationDetails(
            sound: 'azan.wav',
          ),
        ),
      );
    } catch (e) {
      print('Error scheduling azan notification: $e');
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
    } catch (e) {
      print('Error scheduling event notification: $e');
    }
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
    } catch (e) {
      print('Error showing notification: $e');
    }
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
}
