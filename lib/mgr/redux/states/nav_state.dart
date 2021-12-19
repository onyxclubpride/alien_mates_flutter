import 'package:flutter/material.dart';

///
/// NavigationState
///
@immutable
class NavigationState {
  final List history;

  NavigationState({required this.history});

  factory NavigationState.initial() {
    return NavigationState(history: []);
  }

  NavigationState copyWith({List? history}) {
    return NavigationState(history: history ?? this.history);
  }

  String? get current {
    var last = history.lastWhere((v) => v.isPage, orElse: () => null);
    return last != null ? last.name : '/';
  }

  bool hasRoute(String name) {
    return history.indexWhere((i) => i.name == name) != -1;
  }
}
