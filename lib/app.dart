import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:world_cue/features/navigator/view/navigator_screen.dart';

import 'core/storage/shared_pref.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/constants.dart';
import 'core/widgets/internet_connection_checker.dart';
import 'features/auth/view/auth_screen.dart';
import 'generated/l10n.dart';

/// global navigation key
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    // Load theme preference
    final theme = SharedPref.getString('theme');
    if (theme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (theme == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }

    // Load language preference
    final langCode = SharedPref.getString(SharedPrefConstants.language) ?? 'en';
    _locale = Locale(langCode);

    // Force rebuild after loading prefs
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,

          /// Themes
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode,

          /// Localization setup
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: _locale,

          /// App entry point
          home: InternetConnectivityChecker(child: _homeScreen()),
        );
      },
    );
  }

  Widget _homeScreen() {
    final initialScreen = SharedPref.getString(SharedPrefConstants.initScreen) ??
        SharedPrefConstants.loginScreen;

    if (initialScreen == SharedPrefConstants.loginScreen) {
      return const AuthScreen();
    } else {
      return const NavigatorScreen();
    }
  }
}
