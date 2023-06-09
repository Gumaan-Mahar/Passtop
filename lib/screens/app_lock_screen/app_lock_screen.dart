import 'package:flutter/services.dart';
import 'package:passtop/controllers/applock_controller.dart';
import 'package:passtop/controllers/signin_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/core/resources/assets_manager/assets_manager.dart';
import 'package:passtop/main.dart';
import 'package:passtop/screens/main_screen/main_screen.dart';
import 'package:passtop/widgets/button_loader.dart';
import 'package:passtop/widgets/custom_button.dart';
import 'package:passtop/widgets/custom_circle_avatar.dart';

import '../../core/constants.dart';
import '../../core/imports/core_imports.dart';
import '../../widgets/custom_textfield.dart';

class AppLockScreen extends StatelessWidget {
  AppLockScreen({super.key});

  final AppLockController _appLockController = Get.find();
  final SigninController _signinController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
        statusBarColor: context.theme.scaffoldBackgroundColor,
      ),
    );
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
                        profileUrl: currentUser.value.imageUrl!,
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomTextField(
                        hintText: AppStrings.setupApplockScreenPasswordHintText,
                        controller: _appLockController.passwordController,
                        focusNode: _appLockController.passwordFocusNode,
                        keyboardType: TextInputType.name,
                        isPasswordVisible: false.obs,
                        hasFocus: false.obs,
                        isPassword: true,
                        prefixIcon: FlutterRemix.lock_password_line,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter password before you continue';
                          } else if (_appLockController
                                  .passwordController.text !=
                              currentUser.value.appLockPassword) {
                            return 'Password is invalid. Try again!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const Spacer(),
                      Obx(
                        () => _appLockController.isContinueButtonLoading.value
                            ? ButtonLoader(width: Get.width * 0.8)
                            : CustomButton(
                                width: Get.width * 0.8,
                                marginBottom: 8.h,
                                text:
                                    AppStrings.setupApplockScreenContinueButton,
                                onPressed: () async {
                                  if (_appLockController.formKey.currentState!
                                      .validate()) {
                                    _appLockController
                                        .isContinueButtonLoading.value = true;
                                    _appLockController.passwordController
                                        .clear();
                                    Get.to(
                                      () => MainScreen(),
                                    );
                                    _appLockController
                                        .isContinueButtonLoading.value = false;
                                  }
                                },
                              ),
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
