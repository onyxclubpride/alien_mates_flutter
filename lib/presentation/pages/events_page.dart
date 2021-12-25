import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class EventsPage extends StatefulWidget {
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
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
            leftWidget: SizedText(
              text: 'Joined ${_item.joinedUserIds!.length}',
            ),
            rightWidget: InkWell(
              onTap: () {
                _onJoinTap(_item.postId, _item.joinedUserIds!, _item.joinLimit!,
                    "USER_2021.12.25_f547d420-657f-11ec-8de4-a59789f4ac63");
              },
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

  _onJoinTap(String postId, List userIds, int joinLimit, userId) {
    logger(joinLimit);
    logger(userIds);
    if (joinLimit > userIds.length) {
      if (!userIds.contains(userId)) {
        appStore.dispatch(GetUpdatePostAction(
            postId: postId, joinedUserIds: [...userIds, userId]));
      } else {
        showAlertDialog(context, text: "You have already joined!");
      }
    } else {
      showAlertDialog(context, text: "Guests limit is full!");
    }
    // appStore.dispatch(GetDeletePostAction(postId));
    // appStore.dispatch(GetPostByIdAction(
    //     'EVENT_POST_2021.12.25_7e284ae0-6558-11ec-8682-6f9cec7c39a3'));
    // appStore.dispatch(GetCreateEventAction(
    //     eventLocation: 'Seoul',
    //     title: "Cool event",
    //     description: "Cool event desc",
    //     joinLimit: 10,
    //     imagePath: ''));
  }
}
