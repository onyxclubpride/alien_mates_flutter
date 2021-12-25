class ListPostModelRes {
  bool success;
  String? imageUrl;
  int? numberOfLikes;
  List? joinedUserIds;
  String? title;
  String? description;
  bool isPost;
  bool isEvent;
  bool isNotice;
  bool isHelp;
  String postId;
  String createdDate;

  ListPostModelRes(
      {this.imageUrl,
      this.numberOfLikes,
      this.joinedUserIds,
      this.description,
      this.title,
      required this.postId,
      this.success = false,
      required this.isHelp,
      required this.isEvent,
      required this.isNotice,
      required this.isPost,
      required this.createdDate});
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
