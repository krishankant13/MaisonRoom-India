// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdsImage {
  final List<String> images;


  AdsImage({
    // this.id,
    // this.id,
    required this.images,

  });

  Map<String, dynamic> getJson() {
    return {

      'images': images,
    };
  }

  factory AdsImage.getModelFromJson(Map<String, dynamic> json) {
    return AdsImage(
      images: List<String>.from(json['images']),

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'images': images,

    };
  }

  factory AdsImage.fromMap(Map<String, dynamic> map) {
    return AdsImage(
  
      images: List<String>.from(map['images'] as List<String>),

    );
  }

  String toJson() => json.encode(toMap());

  factory AdsImage.fromJson(String source) =>
      AdsImage.fromMap(json.decode(source) as Map<String, dynamic>);
}
