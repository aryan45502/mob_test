class UserModel {
  final String id;
  final String name;
  final String email;
  final String profilePhoto;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhoto,
  });

  // ✅ Fix: Ensure `profilePhoto` handles `null` correctly
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",  // ✅ Handle missing `id`
      name: json['name'] ?? "Unknown User",  // ✅ Default to "Unknown User" if `name` is null
      email: json['email'] ?? "no-email@example.com",  // ✅ Default email
      profilePhoto: json['profilePhoto'] ?? "https://example.com/default-profile.png",  // ✅ Default profile photo
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePhoto': profilePhoto,
    };
  }
}
