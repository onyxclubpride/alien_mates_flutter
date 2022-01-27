import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alien_mates/utils/common/constants.dart';

class FirebaseKit {
  //Posts collection
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection(Constants.firebasePostsCollection);

  //Users collection
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(Constants.firebaseUsersCollection);

  final CollectionReference extraInfoCollection = FirebaseFirestore.instance
      .collection(Constants.firebaseExtraInfoCollection);
}
