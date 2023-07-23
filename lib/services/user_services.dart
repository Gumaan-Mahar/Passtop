import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/models/user.dart';
import 'package:passtop/services/preferences_services.dart';

import '../controllers/initialization_controller.dart';
import '../screens/signin_screen/signin_screen.dart';

class UserServices {
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  static Future<void> getCurrentUser({required String userId}) async {
    final InitializationController initializationController = Get.find();
    final bool isUserCached =
        Preferences().instance?.containsKey('user_model') ?? false;

    bool hasStableConnection = false;
    int retryCount = 0;

    if (initializationController.connectionStatus.value ==
            ConnectivityResult.none &&
        isUserCached) {
      initializationController.currentUser.value =
          await PreferencesServices().fetchCurrentUser();
      return;
    }

    while (!hasStableConnection && retryCount < maxRetries) {
      try {
        final data =
            await supabase.from('users').select().eq('id', userId).single();
        final user = UserModel.fromJson(data as Map<String, dynamic>);
        await PreferencesServices().updateUserModel(user);
        initializationController.currentUser.value = user;
        hasStableConnection = true;
      } on PostgrestException catch (error) {
        if (error is TimeoutException) {
          retryCount++;
          await Future.delayed(retryDelay);
        } else {
          await EasyLoading.showError('Error: ${error.message}');
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

  static Future<void> deleteUserData(
      {required InitializationController controller}) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      // Delete user passwords first
      try {
        await UserServices.unsubscribeFromCurrentUserChannel();
        await supabase
            .from('passwords')
            .delete()
            .eq('user_id', userId)
            .select();
      } catch (passwordsError) {
        await EasyLoading.showInfo(
            'Something went wrong while deleting your account. Try again.');
        log(passwordsError.toString());
        return; // Stop further execution if there was an error deleting passwords
      }

      try {
        await supabase.rpc('delete_user');
        await signOut(controller: controller);
      } catch (rpcError) {
        await EasyLoading.showInfo(
            'Your passwords were deleted successfully, but something went wrong while deleting your account. Try again.');
        log(rpcError.toString());
      }
    } on PostgrestException catch (error) {
      final errorMessage = error.message;
      await EasyLoading.showInfo(
          'Failed to delete your account: $errorMessage');
      log(errorMessage);
    } catch (error) {
      await EasyLoading.showInfo(
          'Unexpected exception occurred while deleting your account.');
      log(error.toString());
    }
  }

  static Future<void> signOut(
      {required InitializationController controller}) async {
    try {
      await PreferencesServices().clearUserData();
      controller.currentUser.value = null;
      await supabase.auth.signOut();
      await EasyLoading.dismiss();
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
        final updatedUser = UserModel.fromJson(payload['new']);
        await controller.refreshCurrentUser(updatedUser: updatedUser);
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
