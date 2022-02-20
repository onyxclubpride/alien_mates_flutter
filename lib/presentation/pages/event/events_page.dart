import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/presentation/layout/post_layout.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:alien_mates/presentation/widgets/show_alert_dialog.dart';
import 'package:alien_mates/presentation/widgets/show_body_dialog.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // Widget build(BuildContext context) {
  //   return StoreConnector<AppState, AppState>(
  //       converter: (store) => store.state,
  //       builder: (context, state) => DefaultBody(
  //           onRefresh: _onRefresh,
  //           child: Column(
  //             children: [
  //               _buildPostsWidgetList(state),
  //               MainButton(
  //                 onPressed: _onRefresh,
  //                 text: "Load more",
  //               ),
  //               SizedBox(height: 20.h)
  //             ],
  //           )));
  // }
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => PostLayout(
            buildWidget: _buildWigdet, postType: PostTypeEnum.EVENT));
  }

  _singleEventDetails(eventId, userId) async {
    await appStore.dispatch(GetUserByIdAction(userId));
    await appStore.dispatch(GetPostByIdAction(eventId));
    appStore.dispatch(NavigateToAction(to: AppRoutes.eventDetailsPageRoute));
  }

  _onJoinTap(String postId, List userIds, int joinLimit, userId) async {
    if (joinLimit > userIds.length) {
      if (!userIds.contains(userId)) {
        await appStore.dispatch(GetUpdatePostAction(
            postId: postId, joinedUserIds: [...userIds, userId]));
      } else {
        showAlertDialog(context, text: "You have already joined!");
      }
    } else {
      showAlertDialog(context, text: "Guests limit is full!");
    }
  }

  _onUnJoinTap(String postId, List userIds, int joinLimit, userId) async {
    List _list = userIds;
    _list.remove(userId);
    await appStore
        .dispatch(GetUpdatePostAction(postId: postId, joinedUserIds: _list));
  }

  PostModelRes _getPostModel(snapshot) {
    final _postDetail = snapshot;
    PostModelRes _postModelRes = PostModelRes(
        createdDate: _postDetail['createdDate'].toString(),
        postId: _postDetail['postId'],
        isNotice: _postDetail['isNotice'],
        isPost: _postDetail['isPost'],
        userId: _postDetail['userId'],
        isEvent: _postDetail['isEvent'],
        isHelp: _postDetail['isHelp'],
        likedUserIds: _postDetail['likedUserIds'],
        joinedUserIds: _postDetail['joinedUserIds'],
        description: _postDetail['description'],
        title: _postDetail['title'],
        joinLimit: _postDetail['joinLimit'],
        imageUrl: _postDetail['imageUrl'],
        eventLocation: _postDetail['eventLocation']);
    return _postModelRes;
  }

  Widget _buildWigdet(BuildContext ctx, List<DocumentSnapshot> snapshots,
      int index, AppState state) {
    final _item = _getPostModel(snapshots[index]);
    final _userId = state.apiState.userMe.userId;
    final _user = state.apiState.userMe;
    return PostItemBanner(
        onTap: () {
          _singleEventDetails(_item.postId, _item.userId);
        },
        leftWidget: _item.joinedUserIds!.length == _item.joinLimit!
            ? SizedText(
                text: 'YAY!',
                textStyle: latoB14.copyWith(color: ThemeColors.white),
              )
            : SizedText(
                text: '${_item.joinedUserIds!.length}/${_item.joinLimit!}',
                textStyle: latoB14.copyWith(color: ThemeColors.fontWhite)),
        rightWidget: TextButton(
          onPressed: () {
            if (_user.isAdmin) {
              showBodyDialog(
                context,
                text: 'Do you want to delete?',
                onMainButtonText: 'Yes',
                onPress: () {
                  appStore.dispatch(GetDeletePostAction(_item.postId));
                },
              );
            } else {
              _item.joinedUserIds!.contains(_userId)
                  ? _onUnJoinTap(_item.postId, _item.joinedUserIds!,
                      _item.joinLimit!, _userId)
                  : _onJoinTap(_item.postId, _item.joinedUserIds!,
                      _item.joinLimit!, _userId);
            }
          },
          onLongPress: () {},
          child: SizedText(
            textAlign: TextAlign.center,
            text: _user.isAdmin
                ? "DELETE"
                : _item.joinedUserIds!.contains(_userId)
                    ? "UNDO"
                    : 'JOIN',
            textStyle: latoB14.copyWith(color: ThemeColors.white),
          ),
        ),
        imageUrl: _item.imageUrl,
        desc: _item.description,
        child: CachedImageOrTextImageWidget(
            title: _item.title,
            imageUrl: _item.imageUrl,
            description: _item.description));
  }
}
