import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passtop/controllers/main_controller.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/core/themes/themes.dart';
import 'package:passtop/screens/home_screen/home_screen.dart';

import 'core/imports/packages_imports.dart';
import 'screens/signin_screen/signin_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
  );
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MainController mainController = Get.put(MainController());
  @override
  void initState() {
    super.initState();
    // Supabase.instance.client.auth.onAuthStateChange.listen((event) {
    //   if (event.event == AuthChangeEvent.signedIn) {
    //     mainController.isUserSignedIn.value = true;
    //     log('logged in');
    //   } else if (event.event == AuthChangeEvent.signedOut) {
    //     mainController.isUserSignedIn.value = false;
    //     log('logged out');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    log('current session ${Supabase.instance.client.auth.currentSession}');

    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'Passtop',
          theme: Themes.dark,
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
              stream: supabase.auth.onAuthStateChange,
              builder: (context, snapshot) {
                // if(snapshot.data == null) {
                //   return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.primaryColor, size: 28.w));
                // }
                if (snapshot.hasData) {
                  return const HomeScreen();
                }
                return const SigninScreen();
              }),
        );
      },
    );
  }
}
