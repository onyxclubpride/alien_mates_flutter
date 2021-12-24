class ListPostModelRes {
  bool success;
  String postId;
  String? imageUrl;
  int? numberOfLikes;
  int? numberOfJoins;
  String? title;
  String? description;
  bool isPost;
  bool isEvent;
  bool isNotice;

  ListPostModelRes(
      {required this.postId,
      this.imageUrl,
      this.numberOfLikes,
      this.numberOfJoins,
      this.description,
      this.title,
      this.success = false,
      required this.isEvent,
      required this.isNotice,
      required this.isPost});
}
