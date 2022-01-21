import 'package:flutter/material.dart';

///
/// InitState
///
@immutable
class InitState {
  final String userId;
  final bool isDarkTheme;
  InitState({required this.userId, required this.isDarkTheme});

  factory InitState.initial() {
    return InitState(userId: "", isDarkTheme: true);
  }

  InitState copyWith({String? userId, bool? isDarkTheme}) {
    return InitState(
        userId: userId ?? this.userId,
        isDarkTheme: isDarkTheme ?? this.isDarkTheme);
  }

  bool get isDark => isDarkTheme;

}
