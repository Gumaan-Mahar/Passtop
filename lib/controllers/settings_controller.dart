import 'dart:convert';
import 'dart:developer';

import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/controllers/watch_tower_controller.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/models/password.dart';

import '../core/instances.dart';
import '../services/user_services.dart';

class SettingsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyDelete = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final TextEditingController currentPasswordControllerDelete =
      TextEditingController();
  final FocusNode currentPasswordFocusNodeDelete = FocusNode();

  final FocusNode currentPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();

  void clearTextFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
  }

  void clearTextFieldsDelete() {
    currentPasswordControllerDelete.clear();
  }

  // void migrateDataAfterPasswordChange({
  //   required String newMasterPassword,
  //   required InitializationController initializationController,
  //   required List<dynamic> passwords,
  //   required HomeController homeController,
  //   required WatchTowerController watchTowerController,
  // }) async {
  //   final newSalt = encryptionServices.generateRandomSalt(length: 32);

  //   final newHashedPassword = encryptionServices.hashMasterPassword(
  //     newMasterPassword,
  //     newSalt,
  //   );
  //   final newEncryptionKey = encryptionServices.deriveEncryptionKey(
  //     newHashedPassword,
  //     newSalt,
  //   );

  //   List<Map<String, dynamic>> reEncryptedPasswords = [];
  //   for (var password in passwords) {
  //     reEncryptedPasswords.add(password.toJsonWithEncryption(newEncryptionKey));
  //   }
  //   try {
  //     final response = await supabase.rpc(
  //       'replace_passwords',
  //       params: {
  //         'user_id_arg': initializationController.currentUser.value!.id,
  //         'new_passwords': reEncryptedPasswords,
  //         'salt': newSalt,
  //         'new_master_password': newHashedPassword,
  //       },
  //     ).then(
  //       (value) {
  //         initializationController.currentUser.value!.salt = newSalt;
  //         initializationController.currentUser.value!.masterPassword =
  //             newMasterPassword;
  //         initializationController.encryptionKey.value = newEncryptionKey;
  //       },
  //     );
  //     // .then((value) async {
  //     //   await UserServices.updateUser(
  //     //     data: {
  //     //       'salt': newSalt,
  //     //       'master_password': newHashedPassword,
  //     //     },
  //     //   );
  //     //   initializationController.currentUser.value!.salt = newSalt;
  //     //   initializationController.currentUser.value!.masterPassword =
  //     //       newMasterPassword;
  //     //   initializationController.encryptionKey.value = newEncryptionKey;
  //     // });
  //     // initializationController.currentUser.value!.salt = newSalt;
  //     // initializationController.currentUser.value!.masterPassword =
  //     //     newMasterPassword;
  //     homeController.passwords.value = response;
  //     watchTowerController.passwords.value = response;
  //     log('new updated passwords data: $response');
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  void migrateDataAfterPasswordChange({
    required String newMasterPassword,
    required InitializationController initializationController,
    required List<dynamic> passwords,
    required HomeController homeController,
    required WatchTowerController watchTowerController,
  }) async {
    final newSalt = encryptionServices.generateRandomSalt(length: 32);

    final newHashedPassword =
        encryptionServices.hashMasterPassword(newMasterPassword, newSalt);
    final newEncryptionKey =
        encryptionServices.deriveEncryptionKey(newHashedPassword, newSalt);

    List<Map<String, dynamic>> reEncryptedPasswords = [];
    for (var password in passwords) {
      reEncryptedPasswords.add(password.toJsonWithEncryption(newEncryptionKey));
    }

    try {
      await supabase.rpc(
        'update_user_passwords_and_salt',
        params: {
          'user_id_arg': initializationController.currentUser.value!.id,
          'new_passwords': reEncryptedPasswords,
          'new_salt': newSalt,
          'new_master_password': newHashedPassword,
        },
      ).then((_) async {
        initializationController.currentUser.value!.salt = newSalt;
        initializationController.currentUser.value!.masterPassword =
            newMasterPassword;
        initializationController.encryptionKey.value = newEncryptionKey;
        await EasyLoading.showToast(
          AppStrings.settingsScreenPasswordSuccessfullyChanged,
          toastPosition: EasyLoadingToastPosition.top,
        );
      }).onError((error, stackTrace) async {
        await EasyLoading.showInfo(
          'An error occured while changing your password. Try again, later!',
        );
        log('Error during RPC call: $error');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmNewPasswordFocusNode.dispose();

    currentPasswordControllerDelete.dispose();
    currentPasswordFocusNodeDelete.dispose();
    super.dispose();
  }
}
