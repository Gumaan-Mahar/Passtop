import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/screens/no_internet_connection_screen/no_internet_connection.dart';

class ConnectivityChecker extends StatefulWidget {
  const ConnectivityChecker({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  ConnectivityCheckerState createState() => ConnectivityCheckerState();
}

class ConnectivityCheckerState extends State<ConnectivityChecker> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    initializeConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });
  }

  Future<void> initializeConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus == ConnectivityResult.mobile ||
        _connectionStatus == ConnectivityResult.wifi) {
      return FutureBuilder(
          future: InitializationController.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.primaryColor,
                  size: 28.w,
                ),
              );
            }
            if (snapshot.hasError) {
              EasyLoading.showInfo(AppStrings.initializationErrorMsg);
            }
            return widget.child;
          });
    } else {
      return const NoInternetConnectionScreen();
    }
  }
}
