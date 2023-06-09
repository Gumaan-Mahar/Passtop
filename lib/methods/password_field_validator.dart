import '../core/imports/core_imports.dart';

String? validatePassword(
    {required String? value, required FocusNode focusNode}) {
  if (value!.trim().isEmpty || value.length < 8 || value.length > 16) {
    focusNode.requestFocus();
  }
  if (value.isEmpty) {
    return AppStrings.setupApplockScreenPasswordIsRequired;
  } else if (value.length < 8) {
    return AppStrings.setupApplockScreenPasswordIsTooShort;
  } else if (value.length > 16) {
    return AppStrings.setupApplockScreenPasswordIsTooLong;
  }
  return null;
}
