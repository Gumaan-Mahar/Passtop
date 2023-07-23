import 'dart:convert';

class UserModel {
  String? id;
  String? username;
  String? email;
  String? imageUrl;
  String? appLockPassword;
  DateTime? createdAt;

  UserModel({this.id, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    imageUrl = json['image_url'];
    appLockPassword = json['app_lock_password'];
    createdAt = DateTime.parse(json['createdat']);
  }

  String toJsonString() {
    final json = {
      'id': id,
      'username': username,
      'email': email,
      'image_url': imageUrl,
      'app_lock_password': appLockPassword,
      'createdat': createdAt?.toIso8601String(),
    };
    return jsonEncode(json);
  }
}
