import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/widgets/show_toast.dart';

import '../core/imports/packages_imports.dart';
import '../core/instances.dart';

class AuthServices {
  static Future<void> continueWithGoogle({required BuildContext context}) async {
    try {
      await supabase.auth.signInWithOAuth(
        Provider.google,
        redirectTo: kIsWeb
            ? null
            : 'https://dabpyizqziezyyqxjkqn.supabase.co/auth/v1/callback',
        authScreenLaunchMode: LaunchMode.platformDefault,
        context: context,
      );
    } catch (e) {
      showToast('Login failed');
      log(e.toString());
    }
  }
}
