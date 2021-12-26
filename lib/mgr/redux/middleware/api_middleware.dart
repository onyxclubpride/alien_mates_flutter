import 'dart:io';

import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/utils/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:alien_mates/mgr/firebase/firebase_kit.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/presentation/template/base/template.dart';
import 'package:alien_mates/utils/common/global_widgets.dart';
import 'package:alien_mates/utils/common/log_tester.dart';
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
        return _getAllKindPostsAction(store.state, action, next);
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
      case GetUserIdExistAction:
        return _getUserIdExistAction(store.state, action, next);
      case GetLoginAction:
        return _getLoginAction(store.state, action, next);
      case GetPostByIdAction:
        return _getPostByIdAction(store.state, action, next);
      case GetUserByIdAction:
        return _getUserByIdAction(store.state, action, next);
      case GetUpdatePostAction:
        return _getUpdatePostAction(store.state, action, next);
      case GetDeletePostAction:
        return _getDeletePostAction(store.state, action, next);
      case GetSelectImageAction:
        return _getSelectImageAction(store.state, action, next);
      case GetImageDownloadLinkAction:
        return _getImageDownloadLinkAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

Future<bool> _getAllKindPostsAction(
    AppState state, GetAllKindPostsAction action, NextDispatcher next) async {
  List<ListPostModelRes> postsList = await _getPostsList();
  next(UpdateApiStateAction(posts: postsList));
  return postsList.isNotEmpty;
}

Future<List<ListPostModelRes>> _getPostsList() async {
  try {
    QuerySnapshot _querySnapshot = await postsCollection.get();
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
        joinedUserIds: item['joinedUserIds'],
        numberOfLikes: item['numberOfLikes'],
        title: item['title'],
        joinLimit: item['joinLimit'],
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
      "joinedUserIds": null,
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
      "joinedUserIds": null,
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
    String? downUrl;
    if (action.imagePath != null) {
      downUrl = await appStore
          .dispatch(GetImageDownloadLinkAction(action.imagePath!));
    }
    await postsCollection.doc(_postUid).set({
      "postId": _postUid,
      "title": action.title,
      "description": action.description,
      "eventLocation": action.eventLocation,
      "imageUrl": downUrl,
      "userId": _userUid,
      "isPost": false,
      "isEvent": true,
      "isNotice": false,
      "isHelp": false,
      "numberOfLikes": null,
      "joinedUserIds": [],
      "joinLimit": action.joinLimit ?? 0,
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
    String? _downUrl;
    if (action.imagePath != null) {
      _downUrl = await appStore.dispatch(
          GetImageDownloadLinkAction(action.imagePath!, postType: 'HELP'));
    }
    await postsCollection.doc(_postUid).set({
      "postId": _postUid,
      "title": action.title,
      "description": action.description,
      "eventLocation": null,
      "imageUrl": _downUrl,
      "userId": _userUid,
      "isPost": false,
      "isEvent": false,
      "isNotice": false,
      "isHelp": true,
      "numberOfLikes": null,
      "joinedUserIds": null,
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

Future<List<UserModelRes>> _getAllUsersAction(
    AppState state, GetAllUsersAction action, NextDispatcher next) async {
  List<UserModelRes> usersList = await _getUsersList();
  next(UpdateApiStateAction(users: usersList));
  return usersList;
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

Future<void> _getUserIdExistAction(
    AppState state, GetUserIdExistAction action, NextDispatcher next) async {
  try {
    final postsFetched = await appStore.dispatch(GetAllKindPostsAction());
    if (postsFetched) {
      for (int i = 0; i < state.apiState.users.length; i++) {
        UserModelRes _userInst = state.apiState.users[i];
        if (_userInst.userId == action.userId) {
          next(UpdateApiStateAction(userMe: _userInst));
          next(UpdateInitStateAction(userId: _userInst.userId));
        }
      }
      appStore.dispatch(
          NavigateToAction(to: AppRoutes.homePageRoute, replace: true));
    }
  } catch (e) {
    logger(e.toString(), hint: 'GET USER ID CATCH ERROR');
  }
}

Future<bool> _getLoginAction(
    AppState state, GetLoginAction action, NextDispatcher next) async {
  try {
    bool _matched = false;
    showLoading();
    List<UserModelRes> users = await appStore.dispatch(GetAllUsersAction());
    if (users.isNotEmpty) {
      for (int i = 0; i < users.length; i++) {
        UserModelRes? _userInst = users[i];
        bool _matched = _userInst.phoneNumber == action.phoneNumber &&
            _userInst.password == action.password;
        if (_matched) {
          next(UpdateApiStateAction(userMe: _userInst));
          next(UpdateInitStateAction(userId: _userInst.userId));
          await appStore.dispatch((SetLocalUserIdAction(_userInst.userId)));
          await appStore.dispatch(GetAllKindPostsAction());
          appStore.dispatch(
              NavigateToAction(to: AppRoutes.homePageRoute, replace: true));
        }
      }
    }
    closeLoading();
    return _matched;
  } catch (e) {
    logger(e.toString(), hint: 'GET LOGIN CATCH ERROR');
    return false;
  }
}

Future<PostModelRes?> _getPostByIdAction(
    AppState state, GetPostByIdAction action, NextDispatcher next) async {
  try {
    showLoading();
    final _postDetail = await postsCollection.doc(action.postId).get();
    PostModelRes _postModelRes = PostModelRes(
      createdDate: _postDetail['createdDate'],
      postId: _postDetail['postId'],
      isNotice: _postDetail['isNotice'],
      isPost: _postDetail['isPost'],
      userId: _postDetail['userId'],
      isEvent: _postDetail['isEvent'],
      isHelp: _postDetail['isHelp'],
      numberOfLikes: _postDetail['numberOfLikes'],
      joinedUserIds: _postDetail['joinedUserIds'],
      description: _postDetail['description'],
      title: _postDetail['title'],
      joinLimit: _postDetail['joinLimit'],
      imageUrl: _postDetail['imageUrl'],
    );
    next(UpdateApiStateAction(postDetail: _postModelRes));
    closeLoading();
    return _postModelRes;
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET 1 POST CATCH ERROR');
  }
}

Future<bool> _getUpdatePostAction(
    AppState state, GetUpdatePostAction action, NextDispatcher next) async {
  try {
    showLoading();
    PostModelRes? _postById =
        await appStore.dispatch(GetPostByIdAction(action.postId));
    if (_postById != null) {
      PostModelRes _postModelRes = PostModelRes(
        createdDate: action.createdDate ?? _postById.createdDate,
        postId: action.postId,
        isNotice: action.isNotice ?? _postById.isNotice,
        isPost: action.isPost ?? _postById.isPost,
        userId: action.userId ?? _postById.userId,
        isEvent: action.isEvent ?? _postById.isEvent,
        isHelp: action.isHelp ?? _postById.isHelp,
        numberOfLikes: action.numberOfLikes ?? _postById.numberOfLikes,
        joinedUserIds: action.joinedUserIds ?? _postById.joinedUserIds,
        description: action.description ?? _postById.description,
        title: action.title ?? _postById.title,
        joinLimit: action.joinLimit ?? _postById.joinLimit,
        imageUrl: action.imageUrl ?? _postById.imageUrl,
      );
      await postsCollection.doc(action.postId).update({
        "createdDate": _postModelRes.createdDate,
        "postId": _postModelRes.postId,
        "isNotice": _postModelRes.isNotice,
        "isPost": _postModelRes.isPost,
        "userId": _postModelRes.userId,
        "isEvent": _postModelRes.isEvent,
        "isHelp": _postModelRes.isHelp,
        "numberOfLikes": _postModelRes.numberOfLikes,
        "joinedUserIds": _postModelRes.joinedUserIds,
        "description": _postModelRes.description,
        "title": _postModelRes.title,
        "joinLimit": _postModelRes.joinLimit,
        "imageUrl": _postModelRes.imageUrl,
      });
      next(UpdateApiStateAction(postDetail: _postModelRes));
      await appStore.dispatch(GetAllKindPostsAction());
      closeLoading();
    }
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET UPDATE POST CATCH ERROR');
  }
  return true;
}

Future<void> _getDeletePostAction(
    AppState state, GetDeletePostAction action, NextDispatcher next) async {
  try {
    showLoading();
    await postsCollection.doc(action.postId).delete();
    await appStore.dispatch(GetAllKindPostsAction());
    closeLoading();
  } catch (e) {
    closeLoading();
    logger(e.toString(), hint: 'GET DELETE POST CATCH ERROR');
  }
}

Future<String?> _getImageDownloadLinkAction(AppState state,
    GetImageDownloadLinkAction action, NextDispatcher next) async {
  try {
    File _file = File(action.imagePath);
    String _postUid = _generatePostUuid(type: action.postType);

    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref("/${Constants.firebaseStorageImagesFolderName}/$_postUid")
        .putFile(_file);
    String downUrl = await taskSnapshot.ref.getDownloadURL();
    return downUrl;
  } catch (e) {
    logger(e.toString(), hint: 'GET IMAGE DOWNLOAD LINK POST CATCH ERROR');
  }
}

Future<void> _getUserByIdAction(
    AppState state, GetUserByIdAction action, NextDispatcher next) async {
  // final _test = await usersCollection
  //     //'USER_2021.12.25_f547d420-657f-11ec-8de4-a59789f4ac63'
  //     .doc(action.userId)
  //     .get();
  // logger(_test, hint: '1 USER');
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
//       "joinedUserIds": null,
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

String _generatePostUuid({String? type}) {
  final uid = uuid.v1();
  String postIdFormat = "${type ?? "POST_POST"}_${currentDate}_$uid";
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

Future<String?> _getSelectImageAction(
    AppState state, GetSelectImageAction action, NextDispatcher next) async {
  try {
    final ImagePicker _picker = ImagePicker();
    XFile? xImage;
    xImage = await _picker.pickImage(
        source: action.withCamera ? ImageSource.camera : ImageSource.gallery);

    if (xImage != null) {
      return xImage.path;
    }
  } catch (e) {
    logger(e.toString(), hint: 'GET SELECT IMAGE CATCH ERROR');
  }
}
