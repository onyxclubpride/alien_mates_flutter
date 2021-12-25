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
final postsCollection = firebaseKit.postsCollection;
final usersCollection = firebaseKit.usersCollection;
const uuid = Uuid();
final now = DateTime.now();
final currentDateAndTime =
    "${now.year}.${now.month}.${now.day}T${now.hour}.${now.minute}.${now.second}";
final currentDate = "${now.year}.${now.month}.${now.day}";

class ApiMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetAllKindPostsAction:
        return _GetAllKindPostsAction(store.state, action, next);
      case GetCreatePostAction:
        return _getCreatePostAction(store.state, action, next);
      case GetCreateEventAction:
        return _getCreateEventAction(store.state, action, next);
      case GetCreateNoticeAction:
        return _getCreateNoticeAction(store.state, action, next);
      case GetCreateHelpAction:
        return _getCreateHelpAction(store.state, action, next);
      case GetCreateUserAction:
        return _getCreateUserAction(store.state, action, next);
      case GetAllUsersAction:
        return _getAllUsersAction(store.state, action, next);
      case GetUserMeAction:
        return _getUserMeAction(store.state, action, next);
      default:
        next(action);
    }
  }
}

Future<bool> _GetAllKindPostsAction(
    AppState state, GetAllKindPostsAction action, NextDispatcher next) async {
  List<ListPostModelRes> postsList = await _getPostsList();
  next(UpdateApiStateAction(posts: postsList));
  return postsList.isNotEmpty;
}

Future<List<ListPostModelRes>> _getPostsList() async {
  try {
    QuerySnapshot _querySnapshot = await postsCollection.limit(10).get();
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
        isHelp: item['isHelp'],
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
    String _uid = _generatePostUuid();
    String _userUid = _generateUserUuid();
    showLoading();
    await postsCollection.doc(_uid).set({
      "postId": _uid,
      "title": null,
      "description": action.description,
      "eventLocation": null,
      "imageUrl":
          'https://firebasestorage.googleapis.com/v0/b/alien-mates.appspot.com/o/posts_images%2Ftestid123.jpg?alt=media&token=d8788469-483d-4a35-969e-fafbaa9e9603',
      "userId": _userUid,
      "isPost": true,
      "isEvent": false,
      "isNotice": false,
      "isHelp": false,
      "numberOfLikes": 0,
      "numberOfJoins": null,
      "joinLimit": null,
      "createdDate": currentDateAndTime
    });
    await appStore.dispatch(GetAllKindPostsAction());
    closeLoading();
    return true;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET CREATE POST CATCH ERROR');
    return false;
  }
}

Future<bool> _getCreateNoticeAction(
    AppState state, GetCreateNoticeAction action, NextDispatcher next) async {
  try {
    showLoading();
    String _postUid = _generatePostUuid(type: 'NOTICE_POST');
    String _userUid = _generateUserUuid();
    await postsCollection.doc(_postUid).set({
      "postId": _postUid,
      "eventLocation": null,
      "title": action.title,
      "description": action.description,
      "imageUrl":
          'https://firebasestorage.googleapis.com/v0/b/alien-mates.appspot.com/o/posts_images%2Ftestid123.jpg?alt=media&token=d8788469-483d-4a35-969e-fafbaa9e9603',
      "userId": _userUid,
      "isPost": false,
      "isEvent": false,
      "isNotice": true,
      "isHelp": false,
      "numberOfLikes": null,
      "numberOfJoins": null,
      "joinLimit": null,
      "createdDate": currentDateAndTime
    });
    await appStore.dispatch(GetAllKindPostsAction());
    closeLoading();
    return true;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET Notice POST CATCH ERROR');
    return false;
  }
}

Future<bool> _getCreateEventAction(
    AppState state, GetCreateEventAction action, NextDispatcher next) async {
  try {
    showLoading();
    String _postUid = _generatePostUuid(type: 'EVENT_POST');
    String _userUid = _generateUserUuid();
    await postsCollection.doc(_postUid).set({
      "postId": _postUid,
      "title": action.title,
      "description": action.description,
      "eventLocation": action.eventLocation,
      "imageUrl":
          'https://firebasestorage.googleapis.com/v0/b/alien-mates.appspot.com/o/posts_images%2Ftestid123.jpg?alt=media&token=d8788469-483d-4a35-969e-fafbaa9e9603',
      "userId": _userUid,
      "isPost": false,
      "isEvent": true,
      "isNotice": false,
      "isHelp": false,
      "numberOfLikes": null,
      "numberOfJoins": null,
      "joinLimit": null,
      "createdDate": currentDateAndTime
    });
    await appStore.dispatch(GetAllKindPostsAction());
    closeLoading();
    return true;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET Event POST CATCH ERROR');
    return false;
  }
}

Future<bool> _getCreateHelpAction(
    AppState state, GetCreateHelpAction action, NextDispatcher next) async {
  try {
    showLoading();
    String _postUid = _generatePostUuid(type: 'HELP_POST');
    String _userUid = _generateUserUuid();
    await postsCollection.doc(_postUid).set({
      "postId": _postUid,
      "title": action.title,
      "description": action.description,
      "eventLocation": null,
      "imageUrl":
          'https://firebasestorage.googleapis.com/v0/b/alien-mates.appspot.com/o/posts_images%2Ftestid123.jpg?alt=media&token=d8788469-483d-4a35-969e-fafbaa9e9603',
      "userId": _userUid,
      "isPost": false,
      "isEvent": false,
      "isNotice": false,
      "isHelp": true,
      "numberOfLikes": null,
      "numberOfJoins": null,
      "joinLimit": null,
      "createdDate": currentDateAndTime
    });
    await appStore.dispatch(GetAllKindPostsAction());
    closeLoading();
    return true;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET Help POST CATCH ERROR');
    return false;
  }
}

Future<bool> _getCreateUserAction(
    AppState state, GetCreateUserAction action, NextDispatcher next) async {
  try {
    showLoading();
    String _userUid = _generateUserUuid();
    await usersCollection.doc(_userUid).set({
      "userId": _userUid,
      "name": action.name,
      "phoneNumber": action.phoneNumber,
      "password": action.password,
      "uniName": action.uniName,
      "postIds": [],
      "createdDate": currentDateAndTime,
      "isAdmin": false,
    });
    closeLoading();
    return true;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET Create USER CATCH ERROR');
    return false;
  }
}

Future<bool> _getAllUsersAction(
    AppState state, GetAllUsersAction action, NextDispatcher next) async {
  List<UserModelRes> usersList = await _getUsersList();
  next(UpdateApiStateAction(users: usersList));
  return usersList.isNotEmpty;
}

Future<List<UserModelRes>> _getUsersList() async {
  try {
    QuerySnapshot _querySnapshot = await usersCollection.get();
    List _snapshotList = _querySnapshot.docs;
    List<UserModelRes> _users = [];
    for (int i = 0; i < _snapshotList.length; i++) {
      var item = _snapshotList[i];
      UserModelRes userModelRes = UserModelRes(
        createdDate: item['createdDate'],
        userId: item['userId'],
        phoneNumber: item['phoneNumber'],
        name: item['name'],
        password: item['password'],
        uniName: item['uniName'],
        postIds: item['postIds'],
      );
      _users.add(userModelRes);
    }
    return _users;
  } catch (e) {
    logger(e.toString(), hint: 'GET USERS LIST CATCH ERROR');
    return [];
  }
}

Future<UserModelRes?> _getUserMeAction(
    AppState state, GetUserMeAction action, NextDispatcher next) async {
  for (int i = 0; i < state.apiState.users.length; i++) {
    UserModelRes? _userInst = state.apiState.users[i];
    if (_userInst.phoneNumber == action.phoneNumber &&
        _userInst.password == action.password) {
      next(UpdateApiStateAction(userMe: _userInst));
      next(UpdateInitStateAction(userId: _userInst.userId));
      return _userInst;
    }
  }
}

// Future<bool> _getCreatePostAction(
//     AppState state, GetCreatePostAction action, NextDispatcher next) async {
//   try {
//     showLoading();
//     await firebaseKit.postsCollection.doc(_generatePostUuid()).set({
//       "postId": _generatePostUuid(),
//       "title": action.postModelReq.title,
//       "description": action.postModelReq.description,
//       "imageUrl":
//           'https://firebasestorage.googleapis.com/v0/b/alien-mates.appspot.com/o/posts_images%2Ftestid123.jpg?alt=media&token=d8788469-483d-4a35-969e-fafbaa9e9603',
//       "userId": "USERSHOHID",
//       "isPost": true,
//       "isEvent": false,
//       "isNotice": false,
//       "numberOfLikes": 0,
//       "numberOfJoins": null,
//       "joinLimit": null,
//       "createdDate": currentDateAndTime
//     });
//     await appStore.dispatch(GetAllKindPostsAction());
//     closeLoading();
//     return true;
//   } catch (e) {
//     closeLoading();
//     logger(e.toString(), hint: 'GET CREATE POST CATCH ERROR');
//     return false;
//   }
// }

String _generatePostUuid({String type = "POST_POST"}) {
  final uid = uuid.v1();
  String postIdFormat = "${type}_${currentDate}_$uid";
  return postIdFormat;
}

String _generateUserUuid() {
  final uid = uuid.v1();
  String userIdFormat = "USER_${currentDate}_$uid";
  return userIdFormat;
}

showLoading() {
  showLoadingDialog(Global.navState!.context);
}

closeLoading() {
  appStore.dispatch(DismissPopupAction(all: true));
}
