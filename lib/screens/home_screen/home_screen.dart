import 'package:flutter/services.dart';
import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/screens/home_screen/components/add_new_password_sheet.dart';
import 'package:passtop/screens/home_screen/components/display_passwords.dart';
import 'package:passtop/widgets/category_tile.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: AppColors.secondaryColor,
              systemNavigationBarColor: AppColors.customDarkColor,
            ),
            backgroundColor: AppColors.secondaryColor,
            automaticallyImplyLeading: false,
            expandedHeight: Get.height * 0.4,
            collapsedHeight: kToolbarHeight,
            snap: true,
            floating: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ),
              background: Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.06, bottom: 8.h, right: 8.w, left: 8.w),
                child: Obx(
                  () => Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 8.h,
                    spacing: 8.w,
                    children: [
                      CategoryTile(
                        title: AppStrings.homeScreenPasswordCategoryPayments,
                        icon: FlutterRemix.wallet_3_line,
                        total: homeController.paymentsPasswordsTotal.value,
                        category: homeController.categories[2],
                      ),
                      CategoryTile(
                          title: AppStrings.homeScreenPasswordCategoryBrowsers,
                          icon: FlutterRemix.global_line,
                          total: homeController.browsersPasswordsTotal.value,
                          category: homeController.categories[1]),
                      CategoryTile(
                          title: AppStrings.homeScreenPasswordCategoryApps,
                          icon: FlutterRemix.apps_2_line,
                          total: homeController.appsPasswordsTotal.value,
                          category: homeController.categories[0]),
                      CategoryTile(
                          title:
                              AppStrings.homeScreenPasswordCategoryIdentities,
                          icon: FlutterRemix.profile_line,
                          total: homeController.identitiesPasswordsTotal.value,
                          category: homeController.categories[3]),
                      CategoryTile(
                          title: AppStrings.homeScreenPasswordCategoryAddress,
                          icon: FlutterRemix.map_pin_line,
                          total: homeController.addressesPasswordsTotal.value,
                          category: homeController.categories[4]),
                      CategoryTile(
                          title: AppStrings.homeScreenPasswordCategoryGeneral,
                          icon: FlutterRemix.bring_forward,
                          total: homeController.generalPasswordsTotal.value,
                          category: homeController.categories[5]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          DisplayPasswordsStream(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          FlutterRemix.add_line,
          color: AppColors.primaryColorShade200,
        ),
        onPressed: () async {
          await displayBottomSheet(
            context,
          );
        },
      ),
    );
  }
}
