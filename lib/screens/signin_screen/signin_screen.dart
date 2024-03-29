
import 'package:flutter/services.dart';
import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/controllers/signin_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/resources/assets_manager/assets_manager.dart';
import 'package:passtop/services/auth_services.dart';
import 'package:passtop/widgets/button_loader.dart';
import 'package:passtop/widgets/custom_button.dart';

import '../../core/imports/core_imports.dart';
import '../app_lock_screen/app_lock_screen.dart';
import '../set_up_applock_screen/set_up_applock_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final SigninController signinController = Get.find();
  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => initializationController.currentUser.value != null
          ? initializationController
                  .currentUser.value!.masterPassword.isNotEmpty
              ? AppLockScreen()
              : SetupAppLockScreen()
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: AppColors.customDarkColor,
                systemNavigationBarColor: AppColors.customDarkColor,
              ),
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03,
                    vertical: Get.height * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SvgPicture.asset(
                              AssetsManager.signinIllustration),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 32.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SlideInLeft(
                                from: 300,
                                child: Text(
                                  AppStrings.signinScreenTitle,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.titleLarge,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              SlideInLeft(
                                delay: const Duration(milliseconds: 600),
                                from: 500,
                                child: Text(
                                  AppStrings.signinScreenDescription,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.labelMedium!
                                      .copyWith(
                                          color:
                                              AppColors.primaryColorShade200),
                                ),
                              ),
                              const Spacer(),
                              Obx(
                                () => (signinController
                                            .isContinueButtonLoading.value ||
                                        initializationController
                                            .isCurrentUserLoading.value)
                                    ? ButtonLoader(width: Get.width * 0.8)
                                    : SlideInUp(
                                        child: CustomButton(
                                          width: Get.width * 0.8,
                                          height: 48.h,
                                          text: AppStrings
                                              .signinApplockScreenContinueButton,
                                          marginBottom: 20.h,
                                          hasIcon: true,
                                          icon: const Icon(
                                            FlutterRemix.google_fill,
                                          ),
                                          onPressed: () async {
                                            try {
                                              signinController
                                                  .isContinueButtonLoading
                                                  .value = true;
                                              final result = await AuthServices
                                                  .continueWithGoogle();
                                              if (result != null) {
                                              } else {
                                                signinController
                                                    .isContinueButtonLoading
                                                    .value = false;
                                                await EasyLoading.showToast(
                                                  'Google sign-in failed. Please try again',
                                                  toastPosition:
                                                      EasyLoadingToastPosition
                                                          .top,
                                                );
                                              }
                                            } catch (e) {
                                              signinController
                                                  .isContinueButtonLoading
                                                  .value = false;
                                              await EasyLoading.showToast(
                                                'An unexpected error occurred. Please try again later.',
                                                toastPosition:
                                                    EasyLoadingToastPosition
                                                        .top,
                                              );
                                            }
                                            // supabase.auth.currentUser == null
                                            //     ? signinController
                                            //         .isContinueButtonLoading
                                            //         .value = false
                                            //     : null;
                                          },
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
    // );
  }
}
