import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/presentation/pages/edit_post_page.dart';
import 'package:alien_mates/presentation/pages/help/edit_help_page.dart';
import 'package:alien_mates/presentation/pages/settings_page.dart';
import 'package:alien_mates/presentation/pages/sign_up_page.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class AppRouter {
  static Widget getRoutes(String? to, {dynamic arguments}) {
    Widget _openRouteSwitch() {
      switch (to) {
        case (AppRoutes.homePageRoute):
          return HomePage();
        case (AppRoutes.loginPageRoute):
          return LoginPage();
        case (AppRoutes.signUpPageRoute):
          return const SignUpPage();
        case (AppRoutes.createHelpPageRoute):
          return CreateHelpPage();
        case (AppRoutes.createNoticePageRoute):
          return CreateNoticePage();
        case (AppRoutes.createEventPageRoute):
          return CreateEventPage();
        case (AppRoutes.editNoticePageRoute):
          return EditNoticePage();
        case (AppRoutes.profilePageRoute):
          return ProfilePage();
        case (AppRoutes.helpPageRoute):
          return HelpPage();
        case (AppRoutes.eventsPageRoute):
          return EventsPage();
        case (AppRoutes.settingsPageRoute):
          return SettingsPage();
        case (AppRoutes.helpDetailsPageRoute):
          return HelpDetailsPage();
        case (AppRoutes.eventDetailsPageRoute):
          return EventDetailsPage();
        case (AppRoutes.editEventPageRoute):
          return EditEventPage();
        case (AppRoutes.editPostPageRoute):
          return EditPostPage();
        case (AppRoutes.editHelpPageRoute):
          return EditHelpPage();
        case (AppRoutes.editProfilePageRoute):
          return EditProfilePage();
        default:
          return const SplashPage();
      }
    }

    return _openRouteSwitch();
  }
}
