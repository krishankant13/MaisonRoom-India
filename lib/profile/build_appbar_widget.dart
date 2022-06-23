// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


AppBar buildAppBar(BuildContext context) {
  const icon = CupertinoIcons.moon_stars;
  
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: BackButton(color: Colors.black,),
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(icon))
    ],
  );
}
