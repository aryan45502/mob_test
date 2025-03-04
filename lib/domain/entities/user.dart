class User {
  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      token: json['token'] ?? '',
    );
  }
}
