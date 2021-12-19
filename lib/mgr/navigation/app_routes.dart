import 'package:flutter/material.dart';
import '../../presentation/template/base/template.dart';

class AppRoutes {
  static const home = "/home";

  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> base = {
      AppRoutes.home: (BuildContext context) => const HomePage(),
    };

    return base;
  }
}
