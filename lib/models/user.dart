

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

  // Map<String, dynamic> toJsonWithEncryption(Uint8List encryptionKey) {
  //   final json = <String, dynamic>{};

  //   json['id'] = id;
  //   json['username'] = username;
  //   json['email'] = email;
  //   json['image_url'] = imageUrl;
  //   json['created_at'] = createdAt.toIso8601String();

  //   // Encrypt the master password and salt before serialization
  //   json['master_password'] = masterPassword.isNotEmpty
  //       ? encryptionServices.encryptData(masterPassword, encryptionKey)
  //       : masterPassword;
  //   json['salt'] = salt;

  //   return json;
  // }

  // factory UserModel.fromJsonWithDecryption(
  //     {required Map<String, dynamic> json, required Uint8List encryptionKey}) {
  //   final decryptedData = {
  //     'id': json['id'],
  //     'username': json['username'],
  //     'email': json['email'],
  //     'imageUrl': json['image_url'],
  //     'createdAt': DateTime.parse(json['created_at']),
  //     'masterPassword': (json['master_password'] != null)
  //         ? encryptionServices.decryptData(
  //             json['master_password'],
  //             encryptionKey,
  //           )
  //         : '',
  //     'salt': (json['salt'] != null) ? json['salt'] : '',
  //   };

  //   return UserModel(
  //     id: decryptedData['id'],
  //     username: decryptedData['username'],
  //     email: decryptedData['email'],
  //     imageUrl: decryptedData['imageUrl'],
  //     masterPassword: decryptedData['masterPassword'],
  //     salt: decryptedData['salt'],
  //     createdAt: decryptedData['createdAt'],
  //   );
  // }
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
