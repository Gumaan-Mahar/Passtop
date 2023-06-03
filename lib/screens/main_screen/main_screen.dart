import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:passtop/controllers/applock_controller.dart';
import 'package:passtop/controllers/home_controller.dart';
import 'package:passtop/main.dart';
import 'package:passtop/screens/home_screen/home_screen.dart';
import 'package:passtop/services/user_services.dart';

import '../../controllers/main_controller.dart';
import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final AppLockController _appLockContoller = Get.find();
  final MainController _mainContoller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    _appLockContoller.isContinueButtonLoading.value = false;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await EasyLoading.show(status: 'Logging out...');
              await UserServices.signOut();
              await EasyLoading.dismiss();
            },
            child: const Text('Log out'),
          ),
        ],
      ),
      body: const HomeScreen(),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.all(16.w),
          child: CustomNavigationBar(
            backgroundColor: AppColors.primaryColorShade600,
            selectedColor: AppColors.customDarkColor,
            strokeColor: AppColors.customDarkColor,
            unSelectedColor: AppColors.primaryColorShade200,
            borderRadius: const Radius.circular(10.0),
            currentIndex: _mainContoller.selectedNavBarTabIndex.value,
            onTap: (currentIndex) {
              _mainContoller.selectedNavBarTabIndex.value = currentIndex;
            },
            items: [
              CustomNavigationBarItem(
                icon: const Icon(FlutterRemix.home_8_line),
              ),
              CustomNavigationBarItem(
                icon: const Icon(FlutterRemix.search_line),
              ),
              CustomNavigationBarItem(
                icon: const Icon(FlutterRemix.signal_tower_line),
              ),
              CustomNavigationBarItem(
                icon: const Icon(FlutterRemix.settings_line),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
