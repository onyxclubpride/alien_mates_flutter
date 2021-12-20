import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:smart_house_flutter/mgr/navigation/app_routes.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/mgr/redux/states/nav_state.dart';
import 'package:smart_house_flutter/utils/common/global_widgets.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    if (action is NavigateToAction) {
      return _navigate(store, action);
    } else if (action is ShowPopupAction) {
      return _showPopup(store.state.navigationState, action);
    } else if (action is DismissPopupAction) {
      return _dismissPopup(store.state.navigationState, action);
    } else {
      return next(action);
    }
  }

  // 의도적으로 next() 하지 않음
  void _navigate(Store<AppState> store, NavigateToAction action) {
    var history = store.state.navigationState.history;
    var pages = history.where((v) => v.isPage).map((v) => v.name).toList();

    if (action.to == 'up') {
      String? parentPage =
          pages.length > 1 ? pages[pages.length - 2] : AppRoutes.homeRoute;
      if (parentPage == null || parentPage.isEmpty) {
        _dismissAllPopups(store.state.navigationState);
        Global.navState!.pop();
      } else {
        Global.navState!.popUntil(ModalRoute.withName(parentPage));
      }
      if (parentPage == AppRoutes.homeRoute) {
        GlobalWidgets().reload(AppRoutes.homeRoute);
      }
    } else if (action.to != null && action.to!.startsWith('#')) {
      int? index = int.tryParse(action.to!.substring(1));

      if (index != null && index < history.length) {
        for (int i = 0; i < history.length - index - 1; i++) {
          Global.navState!.pop();
        }
      }
    } else if (action.to != null && pages.contains(action.to)) {
      Global.navState!.popUntil(ModalRoute.withName(action.to!));
      if (action.to == AppRoutes.homeRoute) {
        GlobalWidgets().reload(AppRoutes.homeRoute);
      }

      if (action.reload) {
        GlobalWidgets().reload(action.to);
      }
    } else if (action.to != null) {
      _navigateTo(store, action);
      // } else if (action.page != null) {
      //   _navigatePage(store, action);
    }
  }

  void _navigateTo(Store<AppState> store, NavigateToAction action) {
    // var settingState = store.state.settingState;
    //
    // switch (action.to) {
    //   case AppRoutes.order:
    //     _navigateTo2(store, action);
    //
    //     break;
    //   default:
    //     _navigateTo2(store, action);
    //     break;
    // }
    _navigateTo2(store, action);
  }

  Future<void> _navigateTo2(
      Store<AppState> store, NavigateToAction action) async {
    var navState = store.state.navigationState;
    if (!action.isStayPopup) {
      _dismissAllPopups(navState);
    }
    _pushOrReplaceNamed(action.to, action);
  }

  void _pushOrReplaceNamed(String? to, NavigateToAction action) {
    if (action.replace) {
      Global.navState!
          .pushReplacementNamed(to ?? "", arguments: action.arguments);
    } else {
      Global.navState!.pushNamed(to ?? "", arguments: action.arguments);
    }
  }

  // void _navigatePage(Store<AppState> store, NavigateToAction action) {
  //   _dismissAllPopups(store.state.navigationState);
  //   Global.navState!.push(MaterialPageRoute(builder: (context) => action.page!));
  // }

  _showPopup(NavigationState state, ShowPopupAction action) {
    if (action.dismissAll) {
      _dismissAllPopups(state);
    }
    return action.show(Global.appContext!);
  }

  void _dismissPopup(NavigationState state, DismissPopupAction action) {
    if (action.all) {
      _dismissAllPopups(state);
    } else {
      if (state.history.isNotEmpty && !state.history.last.isPage) {
        Global.navState!.pop(action.result);
      }
    }
  }

  // 현재 페이지 위에 떠 있는 팝업 닫기
  void _dismissAllPopups(NavigationState state) {
    if (state.history.isNotEmpty && !state.history.last.isPage) {
      var popupCount = state.history.length -
          state.history.lastIndexWhere((i) => i.isPage) -
          1;

      for (var i = 0; i < popupCount; i++) {
        Global.navState!.pop();
      }
    }
  }
}
