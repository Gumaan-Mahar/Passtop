import 'package:flutter/services.dart';
import 'package:passtop/controllers/applock_controller.dart';
import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/controllers/signin_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/core/resources/assets_manager/assets_manager.dart';
import 'package:passtop/screens/main_screen/main_screen.dart';
import 'package:passtop/widgets/custom_button.dart';
import 'package:passtop/widgets/custom_circle_avatar.dart';

import '../../core/imports/core_imports.dart';
import '../../widgets/custom_textfield.dart';

class AppLockScreen extends StatelessWidget {
  AppLockScreen({Key? key}) : super(key: key);

  final AppLockController _appLockController = Get.find();

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
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.04, horizontal: 8.w,),
                child: Form(
                  key: _appLockController.formKey,
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
                        width: Get.width * 0.3,
                        height: Get.height * 0.15,
                        profileUrl: _initializationController
                            .currentUser.value!.imageUrl,
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomTextField(
                        hintText: AppStrings.setupApplockScreenPasswordHintText,
                        controller: _appLockController.passwordController,
                        focusNode: _appLockController.passwordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        isPasswordVisible: false.obs,
                        hasFocus: false.obs,
                        isPassword: true,
                        prefixIcon: FlutterRemix.lock_password_line,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter password before you continue';
                          } else {
                            final salt = _initializationController
                                .currentUser.value!.salt;
                            final hashedEnteredPassword = encryptionServices
                                .hashMasterPassword(value, salt);
                            final hashedStoredPassword =
                                _initializationController
                                    .currentUser.value!.masterPassword;
                            if (hashedEnteredPassword != hashedStoredPassword) {
                              return 'Invalid Password. Try again.';
                            }
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const Spacer(),
                      CustomButton(
                        width: Get.width * 0.8,
                        marginBottom: 8.h,
                        text: AppStrings.setupApplockScreenContinueButton,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await EasyLoading.show(status: "Verifying...");
                          final bool isValid = _appLockController
                              .formKey.currentState!
                              .validate();
                          await EasyLoading.dismiss();
                          if (isValid) {
                            try {
                              await EasyLoading.show(status: 'Signing in...');
                              final salt = _initializationController
                                  .currentUser.value!.salt;
                              final hashedMasterPassword =
                                  encryptionServices.hashMasterPassword(
                                _appLockController.passwordController.text,
                                salt,
                              );
                              final encryptionKey =
                                  encryptionServices.deriveEncryptionKey(
                                hashedMasterPassword,
                                salt,
                              );
                              _initializationController.encryptionKey.value =
                                  encryptionKey;
                              _appLockController.passwordController.clear();
                              await EasyLoading.dismiss();
                              Get.to(
                                () => MainScreen(),
                              );
                            } catch (e) {
                              await EasyLoading.showError(
                                  "Something went wrong. Try again.");
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
