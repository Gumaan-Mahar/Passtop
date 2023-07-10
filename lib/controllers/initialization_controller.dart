import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../main.dart';
import '../screens/no_internet_connection_screen/no_internet_connection.dart';

class InitializationController {
  static void configLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> initializeApp() async {
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"]!,
      anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
      authCallbackUrlHostname: 'login-callback',
    );
    configLoading();
    FlutterNativeSplash.remove();
  }
}
