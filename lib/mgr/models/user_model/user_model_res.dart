class UserModelRes {
  String userId;
  String name;
  String phoneNumber;
  String password;
  String uniName;
  String createdDate;
  List? postIds;

  UserModelRes({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.uniName,
    required this.createdDate,
    this.postIds,
  });
}
