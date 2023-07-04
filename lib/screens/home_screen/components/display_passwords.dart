import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/screens/home_screen/components/password_category.dart';
import 'package:passtop/widgets/password_tile_detail.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

class DisplayPasswordsStream extends StatelessWidget {
  DisplayPasswordsStream({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(
        () => homeController.isPasswordsFetching.value
            ? Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.22,
                ),
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.primaryColor,
                    size: 28.w,
                  ),
                ),
              )
            : homeController.recentPasswords.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.22,
                    ),
                    child: SizedBox(
                      width: Get.width * 0.8,
                      child: Center(
                        child: Text(
                          AppStrings.homeScreenNoRecentPasswords,
                          style: context.theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColorShade300,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 16.h, right: 8.w, left: 8.w),
                        child: Text(
                          AppStrings.homeScreenRecentlyAdded,
                          style: context.theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.primaryColorShade300,
                          ),
                        ),
                      ),
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeController.recentPasswords.length,
                          padding: EdgeInsets.all(8.w),
                          itemBuilder: (_, index) {
                            final password =
                                homeController.recentPasswords[index];
                            final category = PasswordCategory(
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
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
