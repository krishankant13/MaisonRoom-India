
// import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:uuid/uuid.dart';

class ProfileStorageMethods{
  final FirebaseStorage _storage = FirebaseStorage.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> uploadImageToStorage(String childName, image, bool isPost) async {
    // creating location to our firebase storage
    
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if(isPost) {
      // String id = const Uuid().v1();
      String id = FirebaseAuth.instance.currentUser!.uid;
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
   UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}