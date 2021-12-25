import 'package:flutter/material.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class MainTheme {
  static ThemeData get mainThemeDark {
    return ThemeData(
        scaffoldBackgroundColor: ThemeColors.bgDark,
        appBarTheme: _appBarDarkTheme());
  }

  static ThemeData get mainThemeLight {
    return ThemeData(
        scaffoldBackgroundColor: ThemeColors.bgLight,
        appBarTheme: _appBarLightTheme());
  }
}

AppBarTheme _appBarDarkTheme() {
  return AppBarTheme(
    elevation: 0,
    backgroundColor: ThemeColors.transparent,
    foregroundColor: ThemeColors.fontDark,
  );
}

AppBarTheme _appBarLightTheme() {
  return const AppBarTheme(
    elevation: 0,
    backgroundColor: ThemeColors.transparent,
    foregroundColor: ThemeColors.fontLight,
  );
}
