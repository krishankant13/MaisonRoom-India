// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:maison_room/screens/account_screen.dart';
import 'package:maison_room/screens/home_screen.dart';
import 'package:maison_room/utils/input_decoration.dart';
import '../screens/property_post_screen.dart';
import '../screens/cart_screen.dart';

 double kAppBarHeight = screenSize.height/6;


const List<String> categoriesList = [
  "Indore",
  "Bhopal",
  "Vidisha",
  "Raisen",
];
const List<String> renterTypecategoriesList = [
  "Student",
  "Family",
  "Student And Family",
  "Only For Girls",
  "All",
  "For Family And Gi"
];

const List<Widget> screens = [
  HomeScreen(),
  AccountScreen(),
  CartScreen(),
  PostsScreen()
  
];

const List<String> largeAds = [
  "https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8aG9tZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60",
  "https://images.unsplash.com/photo-1449844908441-8829872d2607?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGhvbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60",
];

List<String> keysOfRating = [
  "very bad",
  "poor",
  "Average",
  "Good",
  "Excellent"
];
