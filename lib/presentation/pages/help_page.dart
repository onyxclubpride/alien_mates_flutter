import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:alien_mates/presentation/widgets/open_image_popup.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/log_tester.dart';

class HelpPage extends StatefulWidget {
  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
    OverlayEntry _popupEntry;
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;
    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      if (_item.isHelp) {
        _list.add(Builder(
          builder: (context) => PostItemBanner(
              imageUrl: _item.imageUrl,
              withBorder: true,
              desc: _item.description,
              height: 160.h,
              bgColor: ThemeColors.black,
              child: CachedImageOrTextImageWidget(
                  title: _item.title,
                  imageUrl: _item.imageUrl,
                  description: _item.description)),
        ));
      }
    }
    return _list;
  }
}
