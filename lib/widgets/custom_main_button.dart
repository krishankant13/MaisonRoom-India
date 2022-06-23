// ignore_for_file: prefer_const_constructors

import 'package:maison_room/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomMainButtom extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomMainButtom({
    Key? key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
        style: 
        ElevatedButton.styleFrom(
            primary: color,
            elevation: 4,
            fixedSize: Size(screenSize.width * 0.6, 45)),
        onPressed: onPressed,
        child: !isLoading
            ? child
            : Padding(
                padding: const EdgeInsets.all(15),
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    )),
              ));
  }
}
