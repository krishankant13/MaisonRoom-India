// ignore_for_file: sort_child_properties_last
import 'package:maison_room/providers/user_details_provider.dart';
import 'package:maison_room/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/color_theme.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);

    if (!mounted) return;
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getDta();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[400]!, width: 1),
            ),
          ),
          child: TabBar(
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            onTap: changePage,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: Icon(
                  Icons.home,
                  color: currentPage == 0
                      ? Colors.blue
                      : darkCreamColor.withOpacity(0.8),
                ),
              ),
              Tab(
                child: Icon(
                  Icons.person,
                  color: currentPage == 1
                      ? Colors.blue.shade600
                      : darkCreamColor.withOpacity(0.8),
                ),
              ),
              Tab(
                child: Icon(
                  Icons.favorite,
                  color: currentPage == 2
                      ? Colors.blue.shade600
                      : darkCreamColor.withOpacity(0.8),
                ),
              ),
              Tab(
                child: Icon(
                  Icons.menu,
                  color: currentPage == 3
                      ? Colors.blue.shade600
                      : darkCreamColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
