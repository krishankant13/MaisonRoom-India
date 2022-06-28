// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  
  final String rent;
  final String cityCategory;
  final String roomCategory;
  final String sellerName;
  final List<String> images;
  Post({
    required this.rent,
    required this.cityCategory,
    required this.roomCategory,
    required this.sellerName,
    required this.images,
  });

  Post.fromJson(Map<String, Object?> json)
    : this(
        rent: json['rent']! as String,
        cityCategory: json['cityCategory']! as String,
        roomCategory: json['roomCategory']! as String,
        sellerName: json['sellerName']! as String,
         images: List<String>.from(json['images'] as List<dynamic>),
      );


  Map<String, Object?> toJson() {
    return {
      'rent': rent,
      'cityCategory': cityCategory,
      'roomCategory': roomCategory,
      'sellerName': sellerName,
      'images': images[0],
    };
  }
}
