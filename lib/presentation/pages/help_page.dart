import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/log_tester.dart';

class HelpPage extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
                child: ListView(
              controller: _controller,
              children: [..._buildPostsWidgetList(state)],
            )));
  }

  List<Widget> _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;

    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      if (_item.isHelp) {
        _list.add(PostItemBanner(
            withBorder: true,
            height: 160,
            bgColor: ThemeColors.black,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: _buildSupportTextsWidget(_item),
            )));
      }
    }
    return _list;
  }

  Widget _buildSupportTextsWidget(ListPostModelRes listPostModelRes) {
    List<Widget> list = [];
    list.add(Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: SizedText(
        textAlign: TextAlign.left,
        text: listPostModelRes.title,
        textStyle: latoM20.copyWith(color: ThemeColors.fontDark),
      ),
    ));
    list.add(Divider(thickness: 1.w, color: ThemeColors.borderDark));
    list.add(SizedText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      maxLines: 5,
      text: listPostModelRes.description,
      textStyle: latoM16.copyWith(color: ThemeColors.fontDark),
    ));
    return SpacedColumn(
        verticalSpace: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list);
  }

  _onJoinTap() {
    logger('on join tap');
  }
}
