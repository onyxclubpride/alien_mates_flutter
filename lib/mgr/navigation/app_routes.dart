import 'package:alien_mates/presentation/pages/intro_page.dart';
import 'package:alien_mates/presentation/pages/profile/edit_post_page.dart';
import 'package:alien_mates/presentation/pages/help/edit_help_page.dart';
import 'package:alien_mates/presentation/pages/settings/settings_page.dart';
import 'package:alien_mates/presentation/pages/auth/sign_up_page.dart';

import '../../presentation/pages/profile/create_ar_cam_page.dart';
import '../../presentation/template/base/template.dart';

class AppRoutes {
  static const splashRoute = "/splash";
  static const homePageRoute = "/home";
  static const loginPageRoute = "/login";
  static const signUpPageRoute = "/signUp";
  static const eventsPageRoute = "/events";
  static const profilePageRoute = "/profile";
  static const settingsPageRoute = "/setting";
  static const helpPageRoute = "/help";

  static const createEventPageRoute = "/createEvent";
  static const createHelpPageRoute = "/createHelp";
  static const createNoticePageRoute = "/createNotice";
  static const createArCamPageRoute = "/createArCam";

  static const eventDetailsPageRoute = "/eventDetails";
  static const helpDetailsPageRoute = "/helpDetails";
  static const editPostPageRoute = "/editPost";
  static const editEventPageRoute = "/editEvent";
  static const editHelpPageRoute = "/editHelp";
  static const editNoticePageRoute = "/editNotice";
  static const editProfilePageRoute = "/editProfile";

  static const termsAndConditionsPageRoute = "/termsAndConditions";
  static const aboutUsPageRoute = "/aboutUs";
  static const forgotPasswordPageRoute = "/fotgotPassword";
  static const noticeDetailsRoute = "/noticeDetails";
  static const feedbackPageRoute = "/feedbackPage";

  static const introPageRoute = "/introPage";

  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> base = {
      AppRoutes.splashRoute: (BuildContext context) => const SplashPage(),
      AppRoutes.loginPageRoute: (BuildContext context) => LoginPage(),
      AppRoutes.signUpPageRoute: (BuildContext context) => const SignUpPage(),
      AppRoutes.homePageRoute: (BuildContext context) => HomePage(),
      AppRoutes.eventsPageRoute: (BuildContext context) => EventsPage(),
      AppRoutes.helpPageRoute: (BuildContext context) => HelpPage(),
      AppRoutes.profilePageRoute: (BuildContext context) => ProfilePage(),
      AppRoutes.settingsPageRoute: (BuildContext context) =>
          const SettingsPage(),
      AppRoutes.createEventPageRoute: (BuildContext context) =>
          CreateEventPage(),
      AppRoutes.createHelpPageRoute: (BuildContext context) => CreateHelpPage(),
      AppRoutes.createNoticePageRoute: (BuildContext context) =>
          CreateNoticePage(),
      AppRoutes.helpDetailsPageRoute: (BuildContext context) =>
          HelpDetailsPage(),
      AppRoutes.eventDetailsPageRoute: (BuildContext context) =>
          EventDetailsPage(),
      AppRoutes.editNoticePageRoute: (BuildContext context) => EditNoticePage(),
      AppRoutes.editHelpPageRoute: (BuildContext context) => EditHelpPage(),
      AppRoutes.editPostPageRoute: (BuildContext context) => EditPostPage(),
      AppRoutes.editProfilePageRoute: (BuildContext context) =>
          EditProfilePage(),
      AppRoutes.termsAndConditionsPageRoute: (BuildContext context) =>
          const TermsAndConditionsPage(),
      AppRoutes.aboutUsPageRoute: (BuildContext context) => const AboutUsPage(),
      AppRoutes.forgotPasswordPageRoute: (BuildContext context) =>
          ForgotPasswordPage(),
      AppRoutes.noticeDetailsRoute: (BuildContext context) =>
          NoticeDetailsPage(),
      AppRoutes.feedbackPageRoute: (BuildContext context) => FeedbackPage(),
      AppRoutes.introPageRoute: (BuildContext context) => IntroPage(),
      AppRoutes.createArCamPageRoute: (BuildContext context) =>
          CreateArCamPage()
    };

    return base;
  }
}
