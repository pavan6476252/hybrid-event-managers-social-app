import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hybrid/models/user_model.dart';
import 'package:hybrid/services/fire-storage/firestore_service.dart';
import 'package:hybrid/utils/firebase_constants.dart';

class FireStoreServices {
  late FirebaseFirestore firebaseFirestore;
  late StorageServices storageServices;
  FireStoreServices() {
    firebaseFirestore = FirebaseFirestore.instance;
    storageServices = StorageServices();
  }

  //profile Info

  Future<void> editProfileInfo(
      {required String uid,
      required UserModel userModel,
      File? prfileImage,
      File? bannerImage}) async {
    if (prfileImage != null) {
      String imageUrl = await storageServices.uploadFileToFirebaseStorage(
          file: prfileImage, location: FirebaseConstants.profiles);

      userModel = userModel.copyWith(profileImageUrl: imageUrl);
    }

    if (bannerImage != null) {
      String coverImage = await storageServices.uploadFileToFirebaseStorage(
          file: bannerImage, location: FirebaseConstants.banners);
      userModel = userModel.copyWith(coverImageUrl: coverImage);
    }

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
