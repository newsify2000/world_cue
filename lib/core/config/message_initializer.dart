import 'dart:convert';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    if (e is FirebaseException && e.code == 'duplicate-app') {
      // Already initialized, safe to ignore
    } else {
      rethrow;
    }
  }

  // ✅ Always run notification code here
  var data = message.data;
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'World Cue Notification',
        'World Cue Notification Channel',
        channelDescription: 'World Cue Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'notification',
        color: Color(0xFFEC0A0A),
      );
  const DarwinNotificationDetails iOSNotificationDetails =
      DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
  var jsonData = jsonEncode(data);
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iOSNotificationDetails,
  );

  FlutterLocalNotificationsPlugin().show(
    message.hashCode,
    data['title'],
    data['message'],
    notificationDetails,
    payload: jsonData,
  );
}
