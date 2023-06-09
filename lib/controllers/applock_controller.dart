import 'package:passtop/core/imports/packages_imports.dart';

import '../core/imports/core_imports.dart';


class AppLockController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final RxBool isContinueButtonLoading = false.obs;

  @override
  void dispose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
