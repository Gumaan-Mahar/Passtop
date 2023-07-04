import 'package:flutter/services.dart';

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
              TextButton(
                child: Text(
                  'Cancel',
                  style: context.theme.textTheme.labelMedium!.copyWith(
                    color: AppColors.primaryColorShade200,
                  ),
                ),
                onPressed: () => Get.back(),
              ),
              TextButton(
                child: Text(
                  'Exit',
                  style: context.theme.textTheme.labelMedium!.copyWith(
                    color: AppColors.primaryColorShade200,
                  ),
                ),
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              )
            ],
          );
        },
      ) ??
      false;
}
