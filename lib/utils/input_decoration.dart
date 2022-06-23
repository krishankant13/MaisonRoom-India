
import 'package:flutter/material.dart';
import 'package:maison_room/utils/utils.dart';

Size screenSize = Utils().getScreenSize();
InputDecorationTheme theme = InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    constraints: BoxConstraints(maxWidth: screenSize.width * 0.8));
