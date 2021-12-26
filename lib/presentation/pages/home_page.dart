import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class HomePage extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
                child: SizedBox(
              height: 200.h,
              child: ListView(
                controller: _controller,
                children: [..._buildPostsWidgetList(state)],
              ),
            )));
  }

  List<Widget> _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;

    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      if (_item.isPost) {
        _list.add(PostItemBanner(
            imageUrl: _item.imageUrl,
            child: CachedNetworkImage(
              imageUrl: state.apiState.posts[i].imageUrl!,
              fit: BoxFit.cover,
            )));
      }
    }
    return _list;
  }
}
