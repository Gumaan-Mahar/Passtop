import 'package:passtop/controllers/home_controller.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';
import '../../../methods/password_field_validator.dart';
import '../../../methods/text_field_validator.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_area.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/expiry_month_drop_down.dart';
import '../../../widgets/expiry_year_drop_down.dart';

class NewPasswordForm extends StatelessWidget {
  NewPasswordForm({
    super.key,
  });

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.homeScreenCreateNewPassword,
              style: context.theme.textTheme.labelLarge,
            ),
            IconButton(
              onPressed: () {
                homeController.clearTextFields();
                homeController.newPasswordSelectedCategory.value =
                    homeController.categories[0];
              },
              icon: const Icon(
                FlutterRemix.close_line,
                color: AppColors.primaryColorShade50,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.homeScreenSelectCategory,
              style: context.theme.textTheme.labelMedium!.copyWith(
                color: AppColors.primaryColorShade300,
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField<String>(
              dropdownColor: AppColors.secondaryColor,
              value: homeController.newPasswordSelectedCategory.value,
              iconEnabledColor: AppColors.primaryColor,
              items: homeController.categories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (selectedVal) => homeController
                  .newPasswordSelectedCategory.value = selectedVal!,
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Obx(
          () => homeController.newPasswordSelectedCategory.value ==
                  homeController.categories[5]
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Obx(
                      () => homeController.newPasswordSelectedCategory.value ==
                              homeController.categories[0]
                          ? CustomTextField(
                              hintText: AppStrings.homeScreenAppName,
                              controller:
                                  homeController.newPasswordAppNameController,
                              focusNode: homeController.newPasswordAppNameFocus,
                              keyboardType: TextInputType.text,
                              isPasswordVisible: true.obs,
                              isPassword: false,
                              hasFocus: homeController
                                  .newPasswordAppNameFocus.hasFocus.obs,
                              prefixIcon: FlutterRemix.apps_line,
                              validator: (value) => validateTextField(
                                value: homeController
                                    .newPasswordAppNameController.text,
                                focusNode:
                                    homeController.newPasswordAppNameFocus,
                              ),
                            )
                          : homeController.newPasswordSelectedCategory.value ==
                                  homeController.categories[1]
                              ? CustomTextField(
                                  hintText: AppStrings.homeScreenWebsiteUrl,
                                  controller: homeController
                                      .newPasswordWebsiteUrlController,
                                  focusNode:
                                      homeController.newPasswordWebsiteUrlFocus,
                                  keyboardType: TextInputType.text,
                                  isPasswordVisible: true.obs,
                                  isPassword: false,
                                  hasFocus: homeController
                                      .newPasswordWebsiteUrlFocus.hasFocus.obs,
                                  prefixIcon: FlutterRemix.global_line,
                                  validator: (value) => validateTextField(
                                    value: homeController
                                        .newPasswordWebsiteUrlController.text,
                                    focusNode: homeController
                                        .newPasswordWebsiteUrlFocus,
                                  ),
                                )
                              : homeController
                                          .newPasswordSelectedCategory.value ==
                                      homeController.categories[2]
                                  ? CustomTextField(
                                      maxLength: 22,
                                      hintText: AppStrings.homeScreenCardNumber,
                                      controller: homeController
                                          .newPasswordCardNumberController,
                                      focusNode: homeController
                                          .newPasswordCardNumberFocus,
                                      keyboardType: TextInputType.phone,
                                      isPasswordVisible: true.obs,
                                      isPassword: false,
                                      hasFocus: homeController
                                          .newPasswordCardNumberFocus
                                          .hasFocus
                                          .obs,
                                      prefixIcon: FlutterRemix.bank_card_line,
                                      validator: (value) => validateTextField(
                                        value: homeController
                                            .newPasswordCardNumberController
                                            .text,
                                        focusNode: homeController
                                            .newPasswordCardNumberFocus,
                                      ),
                                    )
                                  : homeController.newPasswordSelectedCategory
                                              .value ==
                                          homeController.categories[4]
                                      ? CustomTextField(
                                          hintText:
                                              AppStrings.homeScreenAddressName,
                                          controller: homeController
                                              .newPasswordAddressNameController,
                                          focusNode: homeController
                                              .newPasswordAddressNameFocus,
                                          keyboardType: TextInputType.text,
                                          isPasswordVisible: true.obs,
                                          isPassword: false,
                                          hasFocus: homeController
                                              .newPasswordAddressNameFocus
                                              .hasFocus
                                              .obs,
                                          prefixIcon: FlutterRemix.text,
                                          validator: (value) =>
                                              validateTextField(
                                            value: homeController
                                                .newPasswordAddressNameController
                                                .text,
                                            focusNode: homeController
                                                .newPasswordAddressNameFocus,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Obx(
                      () => homeController.newPasswordSelectedCategory.value ==
                              homeController.categories[2]
                          ? CustomTextField(
                              hintText: AppStrings.homeScreenNameOnCard,
                              controller: homeController
                                  .newPasswordNameOnCardController,
                              focusNode:
                                  homeController.newPasswordNameOnCardFocus,
                              keyboardType: TextInputType.text,
                              isPasswordVisible: true.obs,
                              isPassword: false,
                              hasFocus: homeController
                                  .newPasswordNameOnCardFocus.hasFocus.obs,
                              prefixIcon: FlutterRemix.text,
                              validator: (value) => validateTextField(
                                value: homeController
                                    .newPasswordNameOnCardController.text,
                                focusNode:
                                    homeController.newPasswordNameOnCardFocus,
                              ),
                            )
                          : homeController.newPasswordSelectedCategory.value ==
                                  homeController.categories[3]
                              ? Column(
                                  children: [
                                    CustomTextField(
                                      hintText: AppStrings.homeScreenFirstName,
                                      controller: homeController
                                          .newPasswordFirstNameController,
                                      focusNode: homeController
                                          .newPasswordFirstNameFocus,
                                      keyboardType: TextInputType.text,
                                      isPasswordVisible: true.obs,
                                      isPassword: false,
                                      hasFocus: homeController
                                          .newPasswordFirstNameFocus
                                          .hasFocus
                                          .obs,
                                      prefixIcon: FlutterRemix.text,
                                      validator: (value) => validateTextField(
                                        value: homeController
                                            .newPasswordFirstNameController
                                            .text,
                                        focusNode: homeController
                                            .newPasswordFirstNameFocus,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    CustomTextField(
                                      hintText: AppStrings.homeScreenLastName,
                                      controller: homeController
                                          .newPasswordLastNameController,
                                      focusNode: homeController
                                          .newPasswordLastNameFocus,
                                      keyboardType: TextInputType.text,
                                      isPasswordVisible: true.obs,
                                      isPassword: false,
                                      hasFocus: homeController
                                          .newPasswordLastNameFocus
                                          .hasFocus
                                          .obs,
                                      prefixIcon: FlutterRemix.text,
                                      validator: (value) => validateTextField(
                                        value: homeController
                                            .newPasswordLastNameController.text,
                                        focusNode: homeController
                                            .newPasswordLastNameFocus,
                                      ),
                                    ),
                                  ],
                                )
                              : homeController
                                          .newPasswordSelectedCategory.value ==
                                      homeController.categories[4]
                                  ? CustomTextField(
                                      hintText: AppStrings
                                          .homeScreenAddressOrganization,
                                      controller: homeController
                                          .newPasswordAddressOrganisationController,
                                      focusNode: homeController
                                          .newPasswordAddressOrganisationFocus,
                                      keyboardType: TextInputType.text,
                                      isPasswordVisible: true.obs,
                                      isPassword: false,
                                      hasFocus: homeController
                                          .newPasswordAddressOrganisationFocus
                                          .hasFocus
                                          .obs,
                                      prefixIcon: FlutterRemix.community_line,
                                      validator: (value) => validateTextField(
                                        value: homeController
                                            .newPasswordAddressOrganisationController
                                            .text,
                                        focusNode: homeController
                                            .newPasswordAddressOrganisationFocus,
                                      ),
                                    )
                                  : CustomTextField(
                                      hintText: AppStrings.homeScreenUsername,
                                      controller: homeController
                                          .newPasswordUsernameController,
                                      focusNode: homeController
                                          .newPasswordUsernameFocus,
                                      keyboardType: TextInputType.text,
                                      isPasswordVisible: true.obs,
                                      isPassword: false,
                                      hasFocus: homeController
                                          .newPasswordUsernameFocus
                                          .hasFocus
                                          .obs,
                                      prefixIcon: FlutterRemix.text,
                                      validator: (value) => validateTextField(
                                        value: homeController
                                            .newPasswordUsernameController.text,
                                        focusNode: homeController
                                            .newPasswordUsernameFocus,
                                      ),
                                    ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Obx(
                      () => homeController.newPasswordSelectedCategory.value ==
                              homeController.categories[2]
                          ? Row(
                              children: [
                                Expanded(
                                  child: ExpiryMonthDropDown(
                                    onChanged: (selectedVal) => homeController
                                        .newPasswordExpiryMonth
                                        .value = selectedVal!,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: ExpiryYearDropDown(
                                    onChanged: (selectedVal) => homeController
                                        .newPasswordExpiryYear
                                        .value = selectedVal!,
                                  ),
                                ),
                              ],
                            )
                          : homeController.newPasswordSelectedCategory.value ==
                                  homeController.categories[3]
                              ? CustomTextField(
                                  hintText: AppStrings.homeScreenIdentityNumber,
                                  controller: homeController
                                      .newPasswordIdentityNumberController,
                                  focusNode: homeController
                                      .newPasswordIdentityNumberFocus,
                                  keyboardType: TextInputType.phone,
                                  isPasswordVisible: true.obs,
                                  isPassword: false,
                                  hasFocus: false.obs,
                                  prefixIcon: FlutterRemix.profile_line,
                                  validator: (value) => validateTextField(
                                    value: homeController
                                        .newPasswordIdentityNumberController
                                        .text,
                                    focusNode: homeController
                                        .newPasswordIdentityNumberFocus,
                                  ),
                                )
                              : homeController
                                          .newPasswordSelectedCategory.value ==
                                      homeController.categories[4]
                                  ? CustomTextField(
                                      hintText:
                                          AppStrings.homeScreenAddressPhone,
                                      controller: homeController
                                          .newPasswordAddressPhoneController,
                                      focusNode: homeController
                                          .newPasswordAddressPhoneFocus,
                                      keyboardType: TextInputType.phone,
                                      isPasswordVisible: true.obs,
                                      isPassword: false,
                                      hasFocus: homeController
                                          .newPasswordAddressPhoneFocus
                                          .hasFocus
                                          .obs,
                                      prefixIcon: FlutterRemix.phone_line,
                                      validator: (value) => validateTextField(
                                        value: homeController
                                            .newPasswordAddressPhoneController
                                            .text,
                                        focusNode: homeController
                                            .newPasswordAddressPhoneFocus,
                                      ),
                                    )
                                  : CustomTextField(
                                      hintText: AppStrings.homeScreenPassword,
                                      controller: homeController
                                          .newPasswordPasswordController,
                                      focusNode: homeController
                                          .newPasswordPasswordFocus,
                                      keyboardType: TextInputType.text,
                                      isPasswordVisible: false.obs,
                                      isPassword: true,
                                      hasFocus: false.obs,
                                      prefixIcon:
                                          FlutterRemix.lock_password_line,
                                      validator: (value) => validatePassword(
                                        value: value,
                                        focusNode: homeController
                                            .newPasswordPasswordFocus,
                                      ),
                                    ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Obx(
                      () => homeController.newPasswordSelectedCategory.value ==
                              homeController.categories[2]
                          ? CustomTextField(
                              hintText: AppStrings.homeScreenNickname,
                              controller:
                                  homeController.newPasswordNicknameController,
                              focusNode:
                                  homeController.newPasswordNicknameFocus,
                              keyboardType: TextInputType.text,
                              isPasswordVisible: true.obs,
                              isPassword: false,
                              hasFocus: false.obs,
                              prefixIcon: FlutterRemix.text,
                              validator: (value) => validateTextField(
                                value: homeController
                                    .newPasswordNicknameController.text,
                                focusNode:
                                    homeController.newPasswordNicknameFocus,
                              ),
                            )
                          : homeController.newPasswordSelectedCategory.value ==
                                  homeController.categories[4]
                              ? CustomTextField(
                                  hintText: AppStrings.homeScreenAddressEmail,
                                  controller: homeController
                                      .newPasswordAddressEmailController,
                                  focusNode: homeController
                                      .newPasswordAddressEmailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  isPasswordVisible: true.obs,
                                  isPassword: false,
                                  hasFocus: homeController
                                      .newPasswordAddressEmailFocus
                                      .hasFocus
                                      .obs,
                                  prefixIcon: FlutterRemix.mail_line,
                                  validator: (value) => validateTextField(
                                    value: homeController
                                        .newPasswordAddressEmailController.text,
                                    focusNode: homeController
                                        .newPasswordAddressEmailFocus,
                                  ),
                                )
                              : const SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    homeController.newPasswordSelectedCategory.value ==
                            homeController.categories[4]
                        ? Column(
                            children: [
                              CustomTextField(
                                hintText: AppStrings.homeScreenAddressRegion,
                                controller: homeController
                                    .newPasswordAddressRegionController,
                                focusNode: homeController
                                    .newPasswordAddressRegionFocus,
                                keyboardType: TextInputType.text,
                                isPasswordVisible: true.obs,
                                isPassword: false,
                                hasFocus: homeController
                                    .newPasswordAddressRegionFocus.hasFocus.obs,
                                prefixIcon: FlutterRemix.map_pin_line,
                                validator: (value) => validateTextField(
                                  value: homeController
                                      .newPasswordAddressRegionController.text,
                                  focusNode: homeController
                                      .newPasswordAddressRegionFocus,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextField(
                                maxLength: 50,
                                hintText:
                                    AppStrings.homeScreenAddressStreetAddress,
                                controller: homeController
                                    .newPasswordAddressStreetAddressController,
                                focusNode: homeController
                                    .newPasswordAddressStreetAddressFocus,
                                keyboardType: TextInputType.text,
                                isPasswordVisible: true.obs,
                                isPassword: false,
                                hasFocus: homeController
                                    .newPasswordAddressStreetAddressFocus
                                    .hasFocus
                                    .obs,
                                prefixIcon: FlutterRemix.map_pin_user_line,
                                validator: (value) => validateTextField(
                                  value: homeController
                                      .newPasswordAddressStreetAddressController
                                      .text,
                                  focusNode: homeController
                                      .newPasswordAddressStreetAddressFocus,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextField(
                                hintText: AppStrings.homeScreenAddressCity,
                                controller: homeController
                                    .newPasswordAddressCityController,
                                focusNode:
                                    homeController.newPasswordAddressCityFocus,
                                keyboardType: TextInputType.text,
                                isPasswordVisible: true.obs,
                                isPassword: false,
                                hasFocus: homeController
                                    .newPasswordAddressCityFocus.hasFocus.obs,
                                prefixIcon: FlutterRemix.building_line,
                                validator: (value) => validateTextField(
                                  value: homeController
                                      .newPasswordAddressCityController.text,
                                  focusNode: homeController
                                      .newPasswordAddressCityFocus,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextField(
                                hintText:
                                    AppStrings.homeScreenAddressPostalCode,
                                controller: homeController
                                    .newPasswordAddressPostalCodeController,
                                focusNode: homeController
                                    .newPasswordAddressPostalCodeFocus,
                                keyboardType: TextInputType.text,
                                isPasswordVisible: true.obs,
                                isPassword: false,
                                hasFocus: homeController
                                    .newPasswordAddressPostalCodeFocus
                                    .hasFocus
                                    .obs,
                                prefixIcon: FlutterRemix.mail_line,
                                validator: (value) => validateTextField(
                                  value: homeController
                                      .newPasswordAddressPostalCodeController
                                      .text,
                                  focusNode: homeController
                                      .newPasswordAddressPostalCodeFocus,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Obx(
          () => homeController.newPasswordSelectedCategory.value ==
                  homeController.categories[5]
              ? CustomTextArea(
                  maxLines: 12,
                  maxLength: 500,
                  controller: homeController.newPasswordGeneralTextController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.homeScreenThisFieldIsRequired;
                    }
                    return null;
                  },
                )
              : CustomTextArea(
                  controller: homeController.newPasswordNotesController,
                ),
        ),
        const Spacer(),
        SizedBox(
          height: 16.h,
        ),
        CustomButton(
          width: Get.width * 0.8,
          marginBottom: 8.h,
          text: AppStrings.homeScreenContinueButton,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (homeController.formKey.currentState!.validate()) {
              await homeController.handleAddNewPassword();
            }
          },
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
