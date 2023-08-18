import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/controllers/settings_controller.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/services/user_services.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class DeleteAccountDialog extends StatelessWidget {
  DeleteAccountDialog({super.key});

  final SettingsController settingsController = Get.find();
  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        GestureDetector(
          onTap: () {
            settingsController.clearTextFieldsDelete();
            Get.back();
          },
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              height: Get.height * 0.55,
              color: AppColors.customDarkColor,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: Form(
                key: settingsController.formKeyDelete,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.settingsScreenDeleteAccountTitle,
                              style:
                                  context.theme.textTheme.labelMedium!.copyWith(
                                color: AppColors.primaryColorShade200,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                settingsController.clearTextFieldsDelete();
                                Get.back();
                              },
                              child: const Icon(
                                FlutterRemix.close_line,
                                color: AppColors.primaryColorShade200,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Icon(
                          FlutterRemix.delete_bin_2_line,
                          size: Get.width * 0.2,
                          color: AppColors.primaryColorShade200,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          AppStrings.settingsScreenDeleteAccountHeadline,
                          style:
                              context.theme.textTheme.headlineSmall!.copyWith(
                            color: AppColors.primaryColorShade200,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            AppStrings.settingsScreenDeleteAccountDescription,
                            textAlign: TextAlign.center,
                            style: context.theme.textTheme.labelSmall!.copyWith(
                              color: AppColors.primaryColorShade300,
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        SizedBox(
                          width: Get.width * 0.9,
                          child: CustomTextField(
                            hintText: AppStrings
                                .settingsScreenEnterMasterPasswordHint,
                            controller: settingsController
                                .currentPasswordControllerDelete,
                            focusNode: settingsController
                                .currentPasswordFocusNodeDelete,
                            keyboardType: TextInputType.text,
                            isPasswordVisible: false.obs,
                            hasFocus: false.obs,
                            prefixIcon: FlutterRemix.lock_password_line,
                            isPassword: true,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppStrings
                                    .setupApplockScreenPasswordIsRequired;
                              } else {
                                final hashedPassword =
                                    encryptionServices.hashMasterPassword(
                                  value,
                                  initializationController
                                      .currentUser.value!.salt,
                                );
                                if (hashedPassword !=
                                    initializationController
                                        .currentUser.value!.masterPassword) {
                                  settingsController
                                      .currentPasswordFocusNodeDelete
                                      .requestFocus();
                                  return AppStrings
                                      .settingsScreenInvalidCurrentPassword;
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      width: Get.width * 0.8,
                      text: 'Delete Account',
                      color: AppColors.shadeDanger,
                      onPressed: () async {
                        await EasyLoading.show(status: "Verifying...");
                        final isValid = settingsController
                            .formKeyDelete.currentState!
                            .validate();
                        await EasyLoading.dismiss();
                        if (isValid) {
                          await EasyLoading.show(status: "Deleting account...");
                          Get.back();
                          await EasyLoading.show(
                            status: AppStrings.settingsScreenDeletingAccount,
                          );
                          await UserServices.deleteUserData(
                            controller: initializationController,
                          );
                          settingsController.clearTextFieldsDelete();
                          await EasyLoading.showToast(
                            AppStrings.settingsScreenAccountDeleted,
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
