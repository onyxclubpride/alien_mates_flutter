import 'package:flutter/material.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class MainTheme {
  static ThemeData get mainThemeDark {
    return ThemeData(
        scaffoldBackgroundColor: ThemeColors.bgBasic,
        appBarTheme: _appBarTheme(),
        bottomNavigationBarTheme: _bottomNavTheme(),
        primaryTextTheme: _primaryTextTheme(),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent));
  }

  static ThemeData get mainThemeLight {
    return ThemeData(
        scaffoldBackgroundColor: ThemeColors.bgBasic,
        appBarTheme: _appBarTheme(),
        bottomNavigationBarTheme: _bottomNavTheme(),
        primaryTextTheme: _primaryTextTheme(),
        bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.transparent));
  }
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
      elevation: 0,
      toolbarHeight: 84.h,
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r))));
}

TextTheme _primaryTextTheme() {
  return TextTheme();
}

BottomNavigationBarThemeData _bottomNavTheme() {
  return BottomNavigationBarThemeData();
}

ButtonStyle expandedButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled))
        return ThemeTextMedium.notoM16.copyWith(color: ThemeColors.gray4);
      return ThemeTextMedium.notoM16.copyWith(color: ThemeColors.white);
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray6;
        return ThemeColors.blue;
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

ButtonStyle whiteButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.all(ThemeTextMedium.notoM16),
    foregroundColor: MaterialStateProperty.all(ThemeColors.white),
    maximumSize: MaterialStateProperty.all(Size(double.infinity, 50.h)),
    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.h)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return ThemeColors.gray4.withOpacity(0.2);
      },
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray6;
        return ThemeColors.transparent;
      },
    ),
  );
}

ButtonStyle normalButtonTheme() {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled))
          return ThemeTextMedium.notoM16.copyWith(color: ThemeColors.gray4);
        return ThemeTextMedium.notoM16.copyWith(color: ThemeColors.white);
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return ThemeColors.gray6;
          return ThemeColors.blue;
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
    textStyle: MaterialStateProperty.all(ThemeTextMedium.notoM16),
    foregroundColor: MaterialStateProperty.all(ThemeColors.white),
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
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray6;
        return ThemeColors.blue;
      },
    ),
  );
}

ButtonStyle smallButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.all(ThemeTextRegular.notoR13),
    foregroundColor: MaterialStateProperty.all(ThemeColors.white),
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
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray6;
        return ThemeColors.blue;
      },
    ),
  );
}

ButtonStyle denseButtonTheme() {
  return ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      elevation: MaterialStateProperty.all(0),
      textStyle: MaterialStateProperty.all(ThemeTextRegular.notoR13),
      foregroundColor: MaterialStateProperty.all(ThemeColors.white),
      maximumSize: MaterialStateProperty.all(Size(78.w, 39.h)),
      minimumSize: MaterialStateProperty.all(Size(78.w, 39.h)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.r)))),
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray6;
        return ThemeColors.blue;
      }));
}

ButtonStyle circleButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    maximumSize: MaterialStateProperty.all(Size(64, 64)),
    minimumSize: MaterialStateProperty.all(Size(64, 64)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular((64 / 2))))),
    textStyle: MaterialStateProperty.all(ThemeTextMedium.notoM16),
    foregroundColor: MaterialStateProperty.all(ThemeColors.white),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return ThemeColors.gray6;
        return ThemeColors.transparent;
      },
    ),
  );
}

ButtonStyle textButtonTheme() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    textStyle: MaterialStateProperty.all(ThemeTextRegular.notoR13),
    foregroundColor: MaterialStateProperty.all(ThemeColors.black),
    overlayColor: MaterialStateProperty.all(ThemeColors.gray2),
  );
}
