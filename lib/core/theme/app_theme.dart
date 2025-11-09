import 'package:flutter/material.dart';

import 'color_scheme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorScheme.lightColorScheme.surface,
    primaryColor: Colors.black,
    colorScheme: AppColorScheme.lightColorScheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorScheme.darkColorScheme.primaryContainer,
    primaryColor: Colors.white,
    colorScheme: AppColorScheme.darkColorScheme,
  );
}
