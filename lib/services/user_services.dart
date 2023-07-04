import 'dart:async';
import 'dart:developer';

import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/main.dart';
import 'package:passtop/models/user.dart';

import '../screens/signin_screen/signin_screen.dart';

class UserServices {
  static Future<void> getCurrentUser({required String userId}) async {
    int maxRetries = 3;
    int retryCount = 0;
    bool hasStableConnection = false;

    while (!hasStableConnection && retryCount < maxRetries) {
      try {
        final data = await supabase
            .from('users')
            .select()
            .eq('id', userId)
            .single() as Map<String, dynamic>;
        final user = UserModel.fromJson(data);
        currentUser.value = user;
        hasStableConnection = true;
      } on PostgrestException catch (error) {
        if (error is TimeoutException) {
          retryCount++;
          await Future.delayed(const Duration(seconds: 2));
        } else {
          await EasyLoading.showError(error.message);
          log(error.message);
          rethrow;
        }
      } catch (error) {
        await EasyLoading.showError('Unexpected exception occurred');
        log(error.toString());
      }
    }

    if (!hasStableConnection) {
      await EasyLoading.showError('No stable internet connection');
    }
  }

  static Future<void> updateUser({required Map<String, dynamic> data}) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('users').update(data).eq('id', userId);
    } on PostgrestException catch (error) {
      final errorMessage = error.message;
      await EasyLoading.showInfo('Failed to update user: $errorMessage');
      log(errorMessage);
    } catch (error) {
      await EasyLoading.showInfo(
          'Unexpected exception occured while updating user');
    }
  }

  static Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      Get.offAll(() => SigninScreen());
    } on AuthException catch (error) {
      final errorMessage = error.message;
      await EasyLoading.showInfo('Failed to sign out: $errorMessage');
      log(errorMessage);
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
    } catch (error) {
      await EasyLoading.showInfo('Unexpected error occurred during sign out');
    }
  }
}
