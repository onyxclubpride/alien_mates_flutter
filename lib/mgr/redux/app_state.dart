import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:alien_mates/mgr/redux/middleware/init_middleware.dart';
import 'package:alien_mates/mgr/redux/reducer.dart';
import 'package:alien_mates/mgr/redux/states/api_state.dart';
import 'package:alien_mates/mgr/redux/states/init_state.dart';
import 'package:alien_mates/mgr/redux/states/nav_state.dart';
import 'middleware/navigation_middleware.dart';

export './states/nav_state.dart';

final appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    InitMiddleware(),
    ApiMiddleware(),
    NavigationMiddleware(),
  ],
);

@immutable
class AppState {
  final NavigationState navigationState;
  final ApiState apiState;
  final InitState initState;
  const AppState({
    required this.navigationState,
    required this.apiState,
    required this.initState,
  });

  factory AppState.initial() {
    return AppState(
      navigationState: NavigationState.initial(),
      apiState: ApiState.initial(),
      initState: InitState.initial(),
    );
  }

  AppState copyWith({
    NavigationState? navigationState,
    ApiState? apiState,
    InitState? initState,
  }) {
    return AppState(
      navigationState: navigationState ?? this.navigationState,
      apiState: apiState ?? this.apiState,
      initState: initState ?? this.initState,
    );
  }
}
