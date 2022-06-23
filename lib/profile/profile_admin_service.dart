
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maison_room/profile/profile_storage_method.dart';
import 'package:maison_room/profile/profile_user_model.dart' as model;
import 'package:maison_room/profile/profile_user_model.dart';
import '../model/user_details_model.dart';

class ProfileAdminServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future getNameAndAddressAndEmail() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );
    return userModel;
  }



  //  Future uploadUserProfileToDatabase(
  //     {required model.UserprofileModel userProfile}) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .set(userProfile.getJson());
  // }

    Future<String> saveProfileDetails ({
    required String city,
    required String address,
    required String name,
    required String phoneNumber,
     Uint8List? image,
  }) async {
    String res = "Some error Occurred";
    try {
      if (city.isNotEmpty ||
          address.isNotEmpty ||
          name.isNotEmpty ||
          phoneNumber.isNotEmpty 
          // ignore: unnecessary_null_comparison
          ) {
        // registering user in auth with email and password
      
        String photoUrl = image==null? "":
         await ProfileStorageMethods()
            .uploadImageToStorage('profilePics', image, false);

        UserprofileModel userprofileModel =model.UserprofileModel(
          name: name,
          uid: FirebaseAuth.instance.currentUser!.uid,
          photoUrl: photoUrl,
          address: address,
          phoneNumber: phoneNumber,
          city:city,
         
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(userprofileModel.getJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      // return err.toString();
  
    }
    return res;
  }
}