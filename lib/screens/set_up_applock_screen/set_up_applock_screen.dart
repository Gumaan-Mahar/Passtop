import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/controllers/setup_applock_controller.dart';
import 'package:passtop/controllers/signin_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/core/resources/assets_manager/assets_manager.dart';
import 'package:passtop/screens/main_screen/main_screen.dart';
import 'package:passtop/services/user_services.dart';
import 'package:passtop/widgets/custom_button.dart';
import 'package:passtop/widgets/custom_circle_avatar.dart';

import '../../core/imports/core_imports.dart';
import '../../methods/validate_master_password.dart';
import '../../widgets/custom_textfield.dart';

class SetupAppLockScreen extends StatelessWidget {
  SetupAppLockScreen({super.key});

  final SetupAppLockController _setupAppLockController =
      Get.put(SetupAppLockController());

  final SigninController _signinController = Get.find();

  final InitializationController _initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    _signinController.isContinueButtonLoading.value = false;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.customDarkColor,
        systemNavigationBarColor: AppColors.customDarkColor,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.04,
                  horizontal: 8.w,
                ),
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
                      CustomCircleAvatar(
                        profileUrl: _initializationController
                            .currentUser.value!.imageUrl,
                        width: Get.width * 0.3,
                        height: Get.height * 0.15,
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomTextField(
                          hintText:
                              AppStrings.setupApplockScreenPasswordHintText,
                          controller:
                              _setupAppLockController.passwordController,
                          focusNode: _setupAppLockController.passwordFocusNode,
                          keyboardType: TextInputType.name,
                          isPasswordVisible: false.obs,
                          isPassword: true,
                          hasFocus: false.obs,
                          prefixIcon: FlutterRemix.lock_password_line,
                          validator: (String? value) {
                            return validateMasterPassword(
                              value,
                              _setupAppLockController.passwordFocusNode,
                            );
                          }),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                        hintText: AppStrings
                            .setupApplockScreenConfirmPasswordHintText,
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
                      CustomButton(
                        width: Get.width * 0.8,
                        marginBottom: 8.h,
                        text: AppStrings.setupApplockScreenContinueButton,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_setupAppLockController.formKey.currentState!
                              .validate()) {
                            try {
                              await EasyLoading.show(status: 'Saving...');
                              final salt = encryptionServices
                                  .generateRandomSalt(length: 32);
                              final hashedMasterPassword =
                                  encryptionServices.hashMasterPassword(
                                _setupAppLockController.passwordController.text,
                                salt,
                              );
                              final encryptionKey =
                                  encryptionServices.deriveEncryptionKey(
                                hashedMasterPassword,
                                salt,
                              );
                              await UserServices.updateUser(data: {
                                'master_password': hashedMasterPassword,
                                'salt': salt,
                              }).then((value) async {
                                _initializationController
                                    .currentUser.value!.salt = salt;
                                _initializationController.currentUser.value!
                                    .masterPassword = hashedMasterPassword;
                                _initializationController.encryptionKey.value =
                                    encryptionKey;
                                await EasyLoading.dismiss();
                                await Get.to(() => MainScreen());
                                _setupAppLockController.passwordController
                                    .clear();
                                _setupAppLockController
                                    .confirmPasswordController
                                    .clear();
                              }).catchError((e) {
                                log(e.toString());
                                EasyLoading.showError(
                                  AppStrings
                                      .setupApplockScreenErrorUpdatingMasterPassword,
                                  duration: const Duration(seconds: 5),
                                );
                              });
                            } catch (e) {
                              log(e.toString());
                              await EasyLoading.showError(
                                AppStrings.setupApplockScreenGeneralError,
                                duration: const Duration(
                                  seconds: 5,
                                ),
                              );
                            }
                          }
                        },
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
