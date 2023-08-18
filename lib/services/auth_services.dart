import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:passtop/core/imports/core_imports.dart';

import '../core/imports/packages_imports.dart';
import '../core/instances.dart';

class AuthServices {
  static bool isAuthenticating = false;

  static Future<void> continueWithGoogle(
      {required BuildContext context}) async {
    // Check if an authentication attempt is already ongoing
    if (isAuthenticating) {
      await EasyLoading.showInfo('Already signing you in. Please wait...');
      return;
    }

    // Set the flag to indicate an authentication attempt is in progress
    isAuthenticating = true;

    try {
      await supabase.auth.signInWithOAuth(
        Provider.google,
        // redirectTo: kIsWeb
        //     ? null
        //     : 'https://dabpyizqziezyyqxjkqn.supabase.co/auth/v1/callback',
        context: context,
      );
    } catch (error) {
      await EasyLoading.showInfo(
        'Unexpected error occurred while signing you in.',
      );
      log(error.toString());
    } finally {
      // Reset the flag to allow future authentication attempts
      isAuthenticating = false;
    }
  }
}
