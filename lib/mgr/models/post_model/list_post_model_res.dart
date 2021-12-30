class ListPostModelRes {
  bool success;
  String? imageUrl;
  List? likedUserIds;
  int? joinLimit;
  List? joinedUserIds;
  String? title;
  String? description;
  bool isPost;
  bool isEvent;
  bool isNotice;
  bool isHelp;
  String postId;
  String createdDate;
  String userId;

  ListPostModelRes(
      {this.imageUrl,
      this.likedUserIds,
      this.joinedUserIds,
      this.description,
      this.title,
      this.joinLimit,
      required this.postId,
      this.success = false,
      required this.isHelp,
      required this.isEvent,
      required this.isNotice,
      required this.isPost,
      required this.createdDate,
      required this.userId});
}

class PostOnlyModel {
  String? imageUrl;
  String? description;
  String createdDate;
  int numberOfLikes;
  PostOnlyModel(
      {required this.createdDate,
      required this.numberOfLikes,
      this.imageUrl,
      this.description});
}
