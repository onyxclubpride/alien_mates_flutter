class PostModelReq {
  String? title;
  String? description;
  int? joinLimit;
  int? numberOfJoins;
  String? imagePath;

  PostModelReq({
    this.description,
    this.title,
    this.joinLimit,
    this.numberOfJoins,
    this.imagePath,
  });
}
