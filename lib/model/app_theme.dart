import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    final light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: _primaryColor,
      scaffoldBackgroundColor: Colors.white,
    );
    return _themeData(light);
  }

  static ThemeData dark() {
    final dark = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: _primaryColor,
      scaffoldBackgroundColor: Colors.black,
      accentColor: _primaryColor,
    );
    return _themeData(dark);
  }

  static ThemeData _themeData(ThemeData themeData) {
    return themeData.copyWith(
      appBarTheme: themeData.appBarTheme.copyWith(
        color: themeData.scaffoldBackgroundColor,
      ),
      floatingActionButtonTheme: _floatingActionButtonThemeData(themeData),
      cardColor: themeData.canvasColor,
    );
  }

  static const MaterialColor _primaryColor = Colors.orange;

  static FloatingActionButtonThemeData _floatingActionButtonThemeData(
      ThemeData themeData) {
    return themeData.floatingActionButtonTheme.copyWith(
      foregroundColor: Colors.white,
    );
  }
}
