import 'package:flutter/material.dart';
import 'package:smart_house_flutter/mgr/models/model_exporter.dart';

///
/// ApiState
///
@immutable
class ApiState {
  final List<ListPostModelRes> posts;
  final List<PostOnlyModel> postOnly;

  ApiState({required this.posts, required this.postOnly});

  factory ApiState.initial() {
    return ApiState(posts: [], postOnly: []);
  }

  ApiState copyWith(
      {List<ListPostModelRes>? posts, List<PostOnlyModel>? postOnly}) {
    return ApiState(
      posts: posts ?? this.posts,
      postOnly: postOnly ?? this.postOnly,
    );
  }
}
