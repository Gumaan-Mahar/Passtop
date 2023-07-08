import 'dart:developer';

import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/controllers/watch_tower_controller.dart';
import 'package:passtop/models/password.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';

import '../core/imports/packages_imports.dart';
import '../core/instances.dart';

class PasswordsServices {
  static Future<void> savePassword({required PasswordModel password}) async {
    try {
      await supabase.from('passwords').insert(password.toJson());
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
      log(error.message);
    } catch (e) {
      await EasyLoading.showInfo('An unexpected error occurred.');
      log(e.toString());
    }
  }

  static Future<void> updatePassword({required PasswordModel password}) async {
    try {
      await supabase.from('passwords').update(password.toJson()).eq(
            'id',
            password.id,
          );
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
      log(error.message);
    } catch (e) {
      await EasyLoading.showInfo('An unexpected error occurred.');
      log(e.toString());
    }
  }

  static Future<void> deletePassword({required String passwordID}) async {
    try {
      await supabase.from('passwords').delete().eq(
            'id',
            passwordID,
          );
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
      log(error.message);
    } catch (e) {
      await EasyLoading.showInfo('An unexpected error occurred.');
      log(e.toString());
    }
  }

  static Future<List<dynamic>> fetchPasswords({required String userId}) async {
    List<dynamic> passwords = [];
    final passwordsData =
        await supabase.from('passwords').select().eq('user_id', userId);
    passwords = passwordsData
        .map(
          (passwordData) => PasswordModel.fromJson(json: passwordData),
        )
        .toList();
    return passwords;
  }

  static void subscribeToPasswordsChannel({required List passwords}) {
    final HomeController homeController = Get.find();
    final WatchTowerController watchTowerController =
        Get.put(WatchTowerController());
    supabase
        .channel('public:passwords:user_id=eq.${supabase.auth.currentUser?.id}')
        .on(
            RealtimeListenTypes.postgresChanges,
            ChannelFilter(
              event: 'INSERT',
              schema: 'public',
              table: 'passwords',
              filter: 'user_id=eq.${supabase.auth.currentUser?.id}',
            ), (payload, [ref]) {
      PasswordModel password = PasswordModel.fromJson(json: payload['new']);
      final category = PasswordCategory(
          category: password.category, controller: homeController);
      category.isApp
          ? homeController.appsPasswordsTotal.value += 1
          : category.isBrowser
              ? homeController.browsersPasswordsTotal.value += 1
              : category.isPayment
                  ? homeController.paymentsPasswordsTotal.value += 1
                  : category.isIdentity
                      ? homeController.identitiesPasswordsTotal.value += 1
                      : category.isAddress
                          ? homeController.addressesPasswordsTotal.value += 1
                          : category.isGeneral
                              ? homeController.generalPasswordsTotal.value += 1
                              : null;
      passwords.add(password);
      watchTowerController.passwords.add(password);
      watchTowerController.updateTotalScore();
      homeController.refreshRecentPasswords(
        recentPasswordsList: homeController.recentPasswords,
        passwordsList: homeController.passwords,
      );
    }).on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'DELETE',
        schema: 'public',
        table: 'passwords',
        filter: 'user_id=eq.${supabase.auth.currentUser?.id}',
      ),
      (payload, [ref]) async {
        String passwordID = payload['old']['id'];
        homeController.updatePasswordListAfterDelete(passwordID);
        await watchTowerController.updatePasswordListAfterDelete(passwordID);
        homeController.refreshRecentPasswords(
          recentPasswordsList: homeController.recentPasswords,
          passwordsList: homeController.passwords,
        );
      },
    ).on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'UPDATE',
        schema: 'public',
        table: 'passwords',
        filter: 'user_id=eq.${supabase.auth.currentUser?.id}',
      ),
      (payload, [ref]) async {
        PasswordModel password = PasswordModel.fromJson(json: payload['new']);
        homeController.updatePasswordListEdit(password);
        await watchTowerController.updatePasswordListEdit(password);
      },
    ).subscribe();
  }

  static Future<void> unsubscribeFromPasswordsChannel() async {
    await supabase.channel('public:passwords').unsubscribe();
  }
}
