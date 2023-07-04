import 'package:passtop/controllers/home_controller.dart';

class PasswordCategory {
  final String category;
  final HomeController controller;

  PasswordCategory({required this.category, required this.controller});

  get isApp {
    return category == controller.categories[0];
  }

  get isBrowser {
    return category == controller.categories[1];
  }

  get isPayment {
    return category == controller.categories[2];
  }

  get isIdentity {
    return category == controller.categories[3];
  }

  get isAddress {
    return category == controller.categories[4];
  }

  get isGeneral {
    return category == controller.categories[5];
  }
}
