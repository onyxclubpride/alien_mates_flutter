import 'package:flutter/material.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';

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

class GetPostsAction {}

class UpdateApiStateAction {
  List<ListPostModelRes>? posts;

  UpdateApiStateAction({this.posts});
}
