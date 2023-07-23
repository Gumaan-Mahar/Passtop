import 'package:flutter/services.dart';
import 'package:passtop/widgets/custom_button.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

Future<bool> handleWillPopScope({
  required BuildContext context,
}) async {
  return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: AppColors.secondaryColor,
            backgroundColor: AppColors.secondaryColor,
            title: Text(
              AppStrings.exitAppTitle,
              style: context.theme.textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            content: Text(
              AppStrings.exitAppDescription,
              style: context.theme.textTheme.labelMedium,
            ),
            actions: <Widget>[
              CustomButton(
                width: Get.width * 0.3,
                text: 'Cancel',
                onPressed: () => Get.back(),
              ),
              CustomButton(
                width: Get.width * 0.3,
                color: AppColors.shadeDanger,
                text: 'Exit',
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              ),
            ],
          );
        },
      ) ??
      false;
}
