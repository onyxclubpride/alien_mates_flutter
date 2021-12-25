import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:smart_house_flutter/mgr/firebase/firebase_kit.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';

FirebaseKit firebaseKit = FirebaseKit();

class ApiMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetPostsAction:
        return _getPostsAction(store.state, action, next);
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
  QuerySnapshot _querySnapshot =
      await firebaseKit.postsCollection.limit(10).get();
  List _snapshotList = _querySnapshot.docs;
  List<ListPostModelRes> _posts = [];
  for (int i = 0; i < _snapshotList.length; i++) {
    var item = _snapshotList[i];
    ListPostModelRes postModelRes = ListPostModelRes(
      isEvent: item['isEvent'],
      isNotice: item['isNotice'],
      isPost: item['isPost'],
      postId: item['postId'],
      imageUrl: item['imageUrl'],
      description: item['description'],
      numberOfJoins: item['numberOfJoins'],
      numberOfLikes: item['numberOfLikes'],
      title: item['title'],
    );
    _posts.add(postModelRes);
  }
  return _posts;
}
