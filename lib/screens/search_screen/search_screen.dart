import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:passtop/controllers/home_controller.dart';

import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/screens/home_screen/components/category_passwords.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';
import 'package:passtop/widgets/password_tile_detail.dart';
import '../../controllers/search_controller.dart';
import '../../core/imports/core_imports.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final HomeController homeController = Get.find();
  final PasswordSearchController passwordSearchController =
      Get.put(PasswordSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'Search',
          style: context.theme.textTheme.titleMedium!.copyWith(
            color: AppColors.primaryColorShade200,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.secondaryColor,
          systemNavigationBarColor: AppColors.customDarkColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        child: Obx(
          () => TypeAheadField(
            hideSuggestionsOnKeyboardHide:
                passwordSearchController.hideSuggestionsBox.value,
            hideKeyboard: passwordSearchController.hideKeyboard.value,
            suggestionsBoxVerticalOffset: 16.h,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              hasScrollbar: false,
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              constraints: BoxConstraints(
                maxHeight: Get.height * 0.65,
              ),
            ),
            getImmediateSuggestions: true,
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              maxLength: 35,
              style: context.theme.textTheme.labelMedium!.copyWith(
                decoration: TextDecoration.none,
                decorationThickness: 0.0,
              ),
              decoration: InputDecoration(
                counterText: '',
                prefixIcon: const Icon(
                  FlutterRemix.search_line,
                  color: AppColors.primaryColorShade50,
                ),
                hintText: AppStrings.searchScreenSearchHere,
                hintStyle: context.theme.textTheme.labelMedium!.copyWith(
                  color: AppColors.primaryColorShade300,
                ),
              ),
              onTap: () => passwordSearchController.hideKeyboard.value = false,
            ),
            suggestionsCallback: (pattern) =>
                passwordSearchController.showSuggestions(query: pattern),
            itemBuilder: (context, password) {
              final PasswordCategory category = PasswordCategory(
                category: password.category,
                controller: homeController,
              );
              return PasswordTileDetail(
                password: password,
                category: category,
                showMore: false,
                showCategoryChip: true,
              );
            },
            onSuggestionSelected: (password) {
              final PasswordCategory category = PasswordCategory(
                category: password.category,
                controller: homeController,
              );
              final title = category.isPayment
                  ? AppStrings.homeScreenPasswordCategoryPayments
                  : category.isBrowser
                      ? AppStrings.homeScreenPasswordCategoryBrowsers
                      : category.isApp
                          ? AppStrings.homeScreenPasswordCategoryApps
                          : category.isIdentity
                              ? AppStrings.homeScreenPasswordCategoryIdentities
                              : category.isAddress
                                  ? AppStrings.homeScreenPasswordCategoryAddress
                                  : category.isGeneral
                                      ? AppStrings
                                          .homeScreenPasswordCategoryGeneral
                                      : '';
              Get.to(
                () => CategoryPasswords(
                  category: password.category,
                  title: title,
                  scrollTo: password.id,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
