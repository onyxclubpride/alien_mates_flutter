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

      ///DO SOMETHING
      default:
        next(action);
    }
  }
}

Future<void> _getPostsAction(
    AppState state, GetPostsAction action, NextDispatcher next) async {
  List<PostModelRes> postsList = await _getPostsList();

  print(postsList.first.name);
}

Future<List<PostModelRes>> _getPostsList() async {
  QuerySnapshot _querySnapshot = await firebaseKit.postsCollection.get();
  List _snapshotList = _querySnapshot.docs;
  List<PostModelRes> _posts = [];
  for (int i = 0; i < _snapshotList.length; i++) {
    PostModelRes postModelRes = PostModelRes(name: _snapshotList[i]['name']);
    _posts.add(postModelRes);
  }
  return _posts;
}
