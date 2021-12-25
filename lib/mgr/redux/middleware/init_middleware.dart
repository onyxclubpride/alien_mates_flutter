import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:smart_house_flutter/mgr/firebase/firebase_kit.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';
import 'package:smart_house_flutter/mgr/navigation/app_routes.dart';
import 'package:smart_house_flutter/mgr/redux/action.dart';
import 'package:smart_house_flutter/mgr/redux/app_state.dart';
import 'package:smart_house_flutter/utils/common/log_tester.dart';

class InitMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetStateInitAction:
        return _getStateInitAction(store.state, action, next);
      default:
        next(action);
    }
  }
}

Future<void> _getStateInitAction(
    AppState state, GetStateInitAction action, NextDispatcher next) async {
  final postsFetched = await next(GetAllKindPostsAction());
  if (postsFetched) {
    appStore
        .dispatch(NavigateToAction(to: AppRoutes.homePageRoute, replace: true));
  }
}
