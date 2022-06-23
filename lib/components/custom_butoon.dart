
import 'package:flutter/material.dart';
import '../utils/color_theme.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? color;
  final bool isLoading;
  const CustomButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.color,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        primary: color,
      ),
      onPressed: onTap,
      child: !isLoading? child :
      const Padding(
                padding:  EdgeInsets.all(15),
                child:  AspectRatio(
                    aspectRatio: 1 / 1,
                    child:  CircularProgressIndicator(
                      color: activeCyanColor,
                    ),),
              ),
      
      
    );
  }
}