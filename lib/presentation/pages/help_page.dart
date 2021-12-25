import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:smart_house_flutter/utils/common/log_tester.dart';

class HelpPage extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: appStore,
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => DefaultBody(
                  child: ListView(
                controller: _controller,
                children: [..._buildPostsWidgetList(state)],
              ))),
    );
  }

  List<Widget> _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;

    for (int i = 0; i < postsList.length; i++) {
      _list.add(PostItemBanner(
          withBorder: true,
          bgColor: ThemeColors.black,
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: _buildSupportTextsWidget(),
          )));
    }
    return _list;
  }

  Widget _buildSupportTextsWidget() {
    List<Widget> list = [];
    list.add(Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: SizedText(
        textAlign: TextAlign.left,
        text: 'RoomMate needed',
        textStyle: latoM20.copyWith(color: ThemeColors.fontDark),
      ),
    ));
    list.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(thickness: 1.w, color: ThemeColors.borderDark),
    ));
    list.add(SizedText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      maxLines: 5,
      text:
          'Hello guys, currently I am living in a home for a While and it is really expensive so if anyone of you Want to share please let me know. Here I give myHello guys, currently I am living in a home for a While and it is really expensive so if anyone of you Want to share please let me know. Here I give myHello guys, currently I am living in a home for a While and it is really expensive so if anyone of you Want to share please let me know. Here I give myHello guys, currently I am living in a home for a While and it is really expensive so if anyone of you Want to share please let me know. Here I give myHello guys, currently I am living in a home for a While and it is really expensive so if anyone of you Want to share please let me know. Here I give my Kakas Id . Please contact there.',
      textStyle: latoM16.copyWith(color: ThemeColors.fontDark),
    ));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  _onJoinTap() {
    logger('on join tap');
  }
}
