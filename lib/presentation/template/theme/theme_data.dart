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

ButtonStyle expandedButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled))
        return latoM20.copyWith(color: ThemeColors.gray1);
      return latoM16.copyWith(color: ThemeColors.fontLight);
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.yellow;
        return ThemeColors.yellow;
      },
    ),
    maximumSize: MaterialStateProperty.all(Size(double.infinity, 50.h)),
    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
    ),
  );
}
