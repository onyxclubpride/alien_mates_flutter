import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_house_flutter/utils/common/constants.dart';

class FirebaseKit {
  //Posts collection
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection(Constants.firebasePostsCollection);
}
