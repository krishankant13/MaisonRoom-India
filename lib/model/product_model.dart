// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {

  final String url;
  final String userAddress;
  final String city;
  final String otherDetails;
  final double rent;
  final double dep;
  final double contact;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int noOfRating;

  ProductModel({
    
    required this.url,
    required this.userAddress,
    required this.city,
    required this.otherDetails,
    required this.rent,
    required this.dep,
    required this.contact,
    required this.discount,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    required this.rating,
    required this.noOfRating,
  });

  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'userAddress': userAddress,
      'city': city,
      
      'otherDetails': otherDetails,
      'rent': rent,
      'deposit': dep,
      'contactNumber': contact,
      'discount': discount,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'noOfRating': noOfRating,
    };
  }

  // factory ProductModel.getModelFromJson({required Map<String, dynamic> json}) {
  //   return ProductModel(
  //       url: (json["image"]),
  //       userAddress: json["userAddress"],
  //       city: json["city"],
  //       otherDetails: json["otherDetails"],
  //       rent: json["rent"],
  //       dep: json["deposit"],
  //       contact: json["contactNumber"],
  //       discount: json["discount"],
  //       uid: json["uid"],
  //       sellerName: json["sellerName"],
  //       sellerUid: json["sellerUid"],
  //       rating: json["rating"],
  //       noOfRating: json["noOfRating"],
  //      );
  // }
}
