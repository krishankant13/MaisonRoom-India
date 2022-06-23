// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maison_room/model/user_details_model.dart';
import 'package:maison_room/profile/build_appbar_widget.dart';
import 'package:maison_room/profile/default_user_profile_widget.dart';
import 'package:maison_room/profile/editing_profile_page.dart';
import 'package:maison_room/profile/my_profile_page.dart';
import 'package:maison_room/profile/profile_widget.dart';
import 'package:maison_room/profile/user_preferences.dart';
import 'package:maison_room/providers/user_details_provider.dart';
import 'package:maison_room/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../myPost/my_post_screen.dart';
import '../screens/sign_in_screen.dart';
import '../utils/color_theme.dart';
import 'build_button.dart';

extension CapExtension on String {
  
  String get inCaps =>this==''? this: '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach => split(" ").map((str) => str.inCaps).join(" ");

}

class ProfilePageOne extends StatefulWidget {
  const ProfilePageOne({Key? key}) : super(key: key);

  @override
  State<ProfilePageOne> createState() => _ProfilePageOneState();
}

class _ProfilePageOneState extends State<ProfilePageOne> {
  final user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [

           
           Container(
               
               child: userDetails.photoUrl == ""
                   ?DefaultUserProfileWidget(profileImage: Icon(Icons.person), onClicked: (){})
                   :   ProfileWidget(
            profileImage: userDetails.photoUrl,
            onClicked: () async {},
          ),
               ),



          SizedBox(
            height: 24,
          ),
          buildName(userDetails),
          SizedBox(height: 20),
          // Center(child: buildUpgradeButton()),
          // SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfilePage(),
                    ),
                  );
                },
                child: Card(
                    elevation: 1, color: Colors.white.withOpacity(0.85),
                    child: ListTile(
                       horizontalTitleGap: 5,
                      leading: Icon(CupertinoIcons.person, color: darkBluishColor,),
                      title: Text("My Profile"),
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPostScreen(),
                  ),
                );
              },
              child: Card(
                  elevation: 1, color: Colors.white.withOpacity(0.85),
                  child: ListTile(
                     horizontalTitleGap: 5,
                    leading: Icon(Icons.post_add_rounded, color: darkBluishColor,),
                    title: Text("My Posts"),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              child: Card(
                  elevation: 1, color: Colors.white.withOpacity(0.85),
                  child: ListTile(
                     horizontalTitleGap: 5,
                    leading: Icon(Icons.favorite_border_outlined, color: darkBluishColor,),
                    title: Text("Shortlist Collection"),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
                elevation: 1, color: Colors.white.withOpacity(0.85),
                child: ListTile(
                  horizontalTitleGap: 5,
                  leading: Icon(CupertinoIcons.phone, color: darkBluishColor,),
                  title: Text("Contact us"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
                elevation: 1, color: Colors.white.withOpacity(0.85),
                child: ListTile(
                   horizontalTitleGap: 5,
                  leading: Icon(Icons.info, color: darkBluishColor,),
                  title: Text("About us"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: GestureDetector(
              onTap:() {
                 FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false)
                    });
              },
              child: Card(
                  elevation: 1, color: Colors.white.withOpacity(0.85),
                  child: ListTile(
                     horizontalTitleGap: 5,
                    leading: Icon(Icons.logout_outlined, color: darkBluishColor,),
                    title: Text("Logout"),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName(UserDetailsModel userDetailsModel) => Column(
        children: [
          Text(
            userDetailsModel.name.capitalizeFirstofEach,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            userDetailsModel.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: "Edit Profile",
        onClicked: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditingProfilePage(),
            ),
          );
        },
      );
}
