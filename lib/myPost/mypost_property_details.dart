import 'package:maison_room/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/color_theme.dart';

class MyPostPropertyDetails extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const MyPostPropertyDetails({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
   
    double titleHeight = 25;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: screenSize.width,
      color: creamColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          
              ],
            ),
          ),
          Column(
           
            children: children,
          ),
        ],
      ),
    );
  }
}
