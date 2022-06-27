import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/screens/account_screen.dart';
import 'package:maison_room/utils/constants.dart';
import 'package:maison_room/utils/utils.dart';
import 'package:maison_room/widgets/category_widget.dart';
import 'package:flutter/material.dart';

import '../profile/profile_page_one.dart';
import '../utils/color_theme.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: activeCyanColor.withOpacity(0.3),
         appBar: AppBar(
          iconTheme: IconThemeData(color: darkCreamColor),
          backgroundColor: creamColor,
          elevation: 0.2,
          title: Text(
            "Maison Room",
            style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: darkCreamColor.withOpacity(0.9)),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePageOne(),
                ),
              );
            },
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const IntroductionWidgetAccountScreen(),
            Container(
              height: kAppBarHeight / 2,
              width: screenSize.width,
              color: activeCyanColor.withOpacity(0.1),
              child: Center(
                child: Title(
                  color: darkCreamColor,
                  child: const Text(
                    'Select Your Category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height - 1.6 * kAppBarHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20),
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) => CategoryWidget(index: index),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
