import 'package:flutter/material.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';
export "./app_state.dart";

///----------------- Navigation -----------------
class NavigateToAction {
  final String? to;
  final bool replace;
  final dynamic arguments;

  // final Widget? page;
  final bool reload;
  final bool isStayPopup;

  NavigateToAction(
      {this.to,
      this.replace = false,
      this.arguments,
      // this.page,
      this.reload = false,
      this.isStayPopup = false});
}

class NavigateToOrderAction {}

class NavigateToPayListAction {}

class UpdateNavigationAction {
  final String? name;
  final bool? isPage;
  final String? method;

  UpdateNavigationAction({this.name, this.isPage, this.method});
}

class ShowPopupAction<T> {
  final bool barrierDismissible;
  final WidgetBuilder? builder;
  final bool dismissAll;

  ShowPopupAction(
      {this.barrierDismissible = true, this.builder, this.dismissAll = true});

  Future<T?> show(BuildContext context) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: builder!);
  }
}

class DismissPopupAction {
  final bool all;
  final dynamic result;

  DismissPopupAction({this.all = false, this.result});
}

///----------------- API -----------------

class GetAllKindPostsAction {}

class UpdateApiStateAction {
  List<ListPostModelRes>? posts;
  List<PostOnlyModel>? postOnly;
  List<UserModelRes>? users;
  UserModelRes? userMe;

  UpdateApiStateAction({this.posts, this.postOnly, this.users, this.userMe});
}

class GetStateInitAction {}

class GetCreatePostAction {
  String? description;
  String? imagePath;
  GetCreatePostAction({this.description, this.imagePath});
}

class GetCreateNoticeAction {
  String? imagePath;
  String title;
  String description;
  GetCreateNoticeAction(
      {required this.title, this.imagePath, required this.description});
}

class GetCreateEventAction {
  String? imagePath;
  String title;
  String description;
  int? joinLimit;
  String eventLocation;
  GetCreateEventAction(
      {required this.title,
      required this.description,
      this.imagePath,
      this.joinLimit,
      required this.eventLocation});
}

class GetCreateHelpAction {
  String title;
  String description;
  String? imagePath;
  GetCreateHelpAction(
      {required this.title, required this.description, this.imagePath});
}

class GetCreateUserAction {
  String phoneNumber;
  String name;
  String password;
  String uniName;

  GetCreateUserAction(
      {required this.phoneNumber,
      required this.uniName,
      required this.password,
      required this.name});
}

class GetUserMeAction {
  String phoneNumber;
  String password;
  GetUserMeAction({required this.phoneNumber, required this.password});
}

class GetAllUsersAction {}

///----------------- Init -----------------

class GetLocalUserIdAction {}

class SetLocalUserIdAction {
  String userId;

  SetLocalUserIdAction(this.userId);
}

class UpdateInitStateAction {
  String? userId;
  UpdateInitStateAction({this.userId});
}
