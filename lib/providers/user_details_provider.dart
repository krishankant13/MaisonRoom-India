import 'package:maison_room/model/user_details_model.dart';
import 'package:flutter/material.dart';
import '../recources/admin_services.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(
            name: 'Loading',
            address: 'Loading',
            email: 'Loading',
            phoneNumber: 'Loading',
            city: 'Loading',
            photoUrl: 'Loading'
            );

  Future getDta() async {
    userDetails = await AdminServices().getNameAndAddressAndEmail();
    notifyListeners();
  }
}




