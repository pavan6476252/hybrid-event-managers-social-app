import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hybrid/models/user_model.dart';
import 'package:hybrid/utils/firebase_constants.dart';

class FireStoreServices {
  late FirebaseFirestore firebaseFirestore;
  FireStoreServices() {
    firebaseFirestore = FirebaseFirestore.instance;
  }

  //profile Info
  Future<void> editProfileInfo(
      {required String uid, required UserModel userModel}) async {
    return firebaseFirestore
        .collection(FirebaseConstants.profiles)
        .doc(uid)
        .set(userModel.toMap());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileInfo(
      {required String uid}) async {
    return firebaseFirestore
        .collection(FirebaseConstants.profiles)
        .doc(uid)
        .get();
  }
}
