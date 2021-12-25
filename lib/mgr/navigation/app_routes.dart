import 'package:flutter/material.dart';
import 'package:smart_house_flutter/presentation/pages/splash_page.dart';
import 'package:smart_house_flutter/presentation/pages/login_page.dart';
import '../../presentation/template/base/template.dart';

class AppRoutes {
  static const splashRoute = "/splash";
  static const homePageRoute = "/home";
  static const loginPageRoute = "/login";
  static const eventsPageRoute = "/events";
  static const profilePageRoute = "/profile";
  static const settingPageRoute = "/setting";
  static const helpPageRoute = "/help";

  static const eventDetailsPageRoute = "/eventDetails";
  static const helpDetailsPageRoute = "/helpDetails";

  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> base = {
      AppRoutes.splashRoute: (BuildContext context) => const SplashPage(),
      AppRoutes.loginPageRoute: (BuildContext context) => LoginPage(),

      AppRoutes.homePageRoute: (BuildContext context) => HomePage(),
      AppRoutes.eventsPageRoute: (BuildContext context) => EventsPage(),
      AppRoutes.helpPageRoute: (BuildContext context) => HelpPage(),
      // AppRoutes.profileRoute: (BuildContext context) => const ProfilePage(),
      // AppRoutes.settingRoute: (BuildContext context) => const SettingPage(),

      // AppRoutes.eventDetailsRoute: (BuildContext context) => const EventDetilsPage(),
      // AppRoutes.helpDetailsRoute: (BuildContext context) => const helpDetilsPage(),
    };

    return base;
  }
}
