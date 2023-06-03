import 'dart:developer';

import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/main.dart';
import 'package:passtop/models/user.dart';

import '../screens/signin_screen/signin_screen.dart';

class UserServices {
  static Future<void> getCurrentUser() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      final data = await supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single() as Map<String, dynamic>;
      final user = UserModel.fromJson(data);
      currentUser.value = user;
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
      log(error.message);
      rethrow;
    } catch (error) {
      await EasyLoading.showInfo('Unexpected exception occured');
      log(error.toString());
      rethrow;
    }
  }

  static Future<void> updateUser({required Map<String, dynamic> data}) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('users').update(data).eq('id', userId);
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
    } catch (error) {
      await EasyLoading.showInfo('Unexpected exception occured');
    }
  }

  static Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      Get.offAll(() => SigninScreen());
    } on AuthException catch (error) {
      await EasyLoading.showInfo(error.message);
    } catch (error) {
      await EasyLoading.showInfo('Unexpected error occurred');
    }
  }
}
