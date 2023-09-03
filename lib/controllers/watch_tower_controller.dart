import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/methods/calculate_password_score.dart';
import 'package:passtop/services/passwords_services.dart';

import '../models/password.dart';

class WatchTowerController extends GetxController {
  RxDouble passwordsTotalScore = 0.0.obs;
  RxList passwords = [].obs;
  RxList weakPasswords = [].obs;
  RxList commonPasswords = [].obs;
  RxList reusedPasswords = [].obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isFetching = false.obs;
  RxBool hasPasswordsFetchError = false.obs;
  RxBool isRetryingPasswordsFetch = false.obs;
  RxString passwordsFetchErrorMessage = ''.obs;

  final InitializationController initializationController = Get.find();

  @override
  void onInit() async {
    super.onInit();
    isFetching.value = true;
    final currentUser = supabase.auth.currentUser;
    try {
      if (currentUser != null) {
        passwords.value = await PasswordsServices.fetchPasswords(
          userId: currentUser.id,
          encryptionKey: initializationController.encryptionKey.value!,
          hasPasswordsFetchError: hasPasswordsFetchError,
          isRetryingPasswordsFetch: isRetryingPasswordsFetch,
          passwordsFetchErrorMessage: passwordsFetchErrorMessage,
        );
      }
      passwordsTotalScore.value = await calculateTotalScore();
      isFetching.value = false;
    } catch (e) {
      await EasyLoading.showError(
          'A network or server error occurred. Please try again.');
    }
  }

  Future<double> calculateTotalScore() async {
    final List<dynamic> passwordsCopy = List.from(passwords);
    int totalScore = 0;
    int totalPasswords = 0;
    final List<dynamic> reused = [];
    final List<dynamic> common = [];
    final List<dynamic> weak = [];

    for (var password in passwordsCopy) {
      if (password.category == 'App' || password.category == 'Browser') {
        Map<String, dynamic> passwordStatus =
            await calculatePasswordScore(password.password);
        final passwordScore = passwordStatus['score'] as int;
        totalPasswords += 1;
        totalScore += passwordScore;
        if (passwordStatus['isPasswordBreached']) {
          common.add(password);
        }
        if (passwordStatus['isPasswordReused']) {
          if (reused.where((p0) => p0.password == password.password).isEmpty) {
            reused.add(password);
          }
        }
        if (!passwordStatus['isPasswordReused'] &&
            !passwordStatus['isPasswordBreached'] &&
            passwordScore != 7) {
          weak.add(password);
        }
      }
    }
    commonPasswords.value = common;
    reusedPasswords.value = reused;
    weakPasswords.value = weak;

    if (totalPasswords > 0) {
      double percentage =
          ((totalScore.toDouble() / (totalPasswords.toDouble() * 7)) * 100)
              .roundToDouble();
      return percentage;
    } else {
      return 0.0;
    }
  }

  Future<void> updateTotalScore() async {
    passwordsTotalScore.value = await calculateTotalScore();
  }

  Future<void> updatePasswordListAfterDelete(String passwordID) async {
    passwords.removeWhere((element) => element.id == passwordID);
    await updateTotalScore();
  }

  Future<void> updatePasswordListEdit(PasswordModel updatedPassword) async {
    passwords.removeWhere((password) => password.id == updatedPassword.id);
    passwords.add(updatedPassword);
    await updateTotalScore();
  }
}
