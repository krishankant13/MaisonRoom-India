import 'package:maison_room/utils/color_theme.dart';
import 'package:maison_room/utils/constants.dart';
import 'package:flutter/material.dart';
import '../screens/result_screen.dart';

class CategoriesHorizontalListViewBar extends StatelessWidget {
  const CategoriesHorizontalListViewBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight * 0.44,
      width: double.infinity,
      color: Colors.white.withOpacity(0.75),
      child: ListView.builder(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    query: categoriesList[index],
                  ),
                ),
              );
            }),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 35,
                      child: Card(elevation: 0,
                        color: textFieldColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side:  BorderSide(width: 1, color: Colors.grey.withOpacity(0.1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              categoriesList[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
