import 'package:passtop/controllers/edit_password_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/models/password.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';
import 'package:passtop/services/passwords_services.dart';

import '../../../core/imports/core_imports.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/expiry_month_drop_down.dart';
import '../../../widgets/expiry_year_drop_down.dart';
import '../../../widgets/field_tile.dart';

class EditPassword extends StatelessWidget {
  EditPassword({super.key, required this.password, required this.category});

  final PasswordCategory category;
  final PasswordModel password;

  final EditPasswordController editPasswordController =
      Get.put(EditPasswordController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: editPasswordController.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit password',
                    style: context.theme.textTheme.labelLarge!.copyWith(
                        // color: AppColors.primaryColorShade200,
                        ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      FlutterRemix.close_line,
                      color: AppColors.primaryColorShade50,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              category.isApp
                  ? FieldTile(
                      title: 'App Name',
                      value: password.appName,
                      textController:
                          editPasswordController.newPasswordAppNameController,
                    )
                  : category.isBrowser
                      ? FieldTile(
                          title: 'Website Url',
                          value: password.websiteUrl,
                          textController: editPasswordController
                              .newPasswordWebsiteUrlController,
                        )
                      : category.isPayment
                          ? FieldTile(
                              title: 'Card Number',
                              value: password.cardNumber,
                              textController: editPasswordController
                                  .newPasswordCardNumberController,
                            )
                          : category.isIdentity
                              ? FieldTile(
                                  title: 'Firstname',
                                  value: password.firstName,
                                  textController: editPasswordController
                                      .newPasswordFirstNameController,
                                )
                              : category.isAddress
                                  ? FieldTile(
                                      title: 'Name',
                                      value: password.addressName,
                                      textController: editPasswordController
                                          .newPasswordAddressNameController,
                                    )
                                  : category.isGeneral
                                      ? FieldTile(
                                          title: 'Notes',
                                          value: password.generalText,
                                          textController: editPasswordController
                                              .newPasswordGeneralTextController,
                                        )
                                      : const SizedBox.shrink(),
              SizedBox(
                height: 8.h,
              ),
              category.isApp || category.isBrowser
                  ? FieldTile(
                      title: 'Username',
                      value: password.username,
                      textController:
                          editPasswordController.newPasswordUsernameController,
                    )
                  : category.isPayment
                      ? FieldTile(
                          title: 'Name On Card',
                          value: password.nameOnCard,
                          textController: editPasswordController
                              .newPasswordNameOnCardController,
                        )
                      : category.isIdentity
                          ? FieldTile(
                              title: 'Lastname',
                              value: password.lastName,
                              textController: editPasswordController
                                  .newPasswordLastNameController,
                            )
                          : category.isAddress
                              ? FieldTile(
                                  title: 'Organization',
                                  value: password.addressOrganisation,
                                  textController: editPasswordController
                                      .newPasswordAddressOrganisationController,
                                )
                              : const SizedBox.shrink(),
              SizedBox(
                height: 8.h,
              ),
              category.isApp || category.isBrowser
                  ? FieldTile(
                      title: 'Password',
                      value: password.password,
                      isPassword: true,
                      textController:
                          editPasswordController.newPasswordPasswordController,
                    )
                  : category.isPayment
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry Month',
                                  style: context.theme.textTheme.labelMedium!
                                      .copyWith(
                                    color: AppColors.primaryColorShade300,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: Get.width * 0.35,
                                  child: ExpiryMonthDropDown(
                                    initialValue: password.expiryMonth,
                                    onChanged: (selectedVal) =>
                                        editPasswordController
                                            .newPasswordExpiryMonth
                                            .value = selectedVal!,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry Year',
                                  style: context.theme.textTheme.labelMedium!
                                      .copyWith(
                                    color: AppColors.primaryColorShade300,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: Get.width * 0.45,
                                  child: ExpiryYearDropDown(
                                    initialValue: password.expiryYear,
                                    onChanged: (selectedVal) =>
                                        editPasswordController
                                            .newPasswordExpiryYear
                                            .value = selectedVal!,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : category.isIdentity
                          ? FieldTile(
                              title: 'Identity Number',
                              value: password.identityNumber,
                              textController: editPasswordController
                                  .newPasswordIdentityNumberController,
                            )
                          : category.isAddress
                              ? FieldTile(
                                  title: 'Phone',
                                  value: password.addressPhone,
                                  textController: editPasswordController
                                      .newPasswordAddressPhoneController,
                                )
                              : const SizedBox.shrink(),
              SizedBox(
                height: 8.h,
              ),
              category.isApp || category.isBrowser || category.isIdentity
                  ? Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: FieldTile(
                        title: 'Notes',
                        value: password.notes,
                        textController:
                            editPasswordController.newPasswordNotesController,
                      ),
                    )
                  : category.isPayment
                      ? FieldTile(
                          title: 'Nickname',
                          value: password.nickName,
                          textController: editPasswordController
                              .newPasswordNicknameController,
                        )
                      : category.isAddress
                          ? FieldTile(
                              title: 'Email',
                              value: password.addressEmail,
                              textController: editPasswordController
                                  .newPasswordAddressEmailController,
                            )
                          : const SizedBox.shrink(),
              SizedBox(
                height: 8.h,
              ),
              category.isPayment
                  ? FieldTile(
                      title: 'Notes',
                      value: password.notes,
                      textController:
                          editPasswordController.newPasswordNotesController,
                    )
                  : category.isAddress
                      ? FieldTile(
                          title: 'Country/Region',
                          value: password.addressRegion,
                          textController: editPasswordController
                              .newPasswordAddressRegionController,
                        )
                      : const SizedBox.shrink(),
              category.isAddress
                  ? FieldTile(
                      title: 'Street Address',
                      value: password.addressStreetAddress,
                      textController: editPasswordController
                          .newPasswordAddressStreetAddressController,
                    )
                  : const SizedBox.shrink(),
              category.isAddress
                  ? SizedBox(
                      height: 8.h,
                    )
                  : const SizedBox.shrink(),
              category.isAddress
                  ? FieldTile(
                      title: 'City',
                      value: password.addressCity,
                      textController: editPasswordController
                          .newPasswordAddressCityController,
                    )
                  : const SizedBox.shrink(),
              category.isAddress
                  ? SizedBox(
                      height: 8.h,
                    )
                  : const SizedBox.shrink(),
              category.isAddress
                  ? FieldTile(
                      title: 'Postal Code',
                      value: password.addressPostalCode,
                      textController: editPasswordController
                          .newPasswordAddressPostalCodeController,
                    )
                  : const SizedBox.shrink(),
              category.isAddress
                  ? SizedBox(
                      height: 16.h,
                    )
                  : const SizedBox.shrink(),
              category.isAddress
                  ? FieldTile(
                      title: 'Notes',
                      value: password.notes,
                      textController:
                          editPasswordController.newPasswordNotesController,
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: 32.h),
              CustomButton(
                width: Get.width * 0.8,
                text: 'Save Changes',
                onPressed: () async {
                  if (editPasswordController.formKey.currentState!.validate()) {
                    await EasyLoading.show(status: 'Saving Changes...');
                    PasswordModel passwordModel = PasswordModel(
                      id: password.id,
                      userId: password.userId,
                      createdAt: DateTime.now(),
                      category: password.category,
                      appName: editPasswordController
                          .newPasswordAppNameController.text,
                      username: editPasswordController
                          .newPasswordUsernameController.text,
                      password: editPasswordController
                          .newPasswordPasswordController.text,
                      websiteUrl: editPasswordController
                          .newPasswordWebsiteUrlController.text,
                      cardNumber: editPasswordController
                          .newPasswordCardNumberController.text,
                      nameOnCard: editPasswordController
                          .newPasswordNameOnCardController.text,
                      expiryMonth: editPasswordController
                              .newPasswordExpiryMonth.value.isEmpty
                          ? password.expiryMonth
                          : editPasswordController.newPasswordExpiryMonth.value,
                      expiryYear: editPasswordController
                              .newPasswordExpiryYear.value.isEmpty
                          ? password.expiryYear
                          : editPasswordController.newPasswordExpiryYear.value,
                      nickName: editPasswordController
                          .newPasswordNicknameController.text,
                      firstName: editPasswordController
                          .newPasswordFirstNameController.text,
                      lastName: editPasswordController
                          .newPasswordLastNameController.text,
                      identityNumber: editPasswordController
                          .newPasswordIdentityNumberController.text,
                      addressName: editPasswordController
                          .newPasswordAddressNameController.text,
                      addressOrganisation: editPasswordController
                          .newPasswordAddressOrganisationController.text,
                      addressPhone: editPasswordController
                          .newPasswordAddressPhoneController.text,
                      addressEmail: editPasswordController
                          .newPasswordAddressEmailController.text,
                      addressRegion: editPasswordController
                          .newPasswordAddressRegionController.text,
                      addressStreetAddress: editPasswordController
                          .newPasswordAddressStreetAddressController.text,
                      addressCity: editPasswordController
                          .newPasswordAddressCityController.text,
                      addressPostalCode: editPasswordController
                          .newPasswordAddressPostalCodeController.text,
                      generalText: editPasswordController
                          .newPasswordGeneralTextController.text,
                      notes: editPasswordController
                          .newPasswordNotesController.text,
                    );
                    await PasswordsServices.updatePassword(
                        password: passwordModel);
                    await Future.delayed(
                      const Duration(
                        seconds: 1,
                      ),
                    );
                    await EasyLoading.dismiss();
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
