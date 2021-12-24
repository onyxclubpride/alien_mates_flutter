import 'package:flutter/material.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';

///
/// ApiState
///
@immutable
class ApiState {
  final List<ListPostModelRes> posts;

  ApiState({required this.posts});

  factory ApiState.initial() {
    return ApiState(posts: []);
  }

  ApiState copyWith({List<ListPostModelRes>? posts}) {
    return ApiState(posts: posts ?? this.posts);
  }
}
