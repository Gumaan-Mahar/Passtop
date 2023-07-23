import 'dart:convert';

import '../core/instances.dart';
import '../models/password.dart';
import '../models/user.dart';

class PreferencesServices {
  Future<void> saveUserModel(UserModel userModel) async {
    final prefs = Preferences().instance;
    final jsonString = userModel.toJsonString();
    await prefs?.setString('user_model', jsonString);
  }

  Future<void> updateUserModel(UserModel user) async {
    final exists = Preferences().instance?.containsKey('user_model');
    if (exists!) {
      Preferences().instance?.remove('user_model');
      await saveUserModel(user);
    } else {
      await saveUserModel(user);
    }
  }

  Future<UserModel?> fetchCurrentUser() async {
    final prefs = Preferences().instance;
    final jsonString = prefs?.getString('user_model');
    if (jsonString != null) {
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final currentUser = UserModel.fromJson(jsonData);
      return currentUser;
    } else {
      return null;
    }
  }

  Future<void> savePasswordModelList(List<dynamic> passwordList) async {
    final prefs = Preferences().instance;
    final encodedList =
        passwordList.map((password) => password.toJson()).toList();
    final jsonString = json.encode(encodedList);
    await prefs?.setString('password_list', jsonString);
  }

  Future<void> updatePasswordModelList(List<dynamic> passwords) async {
    final exists = Preferences().instance?.containsKey('password_list');
    if (exists!) {
      await Preferences().instance?.remove('password_list');
      await savePasswordModelList(passwords);
    } else {
      await savePasswordModelList(passwords);
    }
  }

  Future<List<dynamic>> fetchPasswordModelList() async {
    final prefs = Preferences().instance;
    final jsonString = prefs?.getString('password_list');
    if (jsonString != null) {
      final jsonList = json.decode(jsonString) as List<dynamic>;
      final passwordList =
          jsonList.map((json) => PasswordModel.fromJson(json: json)).toList();
      return passwordList;
    } else {
      return [];
    }
  }

  Future<void> clearUserData() async {
    final prefs = Preferences().instance;
    await prefs!.remove('user_model');
    await prefs.remove('password_list');
  }
}
