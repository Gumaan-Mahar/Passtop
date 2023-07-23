import 'dart:developer';

import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/controllers/settings_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/methods/validate_master_password.dart';
import 'package:passtop/services/user_services.dart';
import 'package:passtop/widgets/custom_button.dart';
import 'package:passtop/widgets/custom_textfield.dart';

import '../../../core/imports/core_imports.dart';

class ChangeMasterPasswordDialog extends StatelessWidget {
  ChangeMasterPasswordDialog({super.key});

  final SettingsController settingsController = Get.find();
  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    log('crrnt usr: ${initializationController.currentUser.value!.username}');
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        GestureDetector(
          onTap: () {
            settingsController.clearTextFields();
            Get.back();
          },
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              width: Get.width,
              height: Get.height * 0.55,
              color: AppColors.customDarkColor,
              padding: EdgeInsets.all(
                8.w,
              ),
              child: Form(
                key: settingsController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings
                                  .settingsScreenChangeMasterPasswordTitle,
                              style:
                                  context.theme.textTheme.labelMedium!.copyWith(
                                color: AppColors.primaryColorShade200,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                settingsController.clearTextFields();
                                Get.back();
                              },
                              child: const Icon(
                                FlutterRemix.close_line,
                                color: AppColors.primaryColorShade200,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextField(
                          hintText:
                              AppStrings.settingsScreenCurrentPasswordHint,
                          controller:
                              settingsController.currentPasswordController,
                          focusNode:
                              settingsController.currentPasswordFocusNode,
                          keyboardType: TextInputType.text,
                          isPasswordVisible: false.obs,
                          hasFocus: false.obs,
                          prefixIcon: FlutterRemix.lock_password_line,
                          isPassword: true,
                          validator: (String? value) {
                            if (value !=
                                initializationController
                                    .currentUser.value!.appLockPassword) {
                              settingsController.currentPasswordFocusNode
                                  .requestFocus();
                              return AppStrings
                                  .settingsScreenInvalidCurrentPassword;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextField(
                          hintText: AppStrings.settingsScreenNewPasswordHint,
                          controller: settingsController.newPasswordController,
                          focusNode: settingsController.newPasswordFocusNode,
                          keyboardType: TextInputType.text,
                          isPasswordVisible: false.obs,
                          hasFocus: false.obs,
                          prefixIcon: FlutterRemix.lock_password_line,
                          isPassword: true,
                          validator: (String? value) => validateMasterPassword(
                            value,
                            settingsController.newPasswordFocusNode,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextField(
                          hintText:
                              AppStrings.settingsScreenConfirmNewPasswordHint,
                          controller:
                              settingsController.confirmNewPasswordController,
                          focusNode:
                              settingsController.confirmNewPasswordFocusNode,
                          keyboardType: TextInputType.text,
                          isPasswordVisible: false.obs,
                          hasFocus: false.obs,
                          prefixIcon: FlutterRemix.lock_password_line,
                          isPassword: true,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              settingsController.confirmNewPasswordFocusNode
                                  .requestFocus();
                            }
                            if (value.isEmpty) {
                              return AppStrings
                                  .setupApplockScreenConfirmPasswordBeforeYouContinue;
                            } else if (value.trim() !=
                                settingsController.newPasswordController.text
                                    .trim()) {
                              return AppStrings
                                  .setupApplockScreenPasswordsDontMatch;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    CustomButton(
                      width: Get.width * 0.8,
                      text: 'Save Changes',
                      onPressed: () async {
                        if (settingsController.formKey.currentState!
                            .validate()) {
                          await EasyLoading.show(status: 'Saving Changes');
                          await UserServices.updateUser(
                            data: {
                              'app_lock_password': settingsController
                                  .confirmNewPasswordController.text
                                  .trim(),
                            },
                          );
                          settingsController.clearTextFields();
                          await EasyLoading.dismiss();
                          Get.back();
                          await EasyLoading.showToast(
                            AppStrings
                                .settingsScreenPasswordSuccessfullyChanged,
                            duration: const Duration(seconds: 3),
                            toastPosition: EasyLoadingToastPosition.top,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
