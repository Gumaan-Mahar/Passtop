import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/screens/initial_screen.dart/initial_screen.dart';

import 'core/imports/packages_imports.dart';
import 'core/instances.dart';
import 'core/themes/themes.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Get.put(InitializationController());
  await Preferences().init();
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final InitializationController initializationController = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializationController.initializeConnectivity();
    });
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      scaleByHeight: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'Passtop',
          theme: Themes.dark,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          home: const InitialScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
