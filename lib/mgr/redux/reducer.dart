import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:alien_mates/mgr/redux/action.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/mgr/redux/states/init_state.dart';
import './app_state.dart';
import 'dart:developer' as developer;

AppState appReducer(AppState state, dynamic action) {
  var newState = state.copyWith(
    navigationState: _navReducer(state.navigationState, action),
    apiState: _apiReducer(state.apiState, action),
    initState: _initReducer(state.initState, action),
  );

  return newState;
}

///
/// Navigation Reducer
///
final _navReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, UpdateNavigationAction>(_updateNavigationState),
]);

NavigationState _updateNavigationState(
    NavigationState state, UpdateNavigationAction action) {
  developer.log(
      '--- NAVIGATE TO ${action.name} (${action.isPage! ? 'PAGE' : 'POPUP'}) by ${action.method!.toUpperCase()} ---');
  var history = List.from(state.history);

  switch (action.method) {
    case 'push':
      if (action.name == '/') {
        history.insert(0, action);
      } else {
        history.add(action);
      }
      break;
    case 'pop':
      if (history.isNotEmpty) {
        history.removeLast();
      }
      break;
    case 'replace':
      if (history.isNotEmpty) {
        history.removeLast();
      }

      history.add(action);
      break;
  }

  if (kDebugMode) {
    developer.log('------------HISTORY-------------');

    for (var i in history.reversed) {
      developer.log('${i.isPage ? 'page' : 'popup'} - ${i.name}');
    }

    developer.log('--------------------------------');
  }

  return state.copyWith(history: history);
}

///
/// ApiState Reducer
///
final _apiReducer = combineReducers<ApiState>([
  TypedReducer<ApiState, UpdateApiStateAction>(_updateApiState),
]);

ApiState _updateApiState(ApiState state, UpdateApiStateAction action) {
  return state.copyWith(
    posts: action.posts ?? state.posts,
    postOnly: action.postOnly ?? state.postOnly,
    users: action.users ?? state.users,
    userMe: action.userMe ?? state.userMe,
    postDetail: action.postDetail ?? state.postDetail,
    selectedUni: action.selectedUni ?? state.selectedUni,
    univs: action.univs ?? state.univs,
  );
}

///
/// InitState Reducer
///
final _initReducer = combineReducers<InitState>([
  TypedReducer<InitState, UpdateInitStateAction>(_updateInitState),
]);

InitState _updateInitState(InitState state, UpdateInitStateAction action) {
  return state.copyWith(userId: action.userId ?? state.userId);
}
