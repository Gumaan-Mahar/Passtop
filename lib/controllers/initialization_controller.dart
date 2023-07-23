
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passtop/core/resources/app_strings/app_strings.dart';
import 'package:passtop/services/preferences_services.dart';
import 'package:passtop/services/user_services.dart';
import '../core/imports/packages_imports.dart';
import '../core/instances.dart';
import '../models/user.dart';

class InitializationController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  final RxBool isInitialized = false.obs;

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isCurrentUserLoading = false.obs;

  final RxBool hasInitialisationError = false.obs;

  bool isOffline = false;

  @override
  void onInit() async {
    await initializeApp();
    await handleAuthState();
    UserServices.subscribeToCurrentUserChannel(controller: this);
    super.onInit();
  }

  Future<void> handleAuthState() async {
    supabase.auth.onAuthStateChange.listen(
      (event) async {
        if (event.event == AuthChangeEvent.signedIn) {
          isCurrentUserLoading.value = true;
          await UserServices.getCurrentUser(
            userId: supabase.auth.currentUser!.id,
          );
          UserServices.subscribeToCurrentUserChannel(controller: this);
          isCurrentUserLoading.value = false;
        } else if (event.event == AuthChangeEvent.signedOut) {
          currentUser.value = null;
          await UserServices.unsubscribeFromCurrentUserChannel();
        } else if (event.event == AuthChangeEvent.tokenRefreshed) {
          await UserServices.getCurrentUser(userId: event.session!.user.id);
          UserServices.subscribeToCurrentUserChannel(controller: this);
        } else if (DateTime.fromMillisecondsSinceEpoch(
                event.session!.expiresAt!)
            .isBefore(
          DateTime.now().subtract(
            const Duration(seconds: 2),
          ),
        )) {
          try {
            final refreshedSession = await supabase.auth.refreshSession();
            await UserServices.getCurrentUser(
                userId: refreshedSession.user!.id);
            UserServices.subscribeToCurrentUserChannel(controller: this);
          } catch (e) {
            await EasyLoading.show(
              status: AppStrings.sessionExpiredLoggingOut,
            );
            await UserServices.signOut(
              controller: this,
            );
            await EasyLoading.showToast(
              AppStrings.sessionExpiredSigninAgain,
              duration: const Duration(
                seconds: 3,
              ),
              toastPosition: EasyLoadingToastPosition.top,
            );
          }
        }
      },
    );
  }

  Future<void> refreshCurrentUser({required UserModel updatedUser}) async {
    currentUser.value = updatedUser;
    await PreferencesServices().updateUserModel(updatedUser);
  }

  void configLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  Future<void> initializeApp() async {
    try {
      await dotenv.load(fileName: ".env");

      await Supabase.initialize(
        url: dotenv.env["SUPABASE_URL"]!,
        anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
        authCallbackUrlHostname: 'login-callback',
      );
      configLoading();
      isInitialized.value = true;
    } catch (e) {
      hasInitialisationError.value = true;
    }
  }

  Future<void> initializeConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    isOffline = (result == ConnectivityResult.none);

    _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none && !isOffline) {
        isOffline = true;
        await showConnectionToast(result);
      } else if (result != ConnectivityResult.none && isOffline) {
        isOffline = false;
        await showConnectionToast(result);
      }
    });
  }

  Future<void> showConnectionToast(ConnectivityResult result) async {
    String message;
    if (result == ConnectivityResult.none) {
      message =
          "Oops! It looks like you're offline. Please check your internet connection.";
    } else {
      message = 'Connection Restored: You are now back online.';
    }
    await EasyLoading.showToast(
      message,
      toastPosition: EasyLoadingToastPosition.top,
      duration: const Duration(
        seconds: 5,
      ),
    );
  }

  @override
  void dispose() async {
    await UserServices.unsubscribeFromCurrentUserChannel();
    super.dispose();
  }
}
