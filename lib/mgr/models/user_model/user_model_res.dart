class UserModelRes {
  String userId;
  String name;
  String phoneNumber;
  String kakaoId;
  List<String>? postIds;

  UserModelRes({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.kakaoId,
    this.postIds,
  });
}
