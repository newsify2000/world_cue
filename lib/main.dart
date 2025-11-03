import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/config/firebase_options.dart';
import 'core/dependency_injection/di_setup.dart';
import 'core/storage/shared_pref.dart';

void main() async {
  /// initializing the framework
  WidgetsFlutterBinding.ensureInitialized();

  /// initializing firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// setting up the orientation of the app to portrait only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// initializing the shared preference
  await SharedPref().initSharedPreferences();

  /// initialize DI container
  DISetup.setup();
  runApp(const App());
}
