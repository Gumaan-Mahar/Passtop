import 'package:flutter/services.dart';
import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';
import 'package:passtop/widgets/password_tile_detail.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

class CategoryPasswords extends StatefulWidget {
  final String category;
  final String title;
  final String? scrollTo;
  const CategoryPasswords({
    super.key,
    required this.category,
    required this.title,
    this.scrollTo,
  });

  @override
  State<CategoryPasswords> createState() => _CategoryPasswordsState();
}

class _CategoryPasswordsState extends State<CategoryPasswords> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollTo != null) {
        int index = homeController.passwords.indexWhere(
          (password) => password.id == widget.scrollTo,
        );
        homeController.passwordsScrollController.animateTo(
          index * 100.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.secondaryColor,
        systemNavigationBarColor: AppColors.customDarkColor,
      ),
      child: SafeArea(
        child: Scaffold(
          key: homeController.scaffoldKey,
          appBar: AppBar(
            backgroundColor: AppColors.secondaryColor,
            title: Text(
              widget.title,
              style: context.theme.textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColorShade200,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(
            () => homeController.isPasswordsFetching.value
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryColor,
                      size: 28.w,
                    ),
                  )
                : homeController.passwords
                        .where(
                            (password) => password.category == widget.category)
                        .toList()
                        .isEmpty
                    ? Center(
                        child: Text(
                          AppStrings.homeScreenNoPasswords,
                          style: context.theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColorShade300,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        key: homeController.listKey,
                        controller: homeController.passwordsScrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        itemCount: homeController.passwords.length,
                        itemBuilder: (context, index) {
                          PasswordCategory passwordCategory = PasswordCategory(
                            category: homeController.passwords[index].category,
                            controller: homeController,
                          );
                          return homeController.passwords[index].category ==
                                  widget.category
                              ? PasswordTileDetail(
                                  key: ValueKey(
                                      homeController.passwords[index].id),
                                  password: homeController.passwords[index],
                                  category: passwordCategory,
                                )
                              : const SizedBox.shrink();
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
