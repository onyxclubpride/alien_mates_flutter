import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/log_tester.dart';

class ProfilePage extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
            withTopBanner: false,
            withNavigationBar: false,
            rightIcon: Ionicons.create_outline,
            onRightButtonClick: _onEditPress,
            titleIcon: _buildTitleIcon(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoWidget(state.apiState),
                SizedBox(height: 20.h),
                Divider(thickness: 1.w, color: ThemeColors.borderDark),
                SizedBox(height: 10.h),
                SizedText(
                    text: "My Feed",
                    textStyle: latoM25.copyWith(color: ThemeColors.fontDark)),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 290.h,
                  child: ListView(
                    shrinkWrap: true,
                    controller: _controller,
                    children: [..._buildPostsWidgetList(state)],
                  ),
                )
              ],
            )));
  }

  Widget _buildUserInfoWidget(ApiState state) {
    UserModelRes userModelRes = state.userMe;
    return DefaultBanner(
      height: 140.h,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: SpacedColumn(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildUserInfoItem(valueText: userModelRes.name),
            _buildUserInfoItem(
                icon: Ionicons.chatbox, valueText: userModelRes.uniName),
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
      horizontalSpace: 10.w,
      children: [
        Icon(icon, color: ThemeColors.fontDark, size: 25.w),
        SizedText(
            text: valueText,
            textStyle: latoM16.copyWith(color: ThemeColors.fontDark)),
      ],
    );
  }

  List<Widget> _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;

    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      _list.add(PostItemBanner(
          height: 110.h,
          imageUrl: _item.imageUrl,
          leftWidget: InkWell(
            onTap: () {
              _onDeletePress(_item.postId);
            },
            child: const SizedText(
              text: 'Delete',
            ),
          ),
          rightWidget: InkWell(
            onTap: () {
              _onEditPostPress(_item.postId);
            },
            child: const SizedText(
              text: 'Edit',
            ),
          ),
          child: CachedImageOrTextImageWidget(
              title: _item.title,
              imageUrl: _item.imageUrl,
              description: _item.description)));
    }
    return _list;
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

  _onEditPress() {
    appStore.dispatch(NavigateToAction(to: AppRoutes.createHelpPageRoute));
  }

  _onEditPostPress(String postId) async {
    appStore.dispatch(
        GetPostByIdAction(postId, goToRoute: AppRoutes.editNoticePageRoute));
  }

  _onDeletePress(String postId) {
    appStore.dispatch(GetDeletePostAction(postId));
  }
}
