import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ProfileLayout extends StatefulWidget {
  Widget Function(BuildContext ctx, List<DocumentSnapshot<Object?>>, int index,
      AppState state) buildWidget;
  ProfileLayout({required this.buildWidget});

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => Scaffold(
              appBar: _getHeader(),
              body: PaginateFirestore(
                separator: SizedBox(height: 20.h),
                scrollController: _controller,
                itemBuilder: (_, documentSnapshots, index) {
                  return Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0)
                            Column(
                              children: [
                                _buildUserInfoWidget(state.apiState),
                                SizedBox(height: 10.h),
                                SizedText(
                                    text: "My Feed",
                                    textStyle: latoB25.copyWith(
                                        color: ThemeColors.fontDark)),
                                Divider(
                                    thickness: 1.w,
                                    color: ThemeColors.borderDark),
                                SizedBox(height: 20.h),
                              ],
                            ),
                        ],
                      ),
                      widget.buildWidget(_, documentSnapshots, index, state),
                    ],
                  );
                },
                physics: const BouncingScrollPhysics(),
                query: _getQuery(state),
                itemBuilderType: PaginateBuilderType.listView,
                isLive: true,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
            ));
  }

  _getQuery(AppState state) {
    return postsCollection
        .orderBy('createdDate', descending: true)
        .where("userId", isEqualTo: state.apiState.userMe.userId)
        .limit(10);
  }

  _getHeader() {
    return DefaultHeader(
      rightIcon: Ionicons.settings_outline,
      withAction: true,
      onRightButtonClick: () {
        appStore.dispatch(GetExtraInfoAction());
        appStore.dispatch(NavigateToAction(to: AppRoutes.settingsPageRoute));
      },
      titleText: SizedText(text: "Back", textStyle: latoM20),
      titleIcon: _buildTitleIcon(),
    );
  }

  Widget _buildTitleIcon() {
    return IconButton(
        padding: EdgeInsets.zero,
        iconSize: 30.w,
        icon: const Icon(Ionicons.chevron_back_outline),
        onPressed: () {
          appStore.dispatch(NavigateToAction(to: 'up'));
        });
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _controller.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget _buildUserInfoWidget(ApiState state) {
    UserModelRes userModelRes = state.userMe;
    return DefaultBanner(
      // height: 150.h,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: SpacedColumn(
          verticalSpace: 12.h,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildUserInfoItem(valueText: userModelRes.name),
            _buildUserInfoItem(
                icon: Ionicons.school, valueText: userModelRes.uniName),
            _buildUserInfoItem(
                icon: Ionicons.call, valueText: userModelRes.phoneNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoItem(
      {IconData icon = Ionicons.person, String? valueText = 'User134'}) {
    return SpacedRow(
      crossAxisAlignment: CrossAxisAlignment.center,
      horizontalSpace: 15.w,
      children: [
        Icon(icon, color: ThemeColors.fontDark, size: 25.w),
        SizedText(
            text: valueText,
            textStyle: latoM16.copyWith(color: ThemeColors.fontDark)),
      ],
    );
  }
}
