class ListPostModelRes {
  bool success;
  String? imageUrl;
  int? numberOfLikes;
  int? numberOfJoins;
  String? title;
  String? description;
  bool isPost;
  bool isEvent;
  bool isNotice;
  String postId;
  String createdDate;

  ListPostModelRes(
      {this.imageUrl,
      this.numberOfLikes,
      this.numberOfJoins,
      this.description,
      this.title,
      required this.postId,
      this.success = false,
      required this.isEvent,
      required this.isNotice,
      required this.isPost,
      required this.createdDate});
}
