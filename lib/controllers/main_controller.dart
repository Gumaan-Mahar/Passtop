import 'dart:developer';

import 'package:passtop/core/imports/packages_imports.dart';

class MainController extends GetxController {
  RxBool isUserSignedIn = false.obs;

  @override
  void onInit() {
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn) {
        isUserSignedIn.value = true;
        log('logged in');
      } else if (event.event == AuthChangeEvent.signedOut) {
        isUserSignedIn.value = false;
        log('logged out');
      }
    });
    super.onInit();
  }
}
