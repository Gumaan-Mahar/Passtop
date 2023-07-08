import 'package:flutter/services.dart';
import 'package:passtop/screens/watch_tower_screen/components/password_quantity_detail.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/watch_tower_controller.dart';
import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import 'components/password_quantity_tile.dart';
import 'components/password_score_chart.dart';

class WatchTowerScreen extends StatelessWidget {
  final WatchTowerController watchTowerController =
      Get.put(WatchTowerController());

  WatchTowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.secondaryColor,
        systemNavigationBarColor: AppColors.customDarkColor,
      ),
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.secondaryColor,
                automaticallyImplyLeading: false,
                expandedHeight: Get.height * 0.6,
                title: Text(
                  AppStrings.watchTowerScreenTitle,
                  style: context.theme.textTheme.titleLarge!.copyWith(
                    color: AppColors.primaryColorShade200,
                  ),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 32.h,
                        ),
                        Container(
                          width: Get.width * 0.5,
                          height: Get.height * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: AppColors.customDarkColor.withOpacity(0.5),
                              width: 5.w,
                            ),
                          ),
                          child: Obx(
                            () => watchTowerController.isFetching.value
                                ? Shimmer.fromColors(
                                    baseColor: AppColors.customDarkColor
                                        .withOpacity(0.5),
                                    highlightColor:
                                        AppColors.primaryColorShade600,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: const CircleAvatar(),
                                    ),
                                  )
                                : SizedBox(
                                    width: Get.width * 0.35,
                                    height: Get.width * 0.3,
                                    child: Obx(
                                      () => PasswordScoreChart(
                                        percentage: watchTowerController
                                            .passwordsTotalScore.value,
                                        firstColor: AppColors.primaryColor,
                                        secondColor: AppColors.customDarkColor
                                            .withOpacity(0.5),
                                        size: Get.width * 0.35,
                                        controller: watchTowerController,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          width: Get.width,
                          height: Get.height * 0.24,
                          padding: EdgeInsets.all(
                            8.w,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 8.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          child: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    watchTowerController.isFetching.value
                                        ? const PasswordQuantityTileShimmer()
                                        : GestureDetector(
                                            onTap: () => Get.to(
                                              () => PasswordQuantityDetail(
                                                label: 'Weak Passwords',
                                                passwords: watchTowerController
                                                    .weakPasswords,
                                              ),
                                            ),
                                            child: PasswordQuantityTile(
                                              label: 'Weak',
                                              quantity: watchTowerController
                                                  .weakPasswords.length
                                                  .toString(),
                                              labelColor: Colors.red,
                                            ),
                                          ),
                                    watchTowerController.isFetching.value
                                        ? const PasswordQuantityTileShimmer()
                                        : GestureDetector(
                                            onTap: () => Get.to(
                                              () => PasswordQuantityDetail(
                                                label: 'Common Passwords',
                                                passwords: watchTowerController
                                                    .commonPasswords,
                                              ),
                                            ),
                                            child: PasswordQuantityTile(
                                              label: 'Common',
                                              quantity: watchTowerController
                                                  .commonPasswords.length
                                                  .toString(),
                                              labelColor: Colors.orange,
                                            ),
                                          ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    watchTowerController.isFetching.value
                                        ? const PasswordQuantityTileShimmer()
                                        : GestureDetector(
                                            onTap: () => Get.to(
                                              () => PasswordQuantityDetail(
                                                label: 'Reused Passwords',
                                                passwords: watchTowerController
                                                    .reusedPasswords,
                                              ),
                                            ),
                                            child: PasswordQuantityTile(
                                              label: 'Reused',
                                              quantity: watchTowerController
                                                  .reusedPasswords.length
                                                  .toString(),
                                              labelColor: Colors.amber,
                                            ),
                                          ),
                                    watchTowerController.isFetching.value
                                        ? const PasswordQuantityTileShimmer()
                                        : PasswordQuantityTile(
                                            label: 'Total',
                                            quantity: watchTowerController
                                                .passwords.length
                                                .toString(),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  isThreeLine: true,
                  leading: const Icon(
                    FlutterRemix.information_line,
                    color: AppColors.primaryColorShade200,
                  ),
                  title: Text(
                    AppStrings.watchTowerScreenCommonPasswordsTitle,
                    style: context.theme.textTheme.labelMedium,
                  ),
                  subtitle: Text(
                    AppStrings.watchTowerScreenCommonPasswordsDescription,
                    style: context.theme.textTheme.labelSmall!
                        .copyWith(color: AppColors.primaryColorShade300),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  isThreeLine: true,
                  leading: const Icon(
                    FlutterRemix.information_line,
                    color: AppColors.primaryColorShade200,
                  ),
                  title: Text(
                    AppStrings.watchTowerScreenReusedPasswordsTitle,
                    style: context.theme.textTheme.labelMedium,
                  ),
                  subtitle: Text(
                    AppStrings.watchTowerScreenReusedPasswordsDescription,
                    style: context.theme.textTheme.labelSmall!
                        .copyWith(color: AppColors.primaryColorShade300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordQuantityTileShimmer extends StatelessWidget {
  const PasswordQuantityTileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.customDarkColor.withOpacity(0.5),
      highlightColor: AppColors.primaryColorShade600,
      child: SizedBox(
        width: Get.width * 0.42,
        height: Get.height * 0.105,
        child: const Card(),
      ),
    );
  }
}
