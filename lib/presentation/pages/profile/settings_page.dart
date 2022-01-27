import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
            withTopBanner: false,
            titleIcon: _buildTitleIcon(),
            withNavigationBar: false,
            withActionButton: false,
            titleText: SizedText(
              text: "Back",
              textStyle: latoM20,
            ),
            rightIcon: null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 10, 10),
              child: SpacedColumn(
                verticalSpace: 20.h,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ThemeColors.black, elevation: 0),
                    onPressed: () {
                      appStore.dispatch(
                          NavigateToAction(to: AppRoutes.eventsPageRoute));
                    },
                    child: SpacedRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.home,
                            color: ThemeColors.bluegray400,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          SizedText(
                              text: "Home",
                              textStyle: latoM16.copyWith(color: Colors.white)),
                        ]),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ThemeColors.black, elevation: 0),
                    onPressed: () {
                      appStore.dispatch(
                          NavigateToAction(to: AppRoutes.editProfilePageRoute));
                    },
                    child: SpacedRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.create_outline,
                            color: ThemeColors.bluegray400,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          SizedText(
                              text: "Edit My Profile",
                              textStyle: latoM16.copyWith(color: Colors.white)),
                        ]),
                  ),
                  const Divider(
                    thickness: 1,
                    color: ThemeColors.bluegray400,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ThemeColors.black, elevation: 0),
                    onPressed: () {
                      appStore.dispatch(NavigateToAction(
                          to: AppRoutes.termsAndConditionsPageRoute));
                    },
                    child: SpacedRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.clipboard,
                            color: ThemeColors.bluegray400,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          SizedText(
                              text: "Terms and Conditions",
                              textStyle: latoM16.copyWith(color: Colors.white)),
                        ]),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ThemeColors.black, elevation: 0),
                    onPressed: () {
                      appStore.dispatch(
                          NavigateToAction(to: AppRoutes.aboutUsPageRoute));
                    },
                    child: SpacedRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.alert_circle,
                            color: ThemeColors.bluegray400,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          SizedText(
                              text: "About Us",
                              textStyle: latoM16.copyWith(color: Colors.white)),
                        ]),
                  ),
                  const Divider(
                    thickness: 1,
                    color: ThemeColors.bluegray400,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ThemeColors.black, elevation: 0),
                    onPressed: () async {
                      appStore.dispatch(GetLogoutAction());
                    },
                    child: SpacedRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.log_out,
                            color: ThemeColors.bluegray400,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          SizedText(
                              text: "Log out",
                              textStyle: latoM16.copyWith(color: Colors.white)),
                        ]),
                  )
                ],
              ),
            )));
  }

  Widget _buildTitleIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 30.w,
      icon: const Icon(Ionicons.chevron_back_outline),
      onPressed: () {
        appStore.dispatch(NavigateToAction(to: 'up'));
      },
    );
  }
}
