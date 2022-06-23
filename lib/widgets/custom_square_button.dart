// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomSquareButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double dimension;

  const CustomSquareButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.color,
    required this.dimension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: dimension,
        width: dimension,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(color:Colors.grey,width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: child,
      ),
    );
  }
}
