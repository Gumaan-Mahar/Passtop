class UserModel {

  String? id;
  String? username;
  String? email;
  String? imageUrl;
  String? appLockPassword;
  DateTime? createdAt;

  UserModel({ this.id, this.username });

  UserModel.fromJson(Map<String, dynamic> json){
      id = json['id'];
      username = json['username'];
      email = json['email'];
      imageUrl = json['image_url'];
      appLockPassword = json['app_lock_password'];
      createdAt = DateTime.parse(json['createdat']);
  }
}