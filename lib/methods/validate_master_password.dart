import 'package:flutter/material.dart';

import '../core/resources/app_strings/app_strings.dart';

String? validateMasterPassword(String? value, FocusNode focusNode) {
    if (value == null || value.isEmpty) {
      focusNode.requestFocus();
      return AppStrings.setupApplockScreenPasswordIsRequired;
    } else if (value.length < 8) {
      focusNode.requestFocus();
      return AppStrings.setupApplockScreenPasswordIsTooShort;
    } else if (value.length > 16) {
      focusNode.requestFocus();
      return AppStrings.setupApplockScreenPasswordIsTooLong;
    } else if (!value.contains(
      RegExp(r'[A-Z]'),
    )) {
      focusNode.requestFocus();
      return 'Password must contain atleast 1 captial letter.';
    } else if (!value.contains(
      RegExp(r'[a-z]'),
    )) {
      focusNode.requestFocus();
      return 'Password must contain atleast 1 small letter.';
    } else if (!value.contains(
      RegExp(r'[0-9]'),
    )) {
      focusNode.requestFocus();
      return 'Password must contain atleast 1 digit.';
    } else if (value.contains(RegExp(r'\s'))) {
      focusNode.requestFocus();
      return 'Password must not contain any spaces';
    } else if (!value.contains(
      RegExp(r'[$&+,:;=?@#|<>.^*()%!-]'),
    )) {
      focusNode.requestFocus();
      return 'Password must contain atleast 1 symbol';
    }
    return null;
  }