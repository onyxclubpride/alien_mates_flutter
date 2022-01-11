import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class EventsPage extends StatefulWidget {
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) =>
            DefaultBody(child: _buildPostsWidgetList(state)));
  }

  Widget _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;
    String _userId = state.apiState.userMe.userId;

    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      if (_item.isEvent) {
        _list.add(PostItemBanner(
          onTap: () {
            _singleEventDetails(_item.postId, _item.userId);
          },
          leftWidget: SizedText(
              text: '${_item.joinedUserIds!.length}/${_item.joinLimit!}',
              textStyle: latoM14.copyWith(color: ThemeColors.fontWhite)),
          rightWidget: InkWell(
            onTap: () {
              _item.joinedUserIds!.contains(_userId)
                  ? _onUnJoinTap(_item.postId, _item.joinedUserIds!,
                      _item.joinLimit!, _userId)
                  : _onJoinTap(_item.postId, _item.joinedUserIds!,
                      _item.joinLimit!, _userId);
            },
            child: SizedText(
              text: _item.joinedUserIds!.contains(_userId) ? "UNDO" : 'JOIN',
              textStyle: latoM14.copyWith(color: ThemeColors.fontWhite),
            ),
          ),
          imageUrl: _item.imageUrl,
          desc: _item.description,
          child: CachedImageOrTextImageWidget(
              title: _item.title,
              imageUrl: _item.imageUrl,
              description: _item.description),
        ));
        _list.add(SizedBox(height: 20.h));
      }
    }
    return Column(children: _list);
  }

  _singleEventDetails(eventId, userId) async {
    await appStore.dispatch(GetUserByIdAction(userId));
    await appStore.dispatch(GetPostByIdAction(eventId));
    appStore.dispatch(NavigateToAction(to: AppRoutes.eventDetailsPageRoute));
  }

  _onJoinTap(String postId, List userIds, int joinLimit, userId) {
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
  }

  _onUnJoinTap(String postId, List userIds, int joinLimit, userId) {
    List _list = userIds;
    _list.remove(userId);
    appStore
        .dispatch(GetUpdatePostAction(postId: postId, joinedUserIds: _list));
  }
}
