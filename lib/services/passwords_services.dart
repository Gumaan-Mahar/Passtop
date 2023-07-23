import 'dart:io';

import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/controllers/watch_tower_controller.dart';
import 'package:passtop/models/password.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';
import 'package:passtop/services/preferences_services.dart';

import '../core/imports/packages_imports.dart';
import '../core/instances.dart';

class PasswordsServices {
  static Future<void> savePassword({required PasswordModel password}) async {
    try {
      await supabase.from('passwords').insert(password.toJson());
    } on PostgrestException catch (error) {
      await EasyLoading.showInfo(error.message);
    } on SocketException {
      await EasyLoading.showInfo(
        'A server or network error occurred. Try again later.',
      );
    } on HttpException {
      await EasyLoading.showInfo(
        'A server or network error occurred. Try again later.',
      );
    } catch (e) {
      await EasyLoading.showInfo(
        'Something went wrong. Try again later',
      );
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
    } on SocketException {
      await EasyLoading.showInfo(
        'A server or network error occurred. Try again later.',
      );
    } on HttpException {
      await EasyLoading.showInfo(
        'A server or network error occurred. Try again later.',
      );
    } catch (e) {
      await EasyLoading.showInfo(
        'Something went wrong. Try again later',
      );
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
    } on SocketException {
      await EasyLoading.showInfo(
        'A server or network error occurred. Try again later.',
      );
    } on HttpException {
      await EasyLoading.showInfo(
        'A server or network error occurred. Try again later.',
      );
    } catch (e) {
      await EasyLoading.showInfo(
        'Something went wrong. Try again later',
      );
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

  static void subscribeToPasswordsChannel(
      {required List passwords, required HomeController homeController}) {
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
            ), (payload, [ref]) async {
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
      await PreferencesServices().updatePasswordModelList(passwords);
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
        await PreferencesServices()
            .updatePasswordModelList(homeController.passwords);
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
        PreferencesServices().updatePasswordModelList(homeController.passwords);
      },
    ).subscribe();
  }

  static Future<void> unsubscribeFromPasswordsChannel() async {
    await supabase.channel('public:passwords').unsubscribe();
  }
}
