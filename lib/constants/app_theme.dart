import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontSize {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double extraLarge = 24.0;
  static const double extraExtraLarge = 32.0;
}

class Spacing {
  static const double extrasmall = 8.0;
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double extraLarge = 24.0;
  static const double extraExtraLarge = 32.0;
}

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.1.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.green,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.green,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

extension ThemeColors on BuildContext {
  // Primary and secondary colors
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  // Background and surface colors
  Color get surfaceColor => Theme.of(this).colorScheme.surface;

  // Error and on-error colors
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get onErrorColor => Theme.of(this).colorScheme.onError;

  // Text and icon colors
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;
  Color get onSecondaryColor => Theme.of(this).colorScheme.onSecondary;
  Color get onSurfaceColor => Theme.of(this).colorScheme.onSurface;

  // Additional Theme properties
  Brightness get brightness => Theme.of(this).brightness;
  Color get disabledColor => Theme.of(this).disabledColor;
  Color get dividerColor => Theme.of(this).dividerColor;
  Color get shadowColor => Theme.of(this).shadowColor;
}
