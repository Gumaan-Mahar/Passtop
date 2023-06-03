import 'package:passtop/core/imports/packages_imports.dart';

import '../core/imports/core_imports.dart';


class AppLockController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  RxBool isContinueButtonLoading = false.obs;

  @override
  void dispose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
