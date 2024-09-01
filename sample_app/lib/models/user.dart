class User {
  // Constructor
  User({required this.id, required this.name, required this.profileImageUrl});

  // Properties
  final String id;
  final String name;
  final String profileImageUrl;

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profile_image_url'] as String,
    );
  }
}
