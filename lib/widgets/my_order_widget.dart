// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:maison_room/utils/utils.dart';

// ignore: must_be_immutable
class OrderShowCaseListView extends StatelessWidget {
  final String title;
 
  final List<Widget> children;
   const OrderShowCaseListView({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height / 3;
    double titleHeight = 25;

    return SizedBox(
      height: height * 1.1,
      width: screenSize.width,
    
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                // const Padding(
                //   padding: EdgeInsets.only(left: 15),
                // ),

        
              ],
            ),
            SizedBox(
              height: screenSize.height / 3.5,
              width: screenSize.width,
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  height: height - (titleHeight + 20),
                  width: screenSize.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: children ,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
