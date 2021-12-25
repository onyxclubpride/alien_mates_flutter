import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/log_tester.dart';

class EventsPage extends StatelessWidget {
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
      if (_item.isEvent) {
        _list.add(PostItemBanner(
            height: 180.h,
            leftWidget: const SizedText(
              text: 'Joined 17',
            ),
            rightWidget: InkWell(
              onTap: _onJoinTap,
              child: const SizedText(
                text: 'JOIN',
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: state.apiState.posts[i].imageUrl!,
              fit: BoxFit.cover,
            )));
      }
    }
    return _list;
  }

  _onJoinTap() {
    logger('on join tap');
  }
}
