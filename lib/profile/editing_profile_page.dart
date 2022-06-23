// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maison_room/profile/default_user_profile_widget.dart';
import 'package:maison_room/profile/my_profile_page.dart';
import 'package:maison_room/profile/profile_admin_service.dart';
import 'package:maison_room/profile/profile_utils.dart';
import 'package:maison_room/profile/user.dart';
import 'package:maison_room/profile/user_preferences.dart';
import '../utils/utils.dart';
import 'build_appbar_widget.dart';
import 'build_button.dart';

class EditingProfilePage extends StatefulWidget {
  const EditingProfilePage({Key? key}) : super(key: key);

  @override
  State<EditingProfilePage> createState() => _EditingProfilePageState();
}

class _EditingProfilePageState extends State<EditingProfilePage> {
  UserProfile userProfile = UserPreferences.myUser;
  Uint8List? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    nameController.addListener(_printLatestValue);
    cityController.addListener(_printLatestValue);
    addressController.addListener(_printLatestValue);
    contactController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    // print('Second text field: ${myController.text}');
    nameController.text;
    cityController.text;
    addressController.text;
    contactController.text;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    cityController.dispose();
    contactController.dispose();
    addressController.dispose();
  }

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 36,
        ),
        children: [  
          image != null
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 74,
                            backgroundImage: MemoryImage(image!),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                                onTap: () {},
                                child: buildEditIcon(Colors.blue)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DefaultUserProfileWidget(
                        profileImage: Icon(Icons.person),
                        // isEdit: true,
                        onClicked: () async {
                          selectImage();
                        }),
                    SizedBox(height: 20),
                    ButtonWidget(
                        text: "Select Image",
                        onClicked: () async {
                          selectImage();
                        })
                  ],
                ),
          SizedBox(height: 18),
          Text(
            "Name",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 6),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enetr Your Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  width: 0.1,
                ),
              ),
            ),
            controller: nameController,
          ),
          SizedBox(height: 18),
          Text(
            "contact",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 6),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enetr Your Mobile No.",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  width: 0.1,
                ),
              ),
            ),
            controller: contactController,
          ),
          SizedBox(height: 18),
          Text(
            "City",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 6),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enetr Your City Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  width: 0.1,
                ),
              ),
            ),
            controller: cityController,
          ),
          SizedBox(height: 18),
          Text(
            "Address",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 6),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enetr Your Address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  width: 0.1,
                ),
              ),
            ),
            controller: addressController,
          ),
          SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
                text: "Save",
                onClicked: () async {
                  if (!mounted) return;
                  setState(() {
                    isLoading = true;
                  });
                  String output = await ProfileAdminServices()
                      .saveProfileDetails(
                          name: nameController.text,
                          address: addressController.text,
                          city: cityController.text,
                          phoneNumber: contactController.text,
                          image: image);

                  setState(() {
                    isLoading = false;
                  });

                  if (output == "success") {
                    Utils().showSnackBar(
                        context: context, content: 'Profile Details are Saved');

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfilePage()));
                  } else {
                    //error
                    Utils().showSnackBar(context: context, content: output);
                  }
                }),
          )
        ],
      ),
    );
  }

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
