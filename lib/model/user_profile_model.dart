class UserProfile {
  final String imagePath;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String requiredCategory;

  const UserProfile({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.requiredCategory,
  });
}