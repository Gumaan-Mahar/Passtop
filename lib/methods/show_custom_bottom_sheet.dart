
import '../controllers/home_controller.dart';
import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

void showCustomBottomSheet({required Widget content, double? height}) {
  HomeController homeController = Get.find();
  homeController.scaffoldKey.currentState!.showBottomSheet(
    (context) => Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
          ),
        ),
        Container(
          width: Get.width,
          height: height ?? Get.height * 0.4,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: const BoxDecoration(
            color: AppColors.customDarkColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                20.0,
              ),
              topRight: Radius.circular(
                20.0,
              ),
            ),
          ),
          child: content,
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
  );
}
