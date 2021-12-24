import 'package:flutter/material.dart';

///
/// ApiState
///
@immutable
class ApiState {
  final List posts;

  ApiState({required this.posts});

  factory ApiState.initial() {
    return ApiState(posts: []);
  }

  ApiState copyWith({List? posts}) {
    return ApiState(posts: posts ?? this.posts);
  }
}
