// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:maison_room/model/order_request_model.dart';
import 'package:maison_room/profile/default_user_profile_widget.dart';
import 'package:maison_room/profile/profile_utils.dart';
import 'package:maison_room/profile/profile_widget.dart';
import 'package:maison_room/profile/user_preferences.dart';

import 'build_appbar_widget.dart';
import 'editing_profile_page.dart';

class RenterProfilePage extends StatefulWidget {
  final OrderRequestModel orderRequestModel;
  const RenterProfilePage({
    Key? key,
    required this.orderRequestModel,
  }) : super(key: key);

  @override
  State<RenterProfilePage> createState() => _RenterProfilePageState();
}

class _RenterProfilePageState extends State<RenterProfilePage> {
  final user = UserPreferences.myUser;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            child: widget.orderRequestModel.photoUrl == ""
                ? DefaultUserProfileWidget(
                    profileImage: Icon(
                      Icons.person,
                    ),
                    onClicked: () {

                    },
                  )
                : ProfileWidget(
                    profileImage: widget.orderRequestModel.photoUrl,
                    onClicked: () async {},
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
          buildName(widget.orderRequestModel),

          SizedBox(height: 20),
        
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
                        text2: widget.orderRequestModel.name.capitalizeFirstofEach,
                      ),
                    )),
                SizedBox(height: 5),
                Card(
                    color: Colors.white.withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileDetailsBuilder(
                        text1: "Contact",
                        text2: widget.orderRequestModel.phoneNumber,
                      ),
                    )),
                SizedBox(height: 5),
                Card(
                    color: Colors.white.withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileDetailsBuilder(
                        text1: "City",
                        text2: widget.orderRequestModel.city.capitalizeFirstofEach,
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
                        text2: widget.orderRequestModel.address.capitalizeFirstofEach,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName(OrderRequestModel orderRequestModel) => Column(
        children: [
          Text(
            orderRequestModel.name.capitalizeFirstofEach,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          Text(
            orderRequestModel.email,
            style:
                TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey),
            maxLines: 1,
          )
        ],
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
