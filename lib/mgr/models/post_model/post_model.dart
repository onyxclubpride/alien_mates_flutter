class PostModelRes {
  String postId;
  String? imageUrl;
  int? numberOfLikes;
  int? numberOfJoins;
  String? title;
  String? description;
  bool isPost;
  bool isEvent;
  bool isNotice;

  PostModelRes(
      {required this.postId,
      this.imageUrl,
      this.numberOfLikes,
      this.numberOfJoins,
      this.description,
      this.title,
      required this.isEvent,
      required this.isNotice,
      required this.isPost});
}
