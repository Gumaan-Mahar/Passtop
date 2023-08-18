import 'dart:developer';

import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/services/user_services.dart';
import 'package:passtop/widgets/custom_button.dart';

import '../../controllers/applock_controller.dart';
import '../../controllers/signin_controller.dart';
import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../app_lock_screen/app_lock_screen.dart';
import '../set_up_applock_screen/set_up_applock_screen.dart';
import '../signin_screen/signin_screen.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({
    super.key,
  });

  final SigninController signinController = Get.put(SigninController());
  final AppLockController appLockController = Get.put(AppLockController());
  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () {
          if (initializationController.isCurrentUserLoading.value ||
              initializationController.isInitializing.value) {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.primaryColor,
                  size: 28.w,
                ),
              ),
            );
          } else {
            try {
              if (initializationController.isInitialized.value &&
                  supabase.auth.currentUser == null) {
                return SigninScreen();
              }
              final currentUser = initializationController.currentUser.value;
              if (currentUser == null) {
                return Scaffold(
                  body: Center(
                    child: CustomButton(
                      width: Get.width * 0.3,
                      text: 'Try again',
                      onPressed: () async {
                        try {
                          await EasyLoading.show(status: 'Retrying...');
                          await UserServices.getCurrentUser(
                            userId: supabase.auth.currentUser!.id,
                            controller: initializationController,
                          );
                          await Future.delayed(const Duration(seconds: 2),
                              () async {
                            await EasyLoading.dismiss();
                          });
                        } catch (e) {
                          await EasyLoading.showToast(
                            'No stable internet connection, try again later.',
                            duration: const Duration(
                              seconds: 5,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              } else if (currentUser.masterPassword.isNotEmpty) {
                return AppLockScreen();
              } else if (currentUser.masterPassword.isEmpty) {
                return SetupAppLockScreen();
              }
            } catch (e) {
              log(e.toString());
              return SigninScreen();
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
