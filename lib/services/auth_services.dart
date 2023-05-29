import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:passtop/widgets/show_toast.dart';

import '../core/imports/packages_imports.dart';
import '../core/instances.dart';

class AuthServices {
  static void continueWithGoogle() async {
    try {
      await supabase.auth.signInWithOAuth(
        Provider.google,
        redirectTo: kIsWeb
            ? null
            : 'https://dabpyizqziezyyqxjkqn.supabase.co/auth/v1/callback',
        authScreenLaunchMode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      showToast('Login failed');
      log(e.toString());
    }
  }
}
