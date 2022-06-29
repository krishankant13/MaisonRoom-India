// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/screens/renter_type_result_screen.dart';
import 'package:maison_room/utils/utils.dart';

import '../utils/color_theme.dart';

// ignore: must_be_immutable
class ProductShowCaseListView extends StatelessWidget {
  final String title;
   String query;
  final List<Widget> children;
   ProductShowCaseListView({
    Key? key,
    required this.title,
     required this.query,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height / 3;
    double titleHeight = 25;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(  elevation: 0, color: Colors.white.withOpacity(0.75),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenSize.height*0.015,),
            child: Row( crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                        color: darkCreamColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                  ),
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 15),
                // ),
        
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RenterTypeResultScreen(
                                query: query)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "See more",
                      style: GoogleFonts.roboto(
                        color: Colors.blue.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                children: children,
                //  prototypeItem: const PrototypeProduct(),   
              ),
            ),
          ),
        ),
      ],
    );
  }
}
