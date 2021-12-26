import 'package:alien_mates/presentation/pages/create_event_page.dart';
import 'package:alien_mates/presentation/pages/create_help_page.dart';
import 'package:alien_mates/presentation/pages/create_notice_page.dart';
import 'package:alien_mates/presentation/pages/edit_notice_page.dart';
import 'package:flutter/material.dart';
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

  static const createEventPageRoute = "/createEvent";
  static const createHelpPageRoute = "/createHelp";
  static const createNoticePageRoute = "/createNotice";

  static const editEventPageRoute = "/editEvent";
  static const editHelpPageRoute = "/editHelp";
  static const editNoticePageRoute = "/editNotice";

  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> base = {
      AppRoutes.splashRoute: (BuildContext context) => const SplashPage(),
      AppRoutes.loginPageRoute: (BuildContext context) => LoginPage(),

      // AppRoutes.signUpBottomSheet: (BuildContext context) =>
      //     SignUpBottomSheet(),

      AppRoutes.homePageRoute: (BuildContext context) => HomePage(),
      AppRoutes.eventsPageRoute: (BuildContext context) => EventsPage(),
      AppRoutes.helpPageRoute: (BuildContext context) => HelpPage(),
      AppRoutes.profilePageRoute: (BuildContext context) => ProfilePage(),
      // AppRoutes.settingRoute: (BuildContext context) => const SettingPage(),
      // AppRoutes.eventDetailsRoute: (BuildContext context) => const EventDetilsPage(),
      // AppRoutes.helpDetailsRoute: (BuildContext context) => const helpDetilsPage(),

      AppRoutes.createEventPageRoute: (BuildContext context) =>
          CreateEventPage(),
      AppRoutes.createHelpPageRoute: (BuildContext context) => CreateHelpPage(),
      AppRoutes.createNoticePageRoute: (BuildContext context) =>
          CreateNoticePage(),

      AppRoutes.editNoticePageRoute: (BuildContext context) => EditNoticePage(),
    };

    return base;
  }
}
