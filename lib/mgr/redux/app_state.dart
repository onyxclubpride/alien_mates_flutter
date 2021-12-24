import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:smart_house_flutter/mgr/redux/middleware/api_middleware.dart';
import 'package:smart_house_flutter/mgr/redux/reducer.dart';
import 'package:smart_house_flutter/mgr/redux/states/api_state.dart';
import 'package:smart_house_flutter/mgr/redux/states/nav_state.dart';
import 'middleware/navigation_middleware.dart';

export './states/nav_state.dart';

final appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    ApiMiddleware(),
    NavigationMiddleware(),
  ],
);

@immutable
class AppState {
  final NavigationState navigationState;
  final ApiState apiState;
  AppState({
    required this.navigationState,
    required this.apiState,
  });

  factory AppState.initial() {
    return AppState(
      navigationState: NavigationState.initial(),
      apiState: ApiState.initial(),
    );
  }

  AppState copyWith({
    NavigationState? navigationState,
    ApiState? apiState,
  }) {
    return AppState(
      navigationState: navigationState ?? this.navigationState,
      apiState: apiState ?? this.apiState,
    );
  }
}
