import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
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
              child: ListView(
                controller: _controller,
                children: [
                  DefaultBanner(
                    height: 90.h,
                    onTap: () {},
                    // child: _buildBanners(state),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 25.h),
                      child: BodyNavigationBar()),
                  ..._buildPostsWidgetList(state)
                ],
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
            desc: _item.description,
            child: CachedImageOrTextImageWidget(
                imageUrl: _item.imageUrl, description: _item.description)));
        _list.add(SizedBox(height: 20.h));
      }
    }
    return _list;
  }
}
