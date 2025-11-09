import 'package:flutter/material.dart';

/// AppColorScheme
/// --------------------
/// This file defines the full Material ColorScheme for both Light and Dark modes.
/// Each color pair defines a background + foreground relationship:
/// e.g. [primary] is the background, [onPrimary] is the text/icon color shown on top of it.
///
/// ✅ = Commonly used colors (you’ll use these often)
/// ⚪ = Rarely used or fallback colors (Material widgets might use them internally)
///
class AppColorScheme {
  /// ================================
  /// 🌙 DARK THEME COLOR SCHEME
  /// ================================
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    // ✅ Brand accent color (buttons, toggles, active states)
    primary: Color(0xFFEC0A0A),
    // ✅ Text/icon color on top of primary (usually white or black)
    onPrimary: Color(0xFF000000),

    // ✅ Background for cards/containers using the primary tone
    primaryContainer: Color(0xFF2C2C2C),
    // ✅ Text/icon color on top of primaryContainer
    onPrimaryContainer: Color(0xFFFFFFFF),

    // ✅ Secondary accent color (chips, icons, less prominent elements)
    secondary: Color(0xFF13A4F3),
    // ✅ Text/icon color on top of secondary background
    onSecondary: Color(0xFF000000),

    // ✅ Muted secondary surfaces (secondary cards, chips)
    secondaryContainer: Color(0xFF1C1C1C),
    // ✅ Text/icon color on top of secondary container
    onSecondaryContainer: Color(0xFFFFFFFF),

    // ✅ Tertiary accent (success/info color)
    tertiary: Color(0xFFFC5C67),
    // ✅ Text/icon color on tertiary background
    onTertiary: Color(0xFFFFFFFF),

    // ⚪ Optional container version of tertiary
    tertiaryContainer: Color(0xFF7C7C7C),
    onTertiaryContainer: Color(0xFFFFFFFF),

    // ✅ Error background color
    error: Color(0xFFBA1A1A),
    // ✅ Text/icon color shown on top of error
    onError: Color(0xFFFFFFFF),

    // ⚪ Used for softer error surfaces (TextFields, alerts)
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFFFFFFF),

    // ✅ Main background for Scaffold, pages, cards, etc.
    surface: Color(0xFF2C2C2C),
    // ✅ Default text/icon color for general content
    onSurface: Color(0xFFFFFFFF),

    // ⚪ Border/divider color for outlines
    outline: Color(0xFF8E8E8E),

    // ⚪ Used internally by Material shadows
    shadow: Color(0xFF000000),

    // ⚪ Used for snack-bars, bottom sheets (inverse theme)
    inverseSurface: Color(0xFFF1F1F1),
    onInverseSurface: Color(0xFF000000),

    // ⚪ Accent used for toggles or selection highlights
    inversePrimary: Color(0xFF37D39A),

    // ⚪ Used for elevation overlays in Material 3
    surfaceTint: Color(0xFF13562E),

    // ⚪ Alternative outline tone
    outlineVariant: Color(0xFF5A5A5A),

    // ⚪ Scrim overlay (for dialogs, drawers)
    scrim: Color(0xFF000000),
  );

  /// ================================
  /// ☀️ LIGHT THEME COLOR SCHEME
  /// ================================
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    // ✅ Brand accent color (buttons, toggles, active states)
    primary: Color(0xFFEC0A0A),
    // ✅ Text/icon color on top of primary (usually white)
    onPrimary: Color(0xFFFFFFFF),

    // ✅ Background for cards/containers using the primary tone
    primaryContainer: Color(0xFFD1D0D0),
    // ✅ Text/icon color on top of primaryContainer
    onPrimaryContainer: Color(0xFF000000),

    // ✅ Secondary accent color (chips, icons, less prominent elements)
    secondary: Color(0xFF13A4F3),
    // ✅ Text/icon color on top of secondary background
    onSecondary: Color(0xFFFFFFFF),

    // ✅ Muted secondary surfaces (secondary cards, chips)
    secondaryContainer: Color(0xFFE3E3E7),
    // ✅ Text/icon color on top of secondary container
    onSecondaryContainer: Color(0xFF000000),

    // ✅ Tertiary accent (success/info color)
    tertiary: Color(0xFFFC5C67),
    // ✅ Text/icon color on tertiary background
    onTertiary: Color(0xFFFFFFFF),

    // ⚪ Optional container version of tertiary
    tertiaryContainer: Color(0xFF7C7C7C),
    onTertiaryContainer: Color(0xFF1E1E1E),

    // ✅ Error background color
    error: Color(0xFFBA1A1A),
    // ✅ Text/icon color shown on top of error
    onError: Color(0xFFFFFFFF),

    // ⚪ Used for softer error surfaces (TextFields, alerts)
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // ✅ Main background for Scaffold, pages, cards, etc.
    surface: Color(0xFFFFFFFF),
    // ✅ Default text/icon color for general content
    onSurface: Color(0xFF1C1C1C),

    // ⚪ Border/divider color for outlines
    outline: Color(0xFF79747E),

    // ⚪ Used internally by Material shadows
    shadow: Color(0xFF000000),

    // ⚪ Used for snack-bars, bottom sheets (inverse theme)
    inverseSurface: Color(0xFF2C2C2C),
    onInverseSurface: Color(0xFFF1F1F1),

    // ⚪ Accent used for toggles or selection highlights
    inversePrimary: Color(0xFF37D39A),

    // ⚪ Used for elevation overlays in Material 3
    surfaceTint: Color(0xFF13562E),

    // ⚪ Alternative outline tone
    outlineVariant: Color(0xFFC4C7C5),

    // ⚪ Scrim overlay (for dialogs, drawers)
    scrim: Color(0xFF000000),
  );
}
