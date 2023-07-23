import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/core/imports/packages_imports.dart';

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
