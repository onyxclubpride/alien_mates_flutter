class PostModelRes {
  String? imageUrl;
  int? numberOfLikes;
  int? numberOfJoins;
  String? title;
  String? description;
  String? eventLocation;
  bool isPost;
  bool isEvent;
  bool isHelp;
  bool isNotice;
  String userId;
  int? joinLimit;
  String postId;
  String createdDate;

  PostModelRes(
      {this.imageUrl,
      this.numberOfLikes,
      required this.postId,
      this.numberOfJoins,
      this.description,
      this.title,
      this.joinLimit,
      this.eventLocation,
      required this.userId,
      required this.isEvent,
      required this.isNotice,
      required this.isHelp,
      required this.isPost,
      required this.createdDate});
}
