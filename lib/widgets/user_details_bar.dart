import 'package:maison_room/providers/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:maison_room/model/user_details_model.dart';
import 'package:maison_room/utils/utils.dart';
import 'package:provider/provider.dart';

import '../utils/color_theme.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;

  const UserDetailsBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Positioned(
      top: -offset / 4,
      child: Container(
        height: 28,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: mybackgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  " ${userDetails.name} - ${userDetails.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: darkCreamColor.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
