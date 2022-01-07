import 'package:alien_mates/mgr/models/univ_model/univ_model.dart';
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
  final PostModelRes postDetail;
  final String selectedUni;
  final List<UnivModelRes> univs;
  final UserModelRes postDetailUser;
  final List<PostModelRes> bannerPosts;

  ApiState(
      {required this.posts,
      required this.postOnly,
      required this.users,
      required this.userMe,
      required this.selectedUni,
      required this.univs,
      required this.postDetail,
      required this.postDetailUser,
      required this.bannerPosts});

  factory ApiState.initial() {
    return ApiState(
        posts: [],
        postOnly: [],
        users: [],
        bannerPosts: [],
        postDetail: PostModelRes(
            createdDate: '',
            postId: "",
            isNotice: false,
            isPost: false,
            userId: "",
            isEvent: false,
            isHelp: false,
            likedUserIds: [],
            joinedUserIds: [],
            description: "",
            title: "",
            joinLimit: 0,
            imageUrl: "",
            eventLocation: ""),
        postDetailUser: UserModelRes(
            userId: "",
            phoneNumber: "",
            name: "",
            password: "",
            createdDate: "",
            uniName: '',
            postIds: []),
        userMe: UserModelRes(
            userId: "",
            phoneNumber: "",
            name: "",
            password: "",
            createdDate: "",
            uniName: '',
            postIds: []),
        univs: [],
        selectedUni: '');
  }

  ApiState copyWith({
    List<ListPostModelRes>? posts,
    List<PostOnlyModel>? postOnly,
    List<UserModelRes>? users,
    UserModelRes? userMe,
    PostModelRes? postDetail,
    List<UnivModelRes>? univs,
    String? selectedUni,
    UserModelRes? postDetailUser,
    List<PostModelRes>? bannerPosts,
  }) {
    return ApiState(
      posts: posts ?? this.posts,
      postOnly: postOnly ?? this.postOnly,
      users: users ?? this.users,
      userMe: userMe ?? this.userMe,
      postDetail: postDetail ?? this.postDetail,
      selectedUni: selectedUni ?? this.selectedUni,
      univs: univs ?? this.univs,
      postDetailUser: postDetailUser ?? this.postDetailUser,
      bannerPosts: bannerPosts ?? this.bannerPosts,
    );
  }
}
