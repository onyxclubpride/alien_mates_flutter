import 'package:flutter/material.dart';
import 'package:alien_mates/mgr/models/model_exporter.dart';

///
/// ApiState
///
@immutable
class ApiState {
  final List<ListPostModelRes> posts;
  final List<PostOnlyModel> postOnly;
  final List<UserModelRes> users;
  final UserModelRes userMe;

  ApiState(
      {required this.posts,
      required this.postOnly,
      required this.users,
      required this.userMe});

  factory ApiState.initial() {
    return ApiState(
        posts: [],
        postOnly: [],
        users: [],
        userMe: UserModelRes(
            userId: "",
            phoneNumber: "",
            name: "",
            password: "",
            createdDate: "",
            uniName: '',
            postIds: []));
  }

  ApiState copyWith({
    List<ListPostModelRes>? posts,
    List<PostOnlyModel>? postOnly,
    List<UserModelRes>? users,
    UserModelRes? userMe,
  }) {
    return ApiState(
      posts: posts ?? this.posts,
      postOnly: postOnly ?? this.postOnly,
      users: users ?? this.users,
      userMe: userMe ?? this.userMe,
    );
  }
}
