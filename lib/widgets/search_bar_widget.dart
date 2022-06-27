import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/profile/profile_page_one.dart';
import 'package:maison_room/screens/result_screen.dart';
import 'package:maison_room/screens/search_screen.dart';
import 'package:maison_room/utils/constants.dart';
import 'package:flutter/material.dart';
import '../utils/color_theme.dart';
import '../utils/input_decoration.dart';

// ignore: must_be_immutable
class SearchBarWidget extends StatefulWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchBarWidget(
      {Key? key, required this.isReadOnly, required this.hasBackButton})
      : preferredSize = Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: Colors.grey, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight * 0.88,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePageOne()));
                      },
                      icon: Icon(
                        Icons.menu,
                        size: screenSize.height / 35,
                        color: darkBluishColor,
                      ),
                    ),
                  ),
                  Text(
                    "Maison Room",
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: darkCreamColor.withOpacity(0.9)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        size: screenSize.height / 35,
                        color: darkBluishColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      query = query;
                    });
                  },
                  onSubmitted: (String query) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          query: query.inCaps,
                        ),
                      ),
                    );
                  },
                  readOnly: widget.isReadOnly,
                  onTap: () {
                    if (widget.isReadOnly) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: widget.hasBackButton
                        ? IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.blue.shade400,
                              size: 20,
                            ))
                        :  Icon(Icons.search,size: 18,color: Colors.grey.shade600,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                          color: Colors.blue.shade400, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: 'Enter Your City Name',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
