class PostModelReq {
  String title;
  String description;
  int? joinLimit;

  PostModelReq({
    required this.description,
    required this.title,
    this.joinLimit,
  });
}
