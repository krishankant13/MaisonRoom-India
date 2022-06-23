// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import '../utils/color_theme.dart';

class TextFieldWidget extends StatefulWidget {
  //text field variables

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final Iterable<String>? autofillHints;

  const TextFieldWidget({
    Key? key,
  
    required this.controller,
    required this.obscureText,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
    this.autofillHints,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
 
 
  


  late FocusNode focusNode;
  bool isInFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isInFocus = true;
        });
      } else {
        setState(() {
          isInFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          
          autofillHints: widget.autofillHints,
          keyboardType: widget.textInputType,
          focusNode: focusNode,
          obscureText: widget.obscureText,
          controller: widget.controller,
          maxLines: 1,
          decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            floatingLabelStyle:
                 const TextStyle(color: Colors.blue, fontSize: 17),
            labelStyle:  TextStyle(color: Colors.grey.shade800, fontSize: 17),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelText: widget.labelText,
           filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
            hintText: widget.hintText,
            hintStyle:  TextStyle(fontSize: 13, color: lightTextColor1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), 
            borderSide:  BorderSide(color: lightTextColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          ),
        ),
      ],
    );
  }
}
