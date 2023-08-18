import 'package:passtop/core/imports/packages_imports.dart';

import '../core/imports/core_imports.dart';

class AppLockController extends GetxController {

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
