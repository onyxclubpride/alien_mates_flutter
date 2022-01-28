import 'package:alien_mates/presentation/layout/post_layout.dart';
import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime timeBackPressed = DateTime.now();

  bool isliking = false;
  String likingpostid = "";
  bool startLiking = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child:
            PostLayout(buildWidget: _buildWidget, postType: PostTypeEnum.POST));
  }

  Widget _buildWidget(BuildContext ctx, List<DocumentSnapshot> snapshots,
      int index, AppState state) {
    final _item = _getPostModel(snapshots[index]);
    final _userId = state.apiState.userMe.userId;
    return Stack(
      alignment: Alignment.center,
      children: [
        PostItemBanner(
            onDoubleTap: !isliking
                ? () {
                    if (!isliking) {
                      _onLikeTap(
                          _item.postId, _item.likedUserIds!, _userId, _item);
                    }
                  }
                : null,
            imageUrl: _item.imageUrl,
            desc: _item.description,
            leftWidget: SpacedRow(
              horizontalSpace: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!startLiking && likingpostid != _item.postId)
                  SizedText(
                    text: _item.likedUserIds!.length.toString(),
                    textStyle: latoM14.copyWith(color: ThemeColors.fontWhite),
                  )
                else
                  SpinKitSpinningLines(size: 15.h, color: Colors.white),
                Icon(Ionicons.heart_circle,
                    color: ThemeColors.white, size: 15.h)
              ],
            ),
            child: CachedImageOrTextImageWidget(
                imageUrl: _item.imageUrl, description: _item.description)),
        likingpostid == _item.postId
            ? Visibility(
                visible: isliking,
                child: SizedBox(
                  height: 100.w,
                  width: 150.w,
                  child: LottieBuilder.asset(
                    !_item.likedUserIds!.contains(_userId)
                        ? 'assets/lotties/haha_lottie.json'
                        : 'assets/lotties/unlike_lottie.json',
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  ListPostModelRes _getPostModel(snapshot) {
    final _postDetail = snapshot;
    ListPostModelRes _postModelRes = ListPostModelRes(
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
        imageUrl: _postDetail['imageUrl']);
    return _postModelRes;
  }

  _onLikeTap(
      String postId, List userIds, String userId, ListPostModelRes item) async {
    setState(() {
      startLiking = true;
      isliking = true;
      likingpostid = postId;
    });
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      isliking = false;
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
    setState(() {
      likingpostid = "";
      startLiking = false;
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
