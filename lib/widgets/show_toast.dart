import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

void showToast(String message) => Get.rawSnackbar(
      message: message,
      maxWidth: Get.width * 0.8,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.customDarkColor,
      borderRadius: 14,
      duration: const Duration(seconds: 2),
      barBlur: 10,
      overlayBlur: 2,
      shouldIconPulse: false,
      icon: const Icon(
        FlutterRemix.information_fill,
        color: Colors.white,
      ),
    );
