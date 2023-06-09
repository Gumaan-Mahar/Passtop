import '../core/imports/core_imports.dart';

String? validateTextField(
    {required String? value, required FocusNode focusNode}) {
  if (value!.trim().isEmpty || value.length < 8) {
    focusNode.requestFocus();
  }
  if (value.isEmpty) {
    return AppStrings.homeScreenThisFieldIsRequired;
  } else if (value.length < 8) {
    return AppStrings.homeScreenTooShort;
  }
  return null;
}
