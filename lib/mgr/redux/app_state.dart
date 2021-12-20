import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:smart_house_flutter/mgr/redux/reducer.dart';
import 'package:smart_house_flutter/mgr/redux/states/nav_state.dart';
import 'middleware/navigation_middleware.dart';

export './states/nav_state.dart';

final appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    NavigationMiddleware(),
  ],
);

@immutable
class AppState {
  final NavigationState navigationState;
  AppState({
    required this.navigationState,
  });

  factory AppState.initial() {
    return AppState(
      navigationState: NavigationState.initial(),
    );
  }

  AppState copyWith({
    NavigationState? navigationState,
  }) {
    return AppState(
      navigationState: navigationState ?? this.navigationState,
    );
  }
}
