import 'package:flutter/material.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/screens/home_screen/home_screen.dart';
import 'package:passtop/screens/search_screen/search_screen.dart';
import 'package:passtop/screens/settings_screen/settings_screen.dart';
import 'package:passtop/screens/watch_tower_screen/watch_tower_screen.dart';

class MainController extends GetxController {

  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    WatchTowerScreen(),
    SettingsScreen(),
  ];

  final RxInt selectedNavBarTabIndex = 0.obs;
}
