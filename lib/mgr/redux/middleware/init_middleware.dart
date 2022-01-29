import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alien_mates/mgr/navigation/app_routes.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/app_state.dart';
import 'package:alien_mates/utils/common/constants.dart';

class InitMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetStateInitAction:
        return _getStateInitAction(store.state, action, next);
      case GetLocalUserIdAction:
        return _getLocalUserIdAction(store.state, action, next);
      case SetLocalUserIdAction:
        return _setLocalUserIdAction(store.state, action, next);
      case RemoveLocalUserIdAction:
        return _removeLocalUserIdAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

Future<void> _getStateInitAction(
    AppState state, GetStateInitAction action, NextDispatcher next) async {
  String? _localUserId = await appStore.dispatch(GetLocalUserIdAction());
  if (_localUserId != null) {
    await appStore.dispatch(GetUserIdExistAction(_localUserId));
  } else {
    await appStore.dispatch(GetSearchUniversityAction());
    appStore.dispatch(
        NavigateToAction(to: AppRoutes.loginPageRoute, replace: true));
  }
}

Future<String?> _getLocalUserIdAction(
    AppState state, GetLocalUserIdAction action, NextDispatcher next) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? userId = _prefs.getString(Constants.localUserIdKey);
  return userId;
}

Future<bool> _setLocalUserIdAction(
    AppState state, SetLocalUserIdAction action, NextDispatcher next) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool? success =
      await _prefs.setString(Constants.localUserIdKey, action.userId);
  return success;
}

Future<bool> _removeLocalUserIdAction(
    AppState state, RemoveLocalUserIdAction action, NextDispatcher next) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool? success = await _prefs.remove(Constants.localUserIdKey);
  return success;
}
