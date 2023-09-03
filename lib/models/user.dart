
class UserModel {
  String id;
  String username;
  String email;
  String imageUrl;
  String masterPassword;
  String salt;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.masterPassword,
    required this.salt,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      imageUrl: json['image_url'],
      masterPassword: json['master_password'] ?? '',
      salt: json['salt'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['id'] = id;
    json['username'] = username;
    json['email'] = email;
    json['image_url'] = imageUrl;
    json['created_at'] = createdAt.toIso8601String();
    json['master_password'] = masterPassword;
    json['salt'] = salt;

    return json;
  }
}
