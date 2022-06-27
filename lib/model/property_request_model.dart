// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PropertyRequestModel {
  final String addressDetails;
  final String contact;
  final String renterCategory;
  final String cityCategory;
  final String rent;
  final String renterName;
  final String sellerUid;


  PropertyRequestModel({
    // this.id,
    // this.id,
    required this.addressDetails,
    required this.contact,
    required this.renterCategory,
    required this.cityCategory,
    required this.rent,
    required this.renterName,
    required this.sellerUid,
  });

  Map<String, dynamic> getJson() {
    return {
      
      'addressDetails': addressDetails,
      'contact': contact,
      'renterCategory': renterCategory,
      'cityCategory': cityCategory,
      'rent': rent,
      'renterName': renterName,
      'sellerUid': sellerUid,

    };
  }

  factory PropertyRequestModel.getModelFromJson({required Map<String, dynamic> json}) {
    return PropertyRequestModel(
      rent: json["rent"],

      renterName: json["renterName"],
      contact: json["contact"],
      sellerUid: json["sellerUid"],
      renterCategory: json['renterCategory'],
      cityCategory: json['cityCategory'],
      addressDetails: json['addressDetails'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressDetails': addressDetails,
      'contact': contact,
      'renterCategory': renterCategory,
      'cityCategory': cityCategory,
      'rent': rent,

      'renterName': renterName,
      'sellerUid': sellerUid,
    };
  }

  factory PropertyRequestModel.fromMap(Map<String, dynamic> map) {
    return PropertyRequestModel(
      addressDetails: map['addressDetails'] as String,
      contact: map['contact'] as String,
      renterCategory: map['renterCategory'] as String,
      cityCategory: map['cityCategory'] as String,
      rent: map['rent'] as String,
      renterName: map['renterName'] as String,
      sellerUid: map['sellerUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyRequestModel.fromJson(String source) =>
      PropertyRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
