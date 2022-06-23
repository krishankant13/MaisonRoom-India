// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProfile {
  final String profileImage;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String requiredCategory;

  const UserProfile({
    required this.profileImage,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.requiredCategory,
  });
}
