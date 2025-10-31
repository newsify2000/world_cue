import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:world_cue/presentation/module/navigator/navigator_screen.dart';

import 'generated/l10n.dart';
import 'presentation/common_widgets/internet_connection_checker.dart';
import 'presentation/module/auth/screens/login_screen.dart';
import 'presentation/theme/app_theme.dart';
import 'utils/constants.dart';
import 'utils/shared_pref.dart';

/// global navigation key
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// initializing the screen unit library and
    /// setting up the design width and height
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          ///Remove Debug tag from top right corner
          debugShowCheckedModeBanner: false,

          ///setup navigation key
          navigatorKey: navigatorKey,

          ///Light theme of the app
          theme: AppTheme.lightTheme,

          ///Dark theme of the app
          darkTheme: AppTheme.darkTheme,

          /// current theme mode of app
          themeMode: ThemeMode.system,

          /// setting up localisation delegates for the app
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          /// this line set up the languages we use in our app
          supportedLocales: S.delegate.supportedLocales,
          locale: const Locale('en'),

          /// app home page
          home: InternetConnectivityChecker(child: homeScreen()),
        );
      },
    );
  }

  Widget homeScreen() {
    SharedPref.setString(
      SharedPrefConstants.initScreen,
      SharedPrefConstants.loginScreen,
    );

    String initialScreen =
        SharedPref.getString(SharedPrefConstants.initScreen) ??
        SharedPrefConstants.loginScreen;
    if (initialScreen == SharedPrefConstants.loginScreen) {
      return const LoginScreen();
    } else {
      return const NavigatorScreen();
    }
  }
}
