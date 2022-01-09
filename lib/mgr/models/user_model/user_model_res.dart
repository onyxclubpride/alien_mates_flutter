class UserModelRes {
  String userId;
  String name;
  String phoneNumber;
  String? password;
  String uniName;
  String createdDate;
  List? postIds;
  bool isAdmin;

  UserModelRes({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    this.password,
    required this.uniName,
    required this.createdDate,
    required this.isAdmin,
    this.postIds,
  });
}
