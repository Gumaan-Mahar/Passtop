import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/models/user.dart';

import '../controllers/initialization_controller.dart';
import '../screens/signin_screen/signin_screen.dart';

class UserServices {
  static Future<void> getCurrentUser(
      {required String userId,
      required InitializationController controller}) async {
    try {
      final jsonData = await supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single() as Map<String, dynamic>;
      final user = UserModel.fromJson(jsonData);
      controller.currentUser.value = user;
    } on PostgrestException catch (error) {
      await EasyLoading.showError('Error: ${error.message}');
      log(error.message);
    } on SocketException catch (error) {
      await EasyLoading.showError(
        'Unable to connect to the server. Please check your internet connection and try again.',
        duration: const Duration(
          seconds: 3,
        ),
      );
      log('Socket Exception: ${error.message}');
    } on http.ClientException catch (error) {
      await EasyLoading.showError(
        'Unable to establish a connection with the server. Please try again later.',
        duration: const Duration(
          seconds: 3,
        ),
      );
      log('Client Exception: ${error.message}');
    } catch (error) {
      await EasyLoading.showError(
        'Unexpected exception occurred',
        duration: const Duration(
          seconds: 3,
        ),
      );
      log(error.toString());
    }
  }

  static Future<void> updateUser({required Map<String, dynamic> data}) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('users').update(data).eq('id', userId);
    } on PostgrestException catch (error) {
      final errorMessage = error.message;
      await EasyLoading.showInfo(
        'Failed to update user: $errorMessage',
        duration: const Duration(
          seconds: 3,
        ),
      );
      log(errorMessage);
    } catch (error) {
      await EasyLoading.showInfo(
        'Unexpected exception occured while updating user',
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

  static Future<void> deleteUserData(
      {required InitializationController controller}) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await deletePasswords(userId);
      await supabase.rpc('delete_user');
      await signOut(controller: controller);
      Get.offAll(() => SigninScreen());
      await EasyLoading.showToast("You account was successfully deleted!");
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(
          'Failed to delete your account: ${error.message}');
      log(error.message);
    } on http.ClientException catch (error) {
      await EasyLoading.showError(
        'Unable to establish a connection with the server. Please try again later.',
        duration: const Duration(seconds: 3),
      );
      log('Client Exception: ${error.message}');
    } catch (error) {
      await EasyLoading.showInfo(
          'Unexpected exception occurred while deleting your account.');
      log(error.toString());
    }
  }

  static Future<void> deletePasswords(String userId) async {
    try {
      await UserServices.unsubscribeFromCurrentUserChannel();
      await supabase.from('passwords').delete().eq('user_id', userId).select();
    } catch (passwordsError) {
      await EasyLoading.showInfo(
          'An unexpected error occurred while deleting your account. Try again later.');
      log(passwordsError.toString());
      rethrow; // Stop further execution if there was an error deleting passwords
    }
  }

  static Future<void> signOut(
      {required InitializationController controller}) async {
    try {
      controller.currentUser.value = null;
      controller.encryptionKey.value = null;
      await supabase.auth.signOut();
      await EasyLoading.dismiss();
      Get.offAll(() => SigninScreen());
    } on AuthException catch (error) {
      final errorMessage = error.message;
      await EasyLoading.showInfo('Failed to sign out: $errorMessage');
      log(errorMessage);
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
    } on http.ClientException catch (error) {
      await EasyLoading.showError(
        'Unable to establish a connection with the server. Please try again later.',
        duration: const Duration(seconds: 3),
      );
      log('Client Exception: ${error.message}');
    } catch (error) {
      await EasyLoading.showInfo('Unexpected error occurred during sign out');
    }
  }

  static void subscribeToCurrentUserChannel(
      {required InitializationController controller}) {
    supabase.channel('public:users').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'UPDATE',
        schema: 'public',
        table: 'users',
        filter: 'id=eq.${supabase.auth.currentUser?.id}',
      ),
      (payload, [ref]) async {
        log('user updated: $payload');
        final updatedUser = UserModel.fromJson(
          payload['new'],
        );
        controller.refreshCurrentUser(updatedUser: updatedUser);
      },
    ).on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'DELETE',
        schema: 'public',
        table: 'users',
        filter: 'id=eq.${supabase.auth.currentUser?.id}',
      ),
      (payload, [ref]) {
        log('deleted user: $payload');
      },
    ).subscribe();
  }

  static Future<void> unsubscribeFromCurrentUserChannel() async {
    await supabase.channel('public:users').unsubscribe();
  }
}
