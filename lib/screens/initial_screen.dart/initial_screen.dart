import 'package:passtop/controllers/initialization_controller.dart';

import '../../controllers/applock_controller.dart';
import '../../controllers/signin_controller.dart';
import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../app_lock_screen/app_lock_screen.dart';
import '../set_up_applock_screen/set_up_applock_screen.dart';
import '../signin_screen/signin_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    super.key,
  });

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final SigninController signinController = Get.put(SigninController());
  final AppLockController appLockController = Get.put(AppLockController());
  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return initializationController.isCurrentUserLoading.value
            ? Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.primaryColor,
                    size: 28.w,
                  ),
                ),
              )
            : initializationController.currentUser.value == null
                ? SigninScreen()
                : (initializationController
                                .currentUser.value!.appLockPassword ==
                            null ||
                        initializationController
                            .currentUser.value!.appLockPassword!.isEmpty)
                    ? SetupAppLockScreen()
                    : AppLockScreen();
      }),
    );
  }
}
