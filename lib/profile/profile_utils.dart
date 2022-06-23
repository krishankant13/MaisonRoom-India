// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maison_room/utils/input_decoration.dart';
import 'package:string_extensions/string_extensions.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source, imageQuality: 25);
  if (file != null) {
    return await file.readAsBytes();
  }
}

var someCapitalizedString = "someString".capitalize;
extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach => split(" ").map((str) => str.capitalize).join(" ");
}


class ProfileDetailsBuilder extends StatelessWidget {
  final String text1;
  final String text2;

  const ProfileDetailsBuilder({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);
  
  


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text2,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 17,
                  color: Colors.grey.shade900),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}


    // Widget buildAddress(UserDetailsModel userDetailsModel) => Padding(
    //     padding: const EdgeInsets.all(8.0),
        // child: Card(
        //   elevation: 0,
        //   color: Colors.white.withOpacity(0.8),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 24),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           "Address",
        //           style: TextStyle(
        //             overflow: TextOverflow.ellipsis,
        //             fontWeight: FontWeight.w500,
        //             fontSize: 17,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 5,
        //         ),
        //         Divider(
        //           height: 1,
        //           thickness: 0.4,
        //           color: Vx.black.withOpacity(0.8),
        //         ),
        //         SizedBox(
        //           height: 5,
        //         ),
        //         Column(
        //           children: [
        //             Text(
        //               userDetailsModel.address,
        //               style: TextStyle(
        //                   overflow: TextOverflow.ellipsis,
        //                   fontSize: 15,
        //                   color: Colors.grey.shade700),
        //               maxLines: 2,
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
    //   );