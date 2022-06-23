// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/profile/default_user_profile_widget.dart';
import 'package:maison_room/profile/profile_utils.dart';
import 'package:maison_room/profile/profile_widget.dart';
import 'package:maison_room/profile/user_preferences.dart';
import 'package:maison_room/utils/input_decoration.dart';
import 'package:provider/provider.dart';
import '../model/user_details_model.dart';
import '../providers/user_details_provider.dart';
import 'build_appbar_widget.dart';
import 'build_button.dart';
import 'editing_profile_page.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final user = UserPreferences.myUser;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            child: userDetails.photoUrl == ""
                ? DefaultUserProfileWidget(
                    profileImage: Icon(
                      Icons.person,
                    ),
                    onClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditingProfilePage(),
                        ),
                      );
                    },
                  )
                : Stack(
                    children: [
                      ProfileWidget(
                        profileImage: userDetails.photoUrl,
                        onClicked: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditingProfilePage(),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: -2,
                        right: screenSize.width / 2.8,
                        child: GestureDetector(
                            onTap: () {}, child: buildEditIcon(color)),
                      ),
                    ],
                  ),
          ),

          // ProfileWidget(
          //   profileImage: userDetails.photoUrl,
          //   onClicked: () async {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => EditingProfilePage(),
          //   ),
          // );
          //   },
          // ),
          SizedBox(
            height: 24,
          ),
          buildName(userDetails),

          SizedBox(height: 20),
          Center(child: buildUpgradeButton()),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Card(
                    elevation: 1,
                    color: Colors.white.withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileDetailsBuilder(
                        text1: "Name",
                        text2: userDetails.name.capitalizeFirstofEach,
                      ),
                    )),
                SizedBox(height: 5),
                Card(
                    color: Colors.white.withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileDetailsBuilder(
                        text1: "Contact",
                        text2: userDetails.phoneNumber,
                      ),
                    )),
                SizedBox(height: 5),
                Card(
                    color:Colors.white.withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileDetailsBuilder(
                        text1: "City",
                        text2: userDetails.city.capitalizeFirstofEach,
                      ),
                    )),
                SizedBox(height: 5),
                SizedBox(height: 5),
                Card(
                    color: Colors.white.withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileDetailsBuilder(
                        text1: "Address",
                        text2: userDetails.address.capitalizeFirstofEach,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName(UserDetailsModel userDetails) => Column(
        children: [
          Text(
            userDetails.name.capitalizeFirstofEach,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          Text(
            userDetails.email,
            style:
                TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey),
            maxLines: 1,
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
  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child:
            Container(padding: EdgeInsets.all(all), color: color, child: child),
      );
}
