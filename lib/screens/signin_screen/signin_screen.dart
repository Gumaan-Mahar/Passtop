import 'package:passtop/controllers/signin_controller.dart';
import 'package:passtop/core/constants.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/core/resources/assets_manager/assets_manager.dart';
import 'package:passtop/main.dart';
import 'package:passtop/screens/app_lock_screen/app_lock_screen.dart';
import 'package:passtop/screens/set_up_applock_screen/set_up_applock_screen.dart';
import 'package:passtop/services/auth_services.dart';
import 'package:passtop/widgets/button_loader.dart';
import 'package:passtop/widgets/custom_button.dart';

import '../../core/imports/core_imports.dart';


class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final SigninController _signinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => currentUser.value.id != null
          ? currentUser.value.appLockPassword == null
              ? SetupAppLockScreen()
              : AppLockScreen()
          : Scaffold(
              body: Padding(
                padding: kHorizontalPadding,
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
                        child:
                            SvgPicture.asset(AssetsManager.signinIllustration),
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
                                        color: AppColors.primaryColorShade200),
                              ),
                            ),
                            const Spacer(),
                            Obx(
                              () => (_signinController
                                          .isContinueButtonLoading.value ||
                                      isCurrentUserLoading.value)
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
                                          _signinController
                                              .isContinueButtonLoading
                                              .value = true;
                                          await AuthServices.continueWithGoogle(
                                              context: context);
                                          supabase.auth.currentUser == null
                                              ? _signinController
                                                  .isContinueButtonLoading
                                                  .value = false
                                              : null;
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
    );
  }
}
