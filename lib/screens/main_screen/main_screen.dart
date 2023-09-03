import 'dart:io';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/controllers/search_controller.dart';

import '../../controllers/main_controller.dart';
import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../../methods/handle_will_pop_scope.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController _mainContoller = Get.put(MainController());
  final PasswordSearchController _passwordSearchController =
      Get.put(PasswordSearchController());
  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
        statusBarColor: context.theme.scaffoldBackgroundColor,
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        _passwordSearchController.hideSuggestionsBox.value = true;
        return await handleWillPopScope(context: context).then(
          (value) => _passwordSearchController.hideSuggestionsBox.value = false,
        );
      },
      child: Scaffold(
        body: Obx(
          () => _mainContoller
              .screens[_mainContoller.selectedNavBarTabIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => Padding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, bottom: Platform.isIOS ? 32.h : 0, top: 16.h),
            child: SizedBox(
              height: Get.height * 0.08,
              child: CustomNavigationBar(
                backgroundColor: AppColors.primaryColorShade600,
                selectedColor: AppColors.customDarkColor,
                strokeColor: AppColors.customDarkColor,
                unSelectedColor: AppColors.primaryColorShade200,
                borderRadius: const Radius.circular(10.0),
                currentIndex: _mainContoller.selectedNavBarTabIndex.value,
                onTap: (currentIndex) {
                  _mainContoller.selectedNavBarTabIndex.value = currentIndex;
                  if (currentIndex != 1) {
                    _passwordSearchController.hideKeyboard.value = true;
                  }
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
        ),
      ),
    );
  }
}
