import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class StorageServices {
  late FirebaseStorage firebaseStorage;
  StorageServices() {
    firebaseStorage = FirebaseStorage.instance;
  }

  Future<String> uploadFileToFirebaseStorage(
      {required File file, required String location}) async {
    String fullName = file.path;
    String extension = fullName.split('.').last;
    String name = fullName.split('.').first;

    Reference reference =
        firebaseStorage.ref().child('$location/$name${Uuid().v4()}.$extension');

    UploadTask uploadTask = reference.putFile(file);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      final progress =
          100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
      print(progress);
    });

    
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }
}
