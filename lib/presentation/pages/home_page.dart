import 'dart:ui';

import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/presentation/layout/post_layout.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:lottie/lottie.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime timeBackPressed = DateTime.now();

  bool isliking = false;
  String likingpostid = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child:
            PostLayout(buildWidget: _buildWigdet, postType: PostTypeEnum.POST));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => DefaultBody(
              withNavigationBar: true,
              withTopBanner: true,
              onRefresh: () {
                appStore.dispatch(GetAllKindPostsAction());
              },
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 100.h,
                  //   child: StreamBuilder(
                  //     stream: postsCollection
                  //         .orderBy('createdDate', descending: true)
                  //         .where('isPost', isEqualTo: true)
                  //         .snapshots(),
                  //     builder:
                  //         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //       if (snapshot.hasData) {
                  //         return ListView.builder(
                  //             itemCount: snapshot.data!.docs.length,
                  //             itemBuilder: (context, index) {
                  //               DocumentSnapshot doc =
                  //                   snapshot.data!.docs[index];
                  //               return Text(doc['postId'],
                  //                   style: TextStyle(color: Colors.white));
                  //             });
                  //       } else {
                  //         return Text("No data");
                  //       }
                  //     },
                  //   ),
                  // ),
                  //
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 250.h,
                    child: PaginateFirestore(
                      itemBuilder: (_, documentSnapshots, index) {
                        return _buildWigdet(_, documentSnapshots, index, state);
                      },
                      query: postsCollection
                          .orderBy('createdDate', descending: true)
                          .where('isPost', isEqualTo: true)
                          .limit(1),
                      itemBuilderType: PaginateBuilderType.listView,
                      isLive: true,
                    ),
                  ),
                  _buildPostsWidgetList(state),
                  MainButton(
                    onPressed: _onRefresh,
                    text: "Load more",
                  ),
                  SizedBox(height: 20.h)
                ],
              ))),
    );
  }

  _onRefresh() {
    appStore.dispatch(GetFetchMorePostsAction(isPostOnly: true));
  }

  Widget _buildWigdet(BuildContext ctx, List<DocumentSnapshot> snapshots,
      int index, AppState state) {
    final _item = _getPostModel(snapshots[index]);
    final _userId = state.apiState.userMe.userId;
    return Stack(
      alignment: Alignment.center,
      children: [
        PostItemBanner(
            // withBorder: true,
            onDoubleTap: !isliking
                ? () {
                    if (!isliking) {
                      // _onLikeTap(_item.postId, _item.likedUserIds!, _userId,
                      //     _item);
                    }
                  }
                : null,
            imageUrl: _item.imageUrl,
            desc: _item.description,
            leftWidget: SizedText(
              text: '${_item.likedUserIds!.length}\t\t\u200d🤣'.toUpperCase(),
              textStyle: latoM14.copyWith(color: ThemeColors.fontWhite),
            ),
            child: CachedImageOrTextImageWidget(
                imageUrl: _item.imageUrl, description: _item.description)),
        isliking
            ? likingpostid == _item.postId
                ? _item.likedUserIds!.contains(state.apiState.userMe.userId)
                    ? SizedBox(
                        height: 100.w,
                        width: 150.w,
                        child: LottieBuilder.asset(
                          'assets/lotties/haha_lottie.json',
                        ),
                      )
                    : SizedBox(
                        height: 100.w,
                        width: 150.w,
                        child: LottieBuilder.asset(
                          'assets/lotties/unlike_lottie.json',
                        ),
                      )
                : Container()
            : Container(),
      ],
    );
  }

  PostModelRes _getPostModel(snapshot) {
    final _postDetail = snapshot;
    PostModelRes _postModelRes = PostModelRes(
        createdDate: _postDetail['createdDate'],
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

  Widget _buildPostsWidgetList(AppState state) {
    List<Widget> _list = [];
    List<ListPostModelRes> postsList = state.apiState.posts;
    String _userId = state.apiState.userMe.userId;
    for (int i = 0; i < postsList.length; i++) {
      ListPostModelRes _item = postsList[i];
      if (_item.isPost) {
        _list.add(Stack(
          alignment: Alignment.center,
          children: [
            PostItemBanner(
                // withBorder: true,
                onDoubleTap: !isliking
                    ? () {
                        if (!isliking) {
                          _onLikeTap(_item.postId, _item.likedUserIds!, _userId,
                              _item);
                        }
                      }
                    : null,
                imageUrl: _item.imageUrl,
                desc: _item.description,
                leftWidget: SizedText(
                  text:
                      '${_item.likedUserIds!.length}\t\t\u200d🤣'.toUpperCase(),
                  textStyle: latoM14.copyWith(color: ThemeColors.fontWhite),
                ),
                child: CachedImageOrTextImageWidget(
                    imageUrl: _item.imageUrl, description: _item.description)),
            isliking
                ? likingpostid == _item.postId
                    ? _item.likedUserIds!.contains(state.apiState.userMe.userId)
                        ? SizedBox(
                            height: 100.w,
                            width: 150.w,
                            child: LottieBuilder.asset(
                              'assets/lotties/haha_lottie.json',
                            ),
                          )
                        : SizedBox(
                            height: 100.w,
                            width: 150.w,
                            child: LottieBuilder.asset(
                              'assets/lotties/unlike_lottie.json',
                            ),
                          )
                    : Container()
                : Container(),
          ],
        ));
        _list.add(SizedBox(height: 20.h));
      }
    }
    return Column(children: _list);
  }

  _onLikeTap(
      String postId, List userIds, String userId, ListPostModelRes item) async {
    setState(() {
      isliking = true;
      likingpostid = postId;
    });
    if (!userIds.contains(userId)) {
      List _list = userIds;
      _list.add(userId);
      await appStore.dispatch(GetUpdatePostAction(
          showloading: false,
          listPostModelRes: item,
          islikeact: true,
          postId: postId,
          likedUserIds: _list));
    } else {
      List _list = userIds;
      _list.remove(userId);
      await appStore.dispatch(GetUpdatePostAction(
          islikeact: true,
          showloading: false,
          listPostModelRes: item,
          postId: postId,
          likedUserIds: _list));
    }
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      likingpostid = "";
      isliking = false;
    });
  }

  Future<bool> _onWillPop() {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      const message = 'Press back again to exit';
      Fluttertoast.showToast(
          msg: message,
          fontSize: 18,
          backgroundColor: ThemeColors.white,
          textColor: ThemeColors.bluegray800);
      return Future.value(false);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(false);
    }
  }
}
