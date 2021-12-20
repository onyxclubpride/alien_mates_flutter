import 'package:flutter/material.dart';
import '../../presentation/template/base/template.dart';

class AppRoutes {
  static const homeRoute = "/home";
  static const loginRoute = "/login";
  static const eventRoute = "/events";
  static const profileRoute = "/profile";
  static const settingRoute = "/setting";
  static const helpRoute = "/help";
  
  static const eventDetailsRoute = "/eventDetails";
  static const helpDetailsRoute = "/helpDetails";
  


  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> base = {
      AppRoutes.homeRoute: (BuildContext context) => const HomePage(),
      // AppRoutes.loginRoute: (BuildContext context) => const LoginPage(),
      // AppRoutes.eventRoute: (BuildContext context) => const EventPage(),
      // AppRoutes.helpRoute: (BuildContext context) => const HelpPage(),
      // AppRoutes.profileRoute: (BuildContext context) => const ProfilePage(),
      // AppRoutes.settingRoute: (BuildContext context) => const SettingPage(),

      // AppRoutes.eventDetailsRoute: (BuildContext context) => const EventDetilsPage(),
      // AppRoutes.helpDetailsRoute: (BuildContext context) => const helpDetilsPage(),
      
    };

    return base;
  }
}
