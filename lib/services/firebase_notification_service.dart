import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    await NotificationService().showAzanPushNotification(
      id: _notificationIdFor(message),
      title: _titleFor(message),
      body: _bodyFor(message),
    );
  } catch (error, stackTrace) {
    developer.log(
      'Firebase background message skipped',
      error: error,
      stackTrace: stackTrace,
      name: 'FirebaseNotificationService',
    );
  }
}

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(_showForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_logOpenedMessage);

      final token = await messaging.getToken();
      developer.log(
        'Firebase messaging token: ${token ?? 'not available'}',
        name: 'FirebaseNotificationService',
      );

      _initialized = true;
    } catch (error, stackTrace) {
      developer.log(
        'Firebase is not configured yet. Add android/app/google-services.json '
        'and run FlutterFire setup to enable FCM.',
        error: error,
        stackTrace: stackTrace,
        name: 'FirebaseNotificationService',
      );
    }
  }

  Future<void> _showForegroundMessage(RemoteMessage message) async {
    await NotificationService().showAzanPushNotification(
      id: _notificationIdFor(message),
      title: _titleFor(message),
      body: _bodyFor(message),
    );
  }

  void _logOpenedMessage(RemoteMessage message) {
    developer.log(
      'Firebase notification opened: ${message.messageId ?? 'unknown'}',
      name: 'FirebaseNotificationService',
    );
  }
}

int _notificationIdFor(RemoteMessage message) {
  return (message.messageId?.hashCode ??
          DateTime.now().millisecondsSinceEpoch) &
      0x7fffffff;
}

String _titleFor(RemoteMessage message) {
  return message.notification?.title ?? message.data['title'] ?? 'Haqaiq';
}

String _bodyFor(RemoteMessage message) {
  return message.notification?.body ??
      message.data['body'] ??
      'New notification';
}
