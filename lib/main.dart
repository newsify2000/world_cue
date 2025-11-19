import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:world_cue/core/config/message_initializer.dart';
import 'package:world_cue/core/config/push_notification_service.dart';

import 'app.dart';
import 'core/config/firebase_options.dart';
import 'core/dependency_injection/di_setup.dart';
import 'core/storage/shared_pref.dart';

void main() async {
  /// initializing the framework
  WidgetsFlutterBinding.ensureInitialized();

  try{
    /// initializing Firebase, Crashlytics and Messaging services
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await PushNotificationService().initialize();

    /// setting up the orientation of the app to portrait only
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    /// initializing the shared preference
    await SharedPref().initSharedPreferences();
    DISetup.setup();
    /// initializing the env file
    await dotenv.load(fileName: ".env");
    /// initialize DI container
    var key = dotenv.env['GEMINI_API_KEY']!;

  }
  catch(err){
    log(err.toString());
    FirebaseCrashlytics.instance.recordError(err, StackTrace.current);
  }


  runApp(const App());
}
