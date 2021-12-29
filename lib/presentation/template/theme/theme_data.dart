import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:flutter/material.dart';

class MainTheme {
  static ThemeData get mainThemeDark {
    return ThemeData(
        scaffoldBackgroundColor: ThemeColors.bgDark,
        bottomSheetTheme: _bottomSheetDarkTheme(),
        appBarTheme: _appBarDarkTheme());
  }

  static ThemeData get mainThemeLight {
    return ThemeData(
        scaffoldBackgroundColor: ThemeColors.bgLight,
        bottomSheetTheme: _bottomSheetLightTheme(),
        appBarTheme: _appBarLightTheme());
  }
}

BottomSheetThemeData _bottomSheetDarkTheme() {
  return BottomSheetThemeData(backgroundColor: Colors.transparent);
}

BottomSheetThemeData _bottomSheetLightTheme() {
  return BottomSheetThemeData(backgroundColor: Colors.transparent);
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
      if (states.contains(MaterialState.disabled)) {
        return latoM20.copyWith(color: ThemeColors.gray1);
      }
      return latoM16.copyWith(color: ThemeColors.fontLight);
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.yellow;
        return ThemeColors.yellow;
      },
    ),
    maximumSize: MaterialStateProperty.all(Size(double.infinity, 45.h)),
    minimumSize: MaterialStateProperty.all(Size(double.infinity, 45.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
    ),
  );
}

ButtonStyle normalButtonTheme() {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled))
          return latoM20.copyWith(color: ThemeColors.gray1);
        return latoM20.copyWith(color: ThemeColors.fontWhite);
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return ThemeColors.gray1;
          return ThemeColors.yellow;
        },
      ),
      maximumSize: MaterialStateProperty.all(Size(112.w, 50.h)),
      minimumSize: MaterialStateProperty.all(Size(112.w, 50.h)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
      ));
}

ButtonStyle mainButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.all(latoM16),
    foregroundColor: MaterialStateProperty.all(ThemeColors.fontWhite),
    maximumSize: MaterialStateProperty.all(Size(206.w, 50.h)),
    minimumSize: MaterialStateProperty.all(Size(206.w, 50.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray1;
        return ThemeColors.yellow;
      },
    ),
  );
}

ButtonStyle smallButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.all(latoM20),
    foregroundColor: MaterialStateProperty.all(ThemeColors.fontWhite),
    maximumSize: MaterialStateProperty.all(Size(50.w, 28.h)),
    minimumSize: MaterialStateProperty.all(Size(50.w, 28.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray1;
        return ThemeColors.yellow;
      },
    ),
  );
}
