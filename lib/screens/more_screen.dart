import 'package:maison_room/screens/account_screen.dart';
import 'package:maison_room/utils/constants.dart';
import 'package:maison_room/utils/utils.dart';
import 'package:maison_room/widgets/category_widget.dart';
import 'package:flutter/material.dart';

import '../utils/color_theme.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: activeCyanColor.withOpacity(0.3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: IntroductionWidgetAccountScreen(),
            ),
            Container(
              height: kAppBarHeight / 2,
              width: screenSize.width,
              color: activeCyanColor.withOpacity(0.1),
              child: Center(
                child: Title(
                  color: darkCreamColor,
                  child: const Text(
                    'Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height - 1.6 * kAppBarHeight,
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
          ],
        ),
      ),
    );
  }
}
