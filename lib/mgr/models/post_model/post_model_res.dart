class PostModelRes {
  String? imageUrl;
  List? likedUserIds;
  List? joinedUserIds;
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
      this.likedUserIds,
      required this.postId,
      this.joinedUserIds,
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
