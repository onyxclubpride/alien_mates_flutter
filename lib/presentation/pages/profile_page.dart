import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';
import 'package:smart_house_flutter/mgr/navigation/app_routes.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:smart_house_flutter/utils/common/log_tester.dart';

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
                _buildUserInfoWidget(),
                SizedBox(height: 20.h),
                Divider(thickness: 1.w, color: ThemeColors.borderDark),
                SizedBox(height: 10.h),
                SizedText(
                    text: "My Feed",
                    textStyle: latoM25.copyWith(color: ThemeColors.fontDark)),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 325.h,
                  child: ListView(
                    shrinkWrap: true,
                    controller: _controller,
                    children: [..._buildPostsWidgetList(state)],
                  ),
                )
              ],
            )));
  }

  Widget _buildUserInfoWidget() {
    return DefaultBanner(
      height: 110.h,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: SpacedColumn(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildUserInfoItem(),
            _buildUserInfoItem(icon: Ionicons.chatbox, valueText: 'Issuer'),
            _buildUserInfoItem(icon: Ionicons.call, valueText: '01064634085'),
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
      // if (_item.isEvent) {
      _list.add(PostItemBanner(
          height: 110.h,
          leftWidget: InkWell(
            onTap: _onDeletePress,
            child: const SizedText(
              text: 'Delete',
            ),
          ),
          rightWidget: InkWell(
            onTap: _onEditPress,
            child: const SizedText(
              text: 'Edit',
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: state.apiState.posts[i].imageUrl!,
            fit: BoxFit.cover,
          )));
      // }
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

  _onEditPress() {}

  _onDeletePress() {}
}
