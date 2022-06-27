// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


AppBar buildAppBar(BuildContext context) {

  
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: BackButton(color: Colors.black,),
    elevation: 0,
  );
}
