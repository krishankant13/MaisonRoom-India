// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String maintenance;
  final String addressDetails;
  final List<String> images;
  final String renterCategory;
  final String roomCategory;
  final String furnishedLevel;
  final String ownershipCategory;
  final String brokerage;
  final String cityCategory;
  final String deposit;
  final String rent;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int noOfRating;

  Product({
    // this.id,
    // this.id,
    required this.maintenance,
    required this.addressDetails,
    required this.images,
    required this.renterCategory,
    required this.roomCategory,
    required this.furnishedLevel,
    required this.ownershipCategory,
    required this.brokerage,
    required this.cityCategory,
    required this.deposit,
    required this.rent,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    required this.rating,
    required this.noOfRating,
  });

  Map<String, dynamic> getJson() {
    return {
      
      'maintenance': maintenance,
      'addressDetails': addressDetails,
      'deposit': deposit,
      'images': images,
      'renterCategory': renterCategory,
      'roomCategory': roomCategory,
      'furnishedLevel':furnishedLevel,
      'cityCategory': cityCategory,
      'ownershipCategory': ownershipCategory,
      'brokerage': brokerage,
      'rent': rent,
      // 'id': id,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'noOfRating': noOfRating,
    };
  }

  factory Product.getModelFromJson({required Map<String, dynamic> json}) {
    return Product(
      rent: json["rent"],
      uid: json["uid"],
      sellerName: json["sellerName"],
      deposit: json["deposit"],
      sellerUid: json["sellerUid"],
      rating: json["rating"],
      noOfRating: json["noOfRating"],
      images: List<String>.from(json['images']),
      renterCategory: json['renterCategory'],
      roomCategory: json['roomCategory'],
      furnishedLevel:json["furnishedLevel"],
      ownershipCategory:json["ownershipCategory"],
      brokerage:json["brokerage"],
      cityCategory: json['cityCategory'],
      maintenance: json['maintenance'],
      addressDetails: json['addressDetails'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maintenance': maintenance,
      'addressDetails': addressDetails,
      'renterCategory': renterCategory,
      'deposit': deposit,
      'roomCategory': roomCategory,
      "furnishedLevel":furnishedLevel,
      "ownershipCategory":ownershipCategory,
      "brokerage":brokerage,
      'cityCategory': cityCategory,
      'rent': rent,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'noOfRating': noOfRating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      maintenance: map['maintenance'] as String,
      addressDetails: map['addressDetails'] as String,
      images: List<String>.from(map['images'] as List<String>),
      renterCategory: map['renterCategory'] as String,
      roomCategory: map['roomCategory'] as String,
      furnishedLevel:map["furnishedLevel"] as String,
      ownershipCategory:map["ownershipCategory"] as String,
      brokerage:map["brokerage"] as String,
      cityCategory: map['cityCategory'] as String,
      rent: map['rent'] as String,
      uid: map['uid'] as String,
      sellerName: map['sellerName'] as String,
      sellerUid: map['sellerUid'] as String,
      rating: map['rating'] as int,
      noOfRating: map['noOfRating'] as int,
      deposit: map['deposit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
