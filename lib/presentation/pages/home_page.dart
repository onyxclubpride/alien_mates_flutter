import 'package:alien_mates/presentation/widgets/cached_image_or_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/presentation/template/base/template.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlareControls flareControls = FlareControls();

  bool isliking = false;
  String likingpostid = "";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => DefaultBody(
            withNavigationBar: true,
            withTopBanner: true,
            child: _buildPostsWidgetList(state)));
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
                withBorder: true,
                onDoubleTap: !isliking
                    ? () {
                        flareControls.play("like");
                        if (!isliking) {
                          _onLikeTap(_item.postId, _item.likedUserIds!, _userId,
                              _item);
                        }
                      }
                    : null,
                imageUrl: _item.imageUrl,
                desc: _item.description,
                leftWidget: SizedText(
                  text: '${_item.likedUserIds!.length}\thaha'.toUpperCase(),
                  textStyle: latoM12.copyWith(color: ThemeColors.fontWhite),
                ),
                rightWidget: isliking
                    ? likingpostid == _item.postId
                        ? SpinKitThreeBounce(
                            color: Colors.black,
                            size: 10.h,
                          )
                        : IconButton(
                            splashColor: Colors.transparent,
                            iconSize: 15.h,
                            icon: Icon(_item.likedUserIds!.contains(_userId)
                                ? Ionicons.happy
                                : Ionicons.happy_outline),
                            onPressed: () {
                              if (!isliking) {
                                _onLikeTap(_item.postId, _item.likedUserIds!,
                                    _userId, _item);
                              }
                            },
                          )
                    : IconButton(
                        splashColor: Colors.transparent,
                        iconSize: 15.h,
                        icon: Icon(
                          _item.likedUserIds!.contains(_userId)
                              ? Ionicons.happy
                              : Ionicons.happy_outline,
                          color: ThemeColors.fontWhite,
                        ),
                        onPressed: () {
                          if (!isliking) {
                            _onLikeTap(_item.postId, _item.likedUserIds!,
                                _userId, _item);
                          }
                        },
                      ),
                child: CachedImageOrTextImageWidget(
                    imageUrl: _item.imageUrl, description: _item.description)),
            isliking
                ? likingpostid == _item.postId
                    ? Container(
                        height: 100,
                        width: 100,
                        child: FlareActor(
                          'assets/instagram_like.flr',
                          controller: flareControls,
                          color: Colors.white,
                          animation: 'idle',
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
    setState(() {
      likingpostid = "";
      isliking = false;
    });
  }
}
