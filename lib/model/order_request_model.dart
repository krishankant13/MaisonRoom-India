// ignore_for_file: public_member_api_docs, sort_constructors_first

class OrderRequestModel {
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
   String city;
   String photoUrl;

  OrderRequestModel({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.photoUrl
  });
  Map<String, dynamic> getJson() => {
        'name': name,
        'address': address,
        'email': email,
        'phoneNumber': phoneNumber,
        'city': city,
        'photoUrl':photoUrl
      };
  factory OrderRequestModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return OrderRequestModel(
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      city: json['city'],
      photoUrl: json['photoUrl'],
    );
  }
}

