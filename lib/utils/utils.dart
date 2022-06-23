// ignore_for_file: unused_import

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:maison_room/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
          backgroundColor:Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          content: Text(
            content,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500),
            maxLines: 4,
          ),
        ),
    );
    
  }

  String getUid() {
    return (100000 + Random().nextInt(100000)).toString();
  }

  Future<List<File>> pickImages() async {
    List<File> images = [];
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      (e.toString());
    }
    return images;
  }
}
