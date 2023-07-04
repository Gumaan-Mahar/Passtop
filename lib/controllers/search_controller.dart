import 'package:get/get.dart';

import 'home_controller.dart';

class PasswordSearchController extends GetxController {
  final HomeController homeController = Get.find();

  RxBool hideKeyboard = true.obs;
  final RxBool hideSuggestionsBox = false.obs;

  Iterable<dynamic> showSuggestions({required String query}) {
    final List filteredPasswords = homeController.passwords.where((password) {
      return password.category.toLowerCase().contains(query.toLowerCase()) ||
          password.appName.toLowerCase().contains(query.toLowerCase()) ||
          password.username.toLowerCase().contains(query.toLowerCase()) ||
          password.websiteUrl.toLowerCase().contains(query.toLowerCase()) ||
          password.cardNumber.toLowerCase().contains(query.toLowerCase()) ||
          password.nameOnCard.toLowerCase().contains(query.toLowerCase()) ||
          password.nickName.toLowerCase().contains(query.toLowerCase()) ||
          password.firstName.toLowerCase().contains(query.toLowerCase()) ||
          password.lastName.toLowerCase().contains(query.toLowerCase()) ||
          password.identityNumber.toLowerCase().contains(query.toLowerCase()) ||
          password.addressName.toLowerCase().contains(query.toLowerCase()) ||
          password.addressOrganisation
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          password.addressPhone.toLowerCase().contains(query.toLowerCase()) ||
          password.addressEmail.toLowerCase().contains(query.toLowerCase()) ||
          password.addressRegion.toLowerCase().contains(query.toLowerCase()) ||
          password.addressStreetAddress
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          password.addressCity.toLowerCase().contains(query.toLowerCase()) ||
          password.addressPostalCode
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          password.generalText.toLowerCase().contains(query.toLowerCase()) ||
          password.notes.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return filteredPasswords;
  }
}
