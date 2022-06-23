
class UserprofileModel {
  final String uid;
  final String photoUrl;
  String city;
  String name;
  String phoneNumber;
  String address;


   UserprofileModel(
      {required this.name,
      required this.phoneNumber,
      required this.uid,
      required this.photoUrl,
      required this.city,
      required this.address,
      });

    Map<String, dynamic> getJson() => {
        'name': name,
        'address': address,
        'city': city,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'uid':uid,
      };
        factory UserprofileModel.getModelFromJson(Map<String, dynamic> json) {
    return UserprofileModel(
      name: json['name'],
      address: json['address'],
      city: json['city'],
      phoneNumber: json['phoneNumber'],
      photoUrl: json['photoUrl'], 
      uid: json['uid'],
    );
  }

}
