import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/main.dart';
import 'package:passtop/models/user.dart';
import 'package:passtop/screens/home_screen/home_screen.dart';
import 'package:passtop/screens/search_screen/search_screen.dart';
import 'package:passtop/screens/settings_screen/settings_screen.dart';
import 'package:passtop/screens/watch_tower_screen/watch_tower_screen.dart';

import '../core/instances.dart';
import '../screens/no_internet_connection_screen/no_internet_connection.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    subscribeToCurrentUserChannel();
    super.onInit();
  }

  void subscribeToCurrentUserChannel() {
    supabase.channel('public:users').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'UPDATE',
        schema: 'public',
        table: 'users',
        filter: 'id=eq.${supabase.auth.currentUser?.id}',
      ),
      (payload, [ref]) {
        currentUser.value = UserModel.fromJson(payload['new']);
      },
    ).subscribe();
  }

  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    WatchTowerScreen(),
    const SettingsScreen(),
  ];

  final RxInt selectedNavBarTabIndex = 0.obs;


  @override
  void dispose() async {
    supabase.channel('public:users').unsubscribe();
    super.dispose();
  }
}
