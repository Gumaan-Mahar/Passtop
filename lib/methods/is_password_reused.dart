import 'package:get/get.dart';
import 'package:passtop/controllers/home_controller.dart';

bool isPasswordReused({required String password}) {
  HomeController homeController = Get.find();
  final List<dynamic> matchingPasswords =
      homeController.passwords.where((p0) => p0.password == password).toList();
  return matchingPasswords.length <= 1 ? false : true;
}
