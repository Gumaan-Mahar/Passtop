import 'package:passtop/controllers/setup_applock_controller.dart';
import 'package:passtop/controllers/signin_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/resources/assets_manager/assets_manager.dart';
import 'package:passtop/main.dart';
import 'package:passtop/screens/main_screen/main_screen.dart';
import 'package:passtop/services/user_services.dart';
import 'package:passtop/widgets/button_loader.dart';
import 'package:passtop/widgets/custom_button.dart';
import 'package:passtop/widgets/custom_circle_avatar.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants.dart';
import '../../core/imports/core_imports.dart';
import '../../widgets/custom_textfield.dart';

class SetupAppLockScreen extends StatelessWidget {
  SetupAppLockScreen({super.key});

  final SetupAppLockController _setupAppLockController =
      Get.put(SetupAppLockController());

  final SigninController _signinController = Get.find();

  @override
  Widget build(BuildContext context) {
    _signinController.isContinueButtonLoading.value = false;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: kHorizontalPadding,
                child: Form(
                  key: _setupAppLockController.formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      SvgPicture.asset(
                        AssetsManager.appLogoSVG,
                      ),
                      SizedBox(
                        height: Get.height * 0.16,
                      ),
                      Obx(
                        () => currentUser.value.imageUrl != null
                            ? CustomCircleAvatar(
                                profileUrl: currentUser.value.imageUrl!,
                                width: Get.width * 0.3,
                                height: Get.height * 0.15,
                              )
                            : Shimmer.fromColors(
                                baseColor: AppColors.shadeDark,
                                highlightColor: AppColors.customDarkColor,
                                child: Container(
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.15,
                                  decoration: const BoxDecoration(
                                      color: AppColors.primaryColorShade50,
                                      shape: BoxShape.circle),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomTextField(
                        hintText: AppStrings.setupApplockScreenPasswordHintText,
                        controller: _setupAppLockController.passwordController,
                        focusNode: _setupAppLockController.passwordFocusNode,
                        keyboardType: TextInputType.name,
                        isPasswordVisible: false.obs,
                        isPassword: true,
                        hasFocus: false.obs,
                        prefixIcon: FlutterRemix.lock_password_line,
                        validator: (String? value) {
                          if (_setupAppLockController
                              .confirmPasswordController.text
                              .trim()
                              .isEmpty) {
                            _setupAppLockController.confirmPasswordFocusNode
                                .requestFocus();
                          }
                          if (value!.isEmpty) {
                            return AppStrings
                                .setupApplockScreenPasswordIsRequired;
                          } else if (value.length < 8) {
                            return AppStrings
                                .setupApplockScreenPasswordIsTooShort;
                          } else if (value.length > 16) {
                            return AppStrings.setupApplockScreenPasswordIsTooLong;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                        hintText:
                            AppStrings.setupApplockScreenConfirmPasswordHintText,
                        controller:
                            _setupAppLockController.confirmPasswordController,
                        focusNode:
                            _setupAppLockController.confirmPasswordFocusNode,
                        keyboardType: TextInputType.name,
                        isPasswordVisible: false.obs,
                        isPassword: true,
                        prefixIcon: FlutterRemix.lock_password_line,
                        validator: (String? value) {
                          if (_setupAppLockController.passwordController.text
                              .trim()
                              .isEmpty) {
                            _setupAppLockController.passwordFocusNode
                                .requestFocus();
                          }
                          if (value!.isEmpty) {
                            return AppStrings
                                .setupApplockScreenConfirmPasswordBeforeYouContinue;
                          } else if (value.trim() !=
                              _setupAppLockController.passwordController.text
                                  .trim()) {
                            return AppStrings
                                .setupApplockScreenPasswordsDontMatch;
                          }
                          return null;
                        },
                        hasFocus: true.obs,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const Spacer(),
                      Obx(
                        () => _setupAppLockController
                                    .isContinueButtonLoading.value ==
                                false
                            ? CustomButton(
                                width: Get.width * 0.8,
                                marginBottom: 8.h,
                                text: AppStrings.setupApplockScreenContinueButton,
                                onPressed: () async {
                                  if (_setupAppLockController
                                      .formKey.currentState!
                                      .validate()) {
                                    _setupAppLockController
                                        .isContinueButtonLoading.value = true;
                                    await UserServices.updateUser(
                                      data: {
                                        'app_lock_password':
                                            _setupAppLockController
                                                .passwordController.text
                                                .trim(),
                                      },
                                    );
                                    _setupAppLockController.passwordController.clear();
                                    _setupAppLockController.confirmPasswordController.clear();
                                    Get.to(() => MainScreen());
                                    _setupAppLockController
                                        .isContinueButtonLoading.value = false;
                                  }
                                },
                              )
                            : ButtonLoader(width: Get.width * 0.8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
