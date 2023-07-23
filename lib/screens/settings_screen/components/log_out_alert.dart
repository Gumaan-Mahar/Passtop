import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/widgets/custom_button.dart';

import '../../../core/imports/core_imports.dart';
import '../../../services/user_services.dart';

class LogoutAlertDialog extends StatelessWidget {
  LogoutAlertDialog({super.key});

  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FlutterRemix.logout_box_r_line,
            color: AppColors.primaryColorShade300,
            size: Get.width * 0.15,
          ),
          SizedBox(
            height: 8.h,
          ),
          Column(
            children: [
              Text(
                "Oh no! You're leaving.",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.labelLarge!.copyWith(
                  color: AppColors.primaryColorShade200,
                ),
              ),
              Text(
                "Are you sure?",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.labelLarge!.copyWith(
                  color: AppColors.primaryColorShade200,
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        CustomButton(
          width: Get.width * 0.8,
          text: 'Nah, Just Kidding!',
          onPressed: () => Get.back(),
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomButton(
          width: Get.width * 0.8,
          text: 'Yes, Log Me Out!',
          color: AppColors.shadeDanger,
          onPressed: () async {
            Get.back();
            await EasyLoading.show(status: 'Logging out...');
            await UserServices.signOut(
              controller: initializationController,
            );
          },
        ),
      ],
    );
  }
}
