import 'package:flutter/services.dart';
import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';
import 'package:passtop/widgets/password_tile_detail.dart';

import '../../../controllers/watch_tower_controller.dart';
import '../../../core/imports/core_imports.dart';

class PasswordQuantityDetail extends StatelessWidget {
  final String label;
  final List<dynamic> passwords;
  PasswordQuantityDetail(
      {super.key, required this.label, required this.passwords});
  final HomeController homeController = Get.find();
  final WatchTowerController watchTowerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.secondaryColor,
        systemNavigationBarColor: AppColors.customDarkColor,
      ),
      child: SafeArea(
        child: Scaffold(
          key: watchTowerController.scaffoldKey,
          appBar: AppBar(
            backgroundColor: AppColors.secondaryColor,
            centerTitle: true,
            title: Text(
              label,
              style: context.theme.textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColorShade200,
              ),
            ),
          ),
          body: Obx(
            () => passwords.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.homeScreenNoPasswords,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.primaryColorShade300,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: passwords.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    itemBuilder: (_, index) {
                      final PasswordCategory category = PasswordCategory(
                        category: passwords[index].category,
                        controller: homeController,
                      );
                      return PasswordTileDetail(
                        password: passwords[index],
                        category: category,
                        scaffoldKey: watchTowerController.scaffoldKey,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
