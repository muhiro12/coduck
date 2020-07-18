import 'package:coduck/parameter/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    final light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.white,
    );
    return _themeData(light);
  }

  static ThemeData dark() {
    final dark = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.black,
      accentColor: AppColor.primaryColor,
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

  static FloatingActionButtonThemeData _floatingActionButtonThemeData(
      ThemeData themeData) {
    return themeData.floatingActionButtonTheme.copyWith(
      foregroundColor: AppColor.white,
    );
  }
}
