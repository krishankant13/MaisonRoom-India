import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  
  final int maxLines;
  bool isFocus = false;
  String labelText;
  TextInputType textInputType;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    required this.labelText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    isFocus = isFocus;
    return TextFormField( 
     
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          focusColor: Colors.blue,
          hintStyle: const TextStyle(fontSize: 14,color: Colors.grey),
          labelText: labelText,
          labelStyle: GoogleFonts.lato(fontSize: 17 ,fontWeight: FontWeight.w600,color: Colors.grey.shade800),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: const TextStyle(color: Colors.blue, fontSize: 17),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black26,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $labelText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
