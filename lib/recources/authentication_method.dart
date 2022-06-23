
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maison_room/recources/admin_services.dart';

import '../components/utils2.dart';
import '../model/user_details_model.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AdminServices adminServices = AdminServices();
  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    phoneNumber.trim(); //this remove the void space in textfield
    String output = "something went wrong";
    if (name != "" &&
        address != "" &&
        email != "" &&
        password != "" &&
        phoneNumber != "") {
      try {
        await
         firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
             // ignore: use_build_context_synchronously
             await sendEmailVerification(context);

        UserDetailsModel user = UserDetailsModel(
            name: name,
            address: address,
            email: email,
            phoneNumber: phoneNumber,
            photoUrl: '', 
            city: '');

        await adminServices.uploadNameAndAddressAndEmailToDatabase(
            user: user);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the details";
    }
    return output;
  }


    Future<void> sendEmailVerification(BuildContext context) async {
    try {
      firebaseAuth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  Future<String> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    email.trim();
    password.trim(); //this remove the void space in textfield
    String output = "something went wrong";
    if (email != "" && password != "") {
      output = "success";
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
       
              if (!firebaseAuth.currentUser!.emailVerified) {
        // ignore: use_build_context_synchronously
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
       output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the details";
    }
    return output;
  }
}
