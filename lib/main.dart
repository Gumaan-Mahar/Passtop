import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:passtop/controllers/main_controller.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/core/instances.dart';
import 'package:passtop/core/themes/themes.dart';
import 'package:passtop/screens/app_lock_screen/app_lock_screen.dart';
import 'package:passtop/screens/set_up_applock_screen/set_up_applock_screen.dart';
import 'package:passtop/services/user_services.dart';

import 'controllers/applock_controller.dart';
import 'controllers/signin_controller.dart';
import 'core/imports/packages_imports.dart';
import 'models/user.dart';
import 'screens/signin_screen/signin_screen.dart';

void configLoading() {
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false;
}

final Rx<UserModel> currentUser = UserModel().obs;
final RxBool isCurrentUserLoading = false.obs;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"]!,
      anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
      authCallbackUrlHostname: 'login-callback');
  runApp(const MyApp());
  configLoading();
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Get.put(MainController());
    Get.put(SigninController());
    Get.put(AppLockController());
    supabase.auth.onAuthStateChange.listen(
      (event) async {
        if (event.event == AuthChangeEvent.signedIn) {
          isCurrentUserLoading.value = true;
          await UserServices.getCurrentUser();
          isCurrentUserLoading.value = false;
        } else if (event.event == AuthChangeEvent.signedOut) {
          currentUser.value = UserModel();
        } else if (event.event == AuthChangeEvent.tokenRefreshed) {
          supabase.rest.setAuth(supabase.auth.currentSession?.accessToken);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            title: 'Passtop',
            theme: Themes.dark,
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            home: SafeArea(
              child: Obx(
                () => isCurrentUserLoading.value
                    ? Scaffold(
                        body: Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.primaryColor, size: 28.w),
                        ),
                      )
                    : currentUser.value.id == null
                        ? SigninScreen()
                        : currentUser.value.appLockPassword == null
                            ? SetupAppLockScreen()
                            : AppLockScreen(),
              ),
            ),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
