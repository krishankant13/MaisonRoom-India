// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImageModel {

  final List<String> images;


  ImageModel({
    // this.id,
    // this.id,

    required this.images,
  });

  Map<String, dynamic> getJson() {
    return {
   
      'images': images,

    };
  }

  factory ImageModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ImageModel(

      images: List<String>.from(json['images']),
   
  
    );
  }



  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(

      images: List<String>.from(map['images'] as List<String>),

    );
  }


  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
