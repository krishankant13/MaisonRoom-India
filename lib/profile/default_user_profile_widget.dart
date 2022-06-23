// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_details_model.dart';
import '../providers/user_details_provider.dart';


class DefaultUserProfileWidget extends StatelessWidget {
  final Icon profileImage;
  // final bool isEdit;
  final VoidCallback onClicked;

  const DefaultUserProfileWidget(
      {super.key,
      //  this.isEdit = false,
      required this.profileImage,
      required this.onClicked});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
     UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          // Positioned(
          //   bottom: 0,
          //   right: 4,
          //   child: GestureDetector(onTap: () {},
          //   //  child: buildEditIcon(color)
          //    ),
          // ),
        ],
      ),
    );
  }

  Widget buildImage() {
  
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        // child: Ink.image(
        //   image: image,
        //   fit: BoxFit.cover,
        //   width: 150,
        //   height: 150,
        //   child: InkWell(
        //     onTap: onClicked,
        //   ),
        // ),
        child: CircleAvatar(radius: 70,backgroundColor: Colors.white,
          child: InkWell(onTap: onClicked,
            child: Icon(Icons.person, size: 100,color: Colors.grey.shade800,)),
        ),
      ),
    );
  }

  // Widget buildEditIcon(Color color) => buildCircle(
  //       color: Colors.white,
  //       all: 3,
  //       child: buildCircle(
  //         color: color,
  //         all: 8,
  //         child: Icon(
  //           isEdit ? Icons.add_a_photo : Icons.edit,
  //           color: Colors.white,
  //           size: 20,
  //         ),
  //       ),
  //     );
  // Widget buildCircle({
  //   required Widget child,
  //   required double all,
  //   required Color color,
  // }) =>
  //     ClipOval(
  //       child:
  //           Container(padding: EdgeInsets.all(all), color: color, child: child),
  //     );
}
