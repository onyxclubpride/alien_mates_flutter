import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:smart_house_flutter/mgr/firebase/firebase_kit.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/presentation/template/base/template.dart';
import 'package:smart_house_flutter/utils/common/global_widgets.dart';
import 'package:smart_house_flutter/utils/common/log_tester.dart';
import 'package:uuid/uuid.dart';

FirebaseKit firebaseKit = FirebaseKit();
final uuid = Uuid();
final now = DateTime.now();
final currentDate = "${now.year}.${now.month}.${now.day}";

class ApiMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetPostsAction:
        return _getPostsAction(store.state, action, next);
      case GetCreatePostAction:
        return _getCreatePostAction(store.state, action, next);
      default:
        next(action);
    }
  }
}

Future<bool> _getPostsAction(
    AppState state, GetPostsAction action, NextDispatcher next) async {
  List<ListPostModelRes> postsList = await _getPostsList();
  next(UpdateApiStateAction(posts: postsList));
  return postsList.isNotEmpty;
}

Future<List<ListPostModelRes>> _getPostsList() async {
  try {
    QuerySnapshot _querySnapshot =
        await firebaseKit.postsCollection.limit(10).get();
    List _snapshotList = _querySnapshot.docs;
    List<ListPostModelRes> _posts = [];
    for (int i = 0; i < _snapshotList.length; i++) {
      var item = _snapshotList[i];
      ListPostModelRes postModelRes = ListPostModelRes(
        createdDate: item['createdDate'],
        postId: item['postId'],
        isEvent: item['isEvent'],
        isNotice: item['isNotice'],
        isPost: item['isPost'],
        imageUrl: item['imageUrl'],
        description: item['description'],
        numberOfJoins: item['numberOfJoins'],
        numberOfLikes: item['numberOfLikes'],
        title: item['title'],
      );
      _posts.add(postModelRes);
    }
    return _posts;
  } catch (e) {
    logger(e.toString(), hint: 'GET POSTS LIST CATCH ERROR');
    return [];
  }
}

Future<bool> _getCreatePostAction(
    AppState state, GetCreatePostAction action, NextDispatcher next) async {
  try {
    showLoading();
    await firebaseKit.postsCollection.doc(_generatePostUuid()).set({
      "postId": _generatePostUuid(),
      "title": action.postModelReq.title,
      "description": action.postModelReq.description,
      "imageUrl":
          'https://firebasestorage.googleapis.com/v0/b/alien-mates.appspot.com/o/posts_images%2Ftestid123.jpg?alt=media&token=d8788469-483d-4a35-969e-fafbaa9e9603',
      "userId": "USERSHOHID",
      "isPost": true,
      "isEvent": false,
      "isNotice": false,
      "numberOfLikes": 0,
      "numberOfJoins": null,
      "joinLimit": null,
      "createdDate": currentDate
    });
    await appStore.dispatch(GetPostsAction());
    closeLoading();
    return true;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET CREATE POST CATCH ERROR');
    return false;
  }
}

String _generatePostUuid() {
  final uid = uuid.v1();
  String postIdFormat = "POST_${currentDate}_$uid";
  return postIdFormat;
}

showLoading() {
  showLoadingDialog(Global.navState!.context);
}

closeLoading() {
  appStore.dispatch(DismissPopupAction(all: true));
}
