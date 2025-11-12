import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/utils/constants.dart';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  await FlutterLocalNotificationsPlugin().cancelAll();

  var notificationPayload = notificationResponse.payload!;
  if (notificationPayload.isNotEmpty) {
    Map valueMap = jsonDecode(notificationPayload);
    log('Notification Clicked with data: $valueMap');
    // HomeController homeController = Get.put(HomeController()); // get from bindings
    // Utils.serializeAndNavigate(valueMap, homeController);
    // Utils.tappedNotificationPayload = notificationResponse.payload;
    // Utils.launchedFromNotification = true;
  }
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final StreamController<List<String>> _controller =
      StreamController.broadcast();

  Stream<List<String>> get behaviorSubject => _controller.stream;

  Future<void> _isPermissionsGranted() async {
    if (Platform.isAndroid) {
      final androidImplementation = FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      final isGranted =
          await androidImplementation?.areNotificationsEnabled() ?? false;

      if (!isGranted) {
        // 🔥 Explicitly request permission
        final granted = await androidImplementation
            ?.requestNotificationsPermission();
        log('🔔 Android Notification Permission granted: $granted');
      }
    } else if (Platform.isIOS) {
      NotificationSettings settings = await FirebaseMessaging.instance
          .requestPermission(
            alert: true,
            badge: true,
            sound: true,
            announcement: true,
          );
      log('🔔 iOS Notification Permission: ${settings.authorizationStatus}');
    }
  }

  Future<void> initialize() async {
    await _isPermissionsGranted();
    getToken();

    // Listen for background messages
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      ///if we want to show notifications when app is open.
      ///firebaseMessagingBackgroundHandler(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log(
        '🔔 App opened from background by notification tap with data: ${message.data}',
      );
    });

    // Init settings
    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    // ✅ Get launch details in case app launched from terminated state
    final details = await FlutterLocalNotificationsPlugin()
        .getNotificationAppLaunchDetails();

    if (details?.didNotificationLaunchApp ?? false) {
      await FlutterLocalNotificationsPlugin().cancelAll();
      String? payload = details!.notificationResponse?.payload;
      if (payload != null && payload.isNotEmpty) {
        Map valueMap = jsonDecode(payload);
        log(
          'App launched by tapping notification in killed state with data: $valueMap',
        );
      }
    }

    await FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    if (token != null) {
      log('📲 FCM Token: $token');
      SharedPref.setString(SharedPrefConstants.fcmToken, token);
    } else {
      log("Failed to fetch FCM Token");
    }
    // ✅ For iOS only: get APNs token
    if (Platform.isIOS) {
      String? apnsToken = await _fcm.getAPNSToken();
      log('APNs Token: $apnsToken');
    }
    return token;
  }
}
