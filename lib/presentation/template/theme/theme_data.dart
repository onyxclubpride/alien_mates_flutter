import 'package:flutter/material.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';

class MainTheme {
  static ThemeData get mainThemeDark {
    return ThemeData(scaffoldBackgroundColor: ThemeColors.bgDark);
  }

  static ThemeData get mainThemeLight {
    return ThemeData(scaffoldBackgroundColor: ThemeColors.bgLight);
  }
}
