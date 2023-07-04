import 'package:flutter/services.dart';

import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/models/password.dart';
import 'package:passtop/screens/home_screen/components/edit_password.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';
import 'package:passtop/services/passwords_services.dart';
import 'package:passtop/widgets/custom_button.dart';

import '../core/imports/core_imports.dart';
import '../methods/show_custom_bottom_sheet.dart';

class PasswordTileDetail extends StatelessWidget {
  final PasswordModel password;
  final PasswordCategory category;
  final bool? showMore;
  final bool? showCategoryChip;
  const PasswordTileDetail({
    Key? key,
    required this.password,
    required this.category,
    this.showMore,
    this.showCategoryChip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondaryColor,
      ),
      child: Column(
        children: [
          category.isApp
              ? FieldTile(
                  password: password,
                  category: category,
                  title: 'App Name',
                  value: password.appName,
                  isPassword: false,
                  showMore: showMore ?? true,
                  showCategoryChip: showCategoryChip ?? false,
                )
              : category.isBrowser
                  ? FieldTile(
                      password: password,
                      category: category,
                      title: 'Website Url',
                      value: password.websiteUrl,
                      isPassword: false,
                      showMore: showMore ?? true,
                      showCategoryChip: showCategoryChip ?? false,
                    )
                  : category.isPayment
                      ? FieldTile(
                          password: password,
                          category: category,
                          title: 'Card Number',
                          value: password.cardNumber,
                          isPassword: false,
                          showMore: showMore ?? true,
                          showCategoryChip: showCategoryChip ?? false,
                        )
                      : category.isIdentity
                          ? FieldTile(
                              password: password,
                              category: category,
                              title: 'Firstname',
                              value: password.firstName,
                              isPassword: false,
                              showMore: showMore ?? true,
                              showCategoryChip: showCategoryChip ?? false,
                            )
                          : category.isAddress
                              ? FieldTile(
                                  password: password,
                                  category: category,
                                  title: 'Name',
                                  value: password.addressName,
                                  isPassword: false,
                                  showMore: showMore ?? true,
                                  showCategoryChip: showCategoryChip ?? false,
                                )
                              : category.isGeneral
                                  ? FieldTile(
                                      password: password,
                                      category: category,
                                      title: 'General Note',
                                      value: password.generalText,
                                      isPassword: false,
                                      showMore: showMore ?? true,
                                      showCategoryChip:
                                          showCategoryChip ?? false,
                                    )
                                  : const SizedBox.shrink(),
          category.isGeneral
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 8.h,
                ),
          category.isApp || category.isBrowser
              ? FieldTile(
                  password: password,
                  category: category,
                  title: 'Username',
                  value: password.username,
                  isPassword: false,
                )
              : category.isPayment
                  ? FieldTile(
                      password: password,
                      category: category,
                      title: 'Name On Card',
                      value: password.nameOnCard,
                      isPassword: false,
                    )
                  : category.isIdentity
                      ? FieldTile(
                          password: password,
                          category: category,
                          title: 'Lastname',
                          value: password.lastName,
                          isPassword: false,
                        )
                      : category.isAddress
                          ? FieldTile(
                              password: password,
                              category: category,
                              title: 'Organization',
                              value: password.addressOrganisation,
                              isPassword: false,
                            )
                          : const SizedBox.shrink(),
          category.isGeneral
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 8.h,
                ),
          category.isApp || category.isBrowser
              ? FieldTile(
                  password: password,
                  category: category,
                  title: 'Password',
                  value: password.password,
                  isPassword: true,
                )
              : category.isPayment
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FieldTile(
                          password: password,
                          category: category,
                          title: 'Expiry Month',
                          value: password.expiryMonth,
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        FieldTile(
                          password: password,
                          category: category,
                          title: 'Expiry Year',
                          value: password.expiryYear,
                          isPassword: false,
                        ),
                      ],
                    )
                  : category.isIdentity
                      ? FieldTile(
                          password: password,
                          category: category,
                          title: 'Identity Number',
                          value: password.identityNumber,
                          isPassword: false,
                        )
                      : category.isAddress
                          ? FieldTile(
                              password: password,
                              category: category,
                              title: 'Phone',
                              value: password.addressPhone,
                              isPassword: false,
                            )
                          : const SizedBox.shrink(),
          category.isGeneral
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 8.h,
                ),
          password.notes.isNotEmpty
              ? category.isApp || category.isBrowser || category.isIdentity
                  ? FieldTile(
                      password: password,
                      category: category,
                      title: 'Notes',
                      value: password.notes,
                      isPassword: false,
                    )
                  : category.isPayment
                      ? FieldTile(
                          password: password,
                          category: category,
                          title: 'Nickname',
                          value: password.nickName,
                          isPassword: false,
                        )
                      : category.isAddress
                          ? FieldTile(
                              password: password,
                              category: category,
                              title: 'Email',
                              value: password.addressEmail,
                              isPassword: false,
                            )
                          : const SizedBox.shrink()
              : const SizedBox.shrink(),
          category.isGeneral
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 8.h,
                ),
          category.isPayment
              ? FieldTile(
                  password: password,
                  category: category,
                  title: 'Notes',
                  value: password.notes,
                  isPassword: false,
                )
              : category.isAddress
                  ? FieldTile(
                      password: password,
                      category: category,
                      title: 'Country/Region',
                      value: password.addressRegion,
                      isPassword: false,
                    )
                  : const SizedBox.shrink(),
          category.isAddress
              ? SizedBox(
                  height: 8.h,
                )
              : const SizedBox.shrink(),
          category.isAddress
              ? FieldTile(
                  password: password,
                  category: category,
                  title: 'Street Address',
                  value: password.addressStreetAddress,
                  isPassword: false,
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
                  isPassword: false,
                  password: password,
                  category: category,
                )
              : const SizedBox.shrink(),
          category.isAddress
              ? SizedBox(
                  height: 8.h,
                )
              : const SizedBox.shrink(),
          category.isAddress
              ? FieldTile(
                  password: password,
                  category: category,
                  title: 'Postal Code',
                  value: password.addressPostalCode,
                  isPassword: false,
                )
              : const SizedBox.shrink(),
          category.isAddress
              ? SizedBox(
                  height: 8.h,
                )
              : const SizedBox.shrink(),
          category.isAddress
              ? FieldTile(
                  password: password,
                  category: category,
                  title: 'Notes',
                  value: password.notes,
                  isPassword: false,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class FieldTile extends StatelessWidget {
  const FieldTile({
    super.key,
    required this.password,
    required this.category,
    required this.title,
    required this.value,
    required this.isPassword,
    this.showMore = false,
    this.showCategoryChip = false,
  });

  final PasswordModel password;
  final PasswordCategory category;
  final String title;
  final String value;
  final bool isPassword;
  final bool showMore;
  final bool showCategoryChip;

  @override
  Widget build(BuildContext context) {
    RxBool obscurePassword = true.obs;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showMore
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            color: AppColors.primaryColorShade300,
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (details) async {
                            return await showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                details.globalPosition.dx,
                                details.globalPosition.dy,
                                details.globalPosition.dx,
                                details.globalPosition.dy,
                              ),
                              elevation: 8.0,
                              color: AppColors.customDarkColor,
                              items: [
                                PopupMenuItem<String>(
                                  value: 'edit_password',
                                  child: Text(
                                    'Edit',
                                    style: context.theme.textTheme.labelMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColorShade200,
                                    ),
                                  ),
                                  onTap: () {
                                    showCustomBottomSheet(
                                      height: Get.height * 0.8,
                                      content: EditPassword(
                                        password: password,
                                        category: category,
                                      ),
                                    );
                                  },
                                ),
                                PopupMenuItem<String>(
                                  value: 'delete_password',
                                  child: Text(
                                    'Delete',
                                    style: context.theme.textTheme.labelMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColorShade200,
                                    ),
                                  ),
                                  onTap: () {
                                    showCustomBottomSheet(
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FlutterRemix.information_line,
                                            size: Get.width * 0.2,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            AppStrings.homeScreenAreYouSure,
                                            style: context
                                                .theme.textTheme.titleMedium!,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            AppStrings
                                                .homeScreenConfirmDeletePassword,
                                            textAlign: TextAlign.center,
                                            style: context
                                                .theme.textTheme.labelMedium!,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomButton(
                                                width: Get.width * 0.35,
                                                color: AppColors.secondaryColor,
                                                text: 'Cancel',
                                                onPressed: () => Get.back(),
                                              ),
                                              CustomButton(
                                                width: Get.width * 0.35,
                                                color: AppColors.shadeDanger,
                                                text: 'Delete',
                                                onPressed: () async {
                                                  HomeController
                                                      homeController =
                                                      Get.find();
                                                  await EasyLoading.show(
                                                      status: 'Deleting...');
                                                  await PasswordsServices
                                                      .deletePassword(
                                                    passwordID: password.id,
                                                  );
                                                  final category =
                                                      PasswordCategory(
                                                    category: password.category,
                                                    controller: homeController,
                                                  );
                                                  category.isApp
                                                      ? homeController
                                                          .appsPasswordsTotal
                                                          .value -= 1
                                                      : category.isBrowser
                                                          ? homeController
                                                              .browsersPasswordsTotal
                                                              .value -= 1
                                                          : category.isPayment
                                                              ? homeController
                                                                  .paymentsPasswordsTotal
                                                                  .value -= 1
                                                              : category
                                                                      .isIdentity
                                                                  ? homeController
                                                                          .identitiesPasswordsTotal
                                                                          .value -=
                                                                      1
                                                                  : category
                                                                          .isAddress
                                                                      ? homeController
                                                                          .addressesPasswordsTotal
                                                                          .value -= 1
                                                                      : category.isGeneral
                                                                          ? homeController.generalPasswordsTotal.value -= 1
                                                                          : null;
                                                  await EasyLoading.dismiss();
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                          child: Icon(
                            FlutterRemix.more_2_line,
                            color: AppColors.primaryColorShade300,
                            size: 22.w,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: context.theme.textTheme.labelMedium!.copyWith(
                        color: AppColors.primaryColorShade300,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isPassword
                      ? Obx(
                          () => obscurePassword.value
                              ? Text(
                                  '●' * value.length,
                                  style: context.theme.textTheme.labelMedium,
                                )
                              : Text(
                                  value,
                                  style: context.theme.textTheme.labelMedium,
                                ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width * 0.8),
                              child: Text(
                                value,
                                style: context.theme.textTheme.labelMedium,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Clipboard.setData(ClipboardData(text: value))
                                      .then((_) {
                                EasyLoading.showInfo(
                                  'Text copied!',
                                );
                              }),
                              child: Icon(
                                FlutterRemix.file_copy_line,
                                size: 16.w,
                                color: AppColors.primaryColorShade300,
                              ),
                            ),
                          ],
                        ),
                  isPassword
                      ? Obx(
                          () => obscurePassword.value
                              ? GestureDetector(
                                  onTap: () => obscurePassword.value = false,
                                  child: Icon(
                                    FlutterRemix.eye_line,
                                    size: 22.w,
                                    color: AppColors.primaryColorShade300,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => obscurePassword.value = true,
                                  child: Icon(
                                    FlutterRemix.eye_off_line,
                                    size: 22.w,
                                    color: AppColors.primaryColorShade500,
                                  ),
                                ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
        showCategoryChip
            ? category.isGeneral
                ? const SizedBox.shrink()
                : Chip(
                    backgroundColor: AppColors.primaryColor,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.zero,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                    label: Text(
                      password.category,
                      style: context.theme.textTheme.labelMedium!
                          .copyWith(color: AppColors.primaryColorShade200),
                    ),
                  )
            : const SizedBox.shrink(),
      ],
    );
  }
}
