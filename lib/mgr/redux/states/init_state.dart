import 'package:flutter/material.dart';

///
/// InitState
///
@immutable
class InitState {
  final String userId;
  InitState({required this.userId});

  factory InitState.initial() {
    return InitState(userId: "");
  }

  InitState copyWith({String? userId}) {
    return InitState(userId: userId ?? this.userId);
  }
}
