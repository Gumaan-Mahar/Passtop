import 'package:flutter/services.dart';
import 'package:passtop/screens/home_screen/components/add_new_password_sheet.dart';
import 'package:passtop/widgets/category_tile.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.secondaryColor,
      ),
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.secondaryColor,
                automaticallyImplyLeading: false,
                expandedHeight: Get.height * 0.4,
                snap: true,
                floating: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 8.h,
                      spacing: 8.w,
                      children: const [
                        CategoryTile(
                            title:
                                AppStrings.homeScreenPasswordCategoryPayments,
                            icon: FlutterRemix.wallet_3_line,
                            total: 34),
                        CategoryTile(
                            title:
                                AppStrings.homeScreenPasswordCategoryBrowsers,
                            icon: FlutterRemix.global_line,
                            total: 34),
                        CategoryTile(
                            title: AppStrings.homeScreenPasswordCategoryApps,
                            icon: FlutterRemix.apps_2_line,
                            total: 34),
                        CategoryTile(
                            title:
                                AppStrings.homeScreenPasswordCategoryIdentities,
                            icon: FlutterRemix.profile_line,
                            total: 34),
                        CategoryTile(
                            title: AppStrings.homeScreenPasswordCategoryAddress,
                            icon: FlutterRemix.map_pin_line,
                            total: 34),
                        CategoryTile(
                            title: AppStrings.homeScreenPasswordCategoryGeneral,
                            icon: FlutterRemix.bring_forward,
                            total: 34),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(
                    20,
                    (index) => ListTile(
                      title: Text(
                        index.toString(),
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              FlutterRemix.add_line,
              color: AppColors.primaryColorShade200,
            ),
            onPressed: () => displayBottomSheet(
              context,
              title: '',
              controller: TextEditingController(),
              onSave: () {},
              maxLength: 14,
            ),
          ),
        ),
      ),
    );
  }
}
