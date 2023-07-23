import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/screens/home_screen/components/new_password_form.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

Future<dynamic> displayBottomSheet(BuildContext context) {
  final HomeController homeController = Get.find();

  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (context) {
      return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          GestureDetector(
            onTap: () {
              homeController.clearTextFields();
              homeController.newPasswordSelectedCategory.value =
                  homeController.categories[0];
            },
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.transparent,
            ),
          ),
          Form(
            key: homeController.formKey,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                width: Get.width,
                height: Get.height * 0.8,
                decoration: const BoxDecoration(
                  color: AppColors.customDarkColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: NewPasswordForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
