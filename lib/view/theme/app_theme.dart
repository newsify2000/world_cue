import 'package:flutter/material.dart';

import 'color_scheme.dart';

class AppTheme {
  ///light theme for the app
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme: AppColorScheme.lightColorScheme,
  );

  ///dark theme for the app
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme: AppColorScheme.darkColorScheme,
  );
}
