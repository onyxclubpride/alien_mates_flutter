import 'package:alien_mates/presentation/pages/create_event_page.dart';
import 'package:alien_mates/presentation/pages/create_help_page.dart';
import 'package:alien_mates/presentation/pages/create_notice_page.dart';
import 'package:alien_mates/presentation/pages/edit_notice_page.dart';
import 'package:alien_mates/presentation/pages/event_details_page.dart';
import 'package:alien_mates/presentation/pages/help_details_page.dart';
import 'package:alien_mates/presentation/pages/sign_up_page.dart';

import 'package:flutter/material.dart';
import '../../presentation/template/base/template.dart';

class AppRoutes {
  static const splashRoute = "/splash";
  static const homePageRoute = "/home";
  static const loginPageRoute = "/login";
  static const signUpPageRoute = "/signUp";
  static const eventsPageRoute = "/events";
  static const profilePageRoute = "/profile";
  // static const settingPageRoute = "/setting";
  static const helpPageRoute = "/help";

  static const createEventPageRoute = "/createEvent";
  static const createHelpPageRoute = "/createHelp";
  static const createNoticePageRoute = "/createNotice";

  static const eventDetailsPageRoute = "/eventDetails";
  static const helpDetailsPageRoute = "/helpDetails";
  static const noticeDetailsRoute = "/noticeDetails";
  static const editEventPageRoute = "/editEvent";
  static const editHelpPageRoute = "/editHelp";
  // static const editEventPageRoute = "/editEvent";
  // static const editHelpPageRoute = "/editHelp";
  static const editNoticePageRoute = "/editNotice";

  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> base = {
      AppRoutes.splashRoute: (BuildContext context) => const SplashPage(),
      AppRoutes.loginPageRoute: (BuildContext context) => LoginPage(),
      AppRoutes.signUpPageRoute: (BuildContext context) => const SignUpPage(),
      AppRoutes.homePageRoute: (BuildContext context) => HomePage(),
      AppRoutes.eventsPageRoute: (BuildContext context) => EventsPage(),
      AppRoutes.helpPageRoute: (BuildContext context) => HelpPage(),
      AppRoutes.profilePageRoute: (BuildContext context) => ProfilePage(),
      // AppRoutes.settingRoute: (BuildContext context) => const SettingPage(),

      AppRoutes.createEventPageRoute: (BuildContext context) =>
          CreateEventPage(),
      AppRoutes.createHelpPageRoute: (BuildContext context) => CreateHelpPage(),
      AppRoutes.createNoticePageRoute: (BuildContext context) =>
          CreateNoticePage(),

      AppRoutes.helpDetailsPageRoute: (BuildContext context) =>
          HelpDetailsPage(),
      AppRoutes.eventDetailsPageRoute: (BuildContext context) =>
          EventDetailsPage(),
      // AppRoutes.noticeDetailRoute: (BuildContext context) => NoticeDetail(),

      AppRoutes.editNoticePageRoute: (BuildContext context) => EditNoticePage(),
    };

    return base;
  }
}
