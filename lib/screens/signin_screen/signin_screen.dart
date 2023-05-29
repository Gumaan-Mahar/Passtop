import 'package:flutter/services.dart';
import 'package:passtop/core/constants.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:passtop/services/auth_services.dart';
import 'package:passtop/widgets/button_loader.dart';
import 'package:passtop/widgets/custom_button.dart';

import '../../core/imports/core_imports.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
      statusBarColor: context.theme.scaffoldBackgroundColor,
    ));
    return Scaffold(
      body: Padding(
        padding: kHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SvgPicture.asset('assets/images/illustration_01.svg'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SlideInLeft(
                      // delay: const Duration(seconds: 1),
                      from: 300,
                      child: Text(
                        AppStrings.welcomeScreenTitle,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SlideInLeft(
                      delay: const Duration(milliseconds: 600),
                      from: 500,
                      child: Text(
                        AppStrings.welcomeScreenDescription,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.labelMedium!
                            .copyWith(color: AppColors.primaryColorShade200),
                      ),
                    ),
                    const Spacer(),
                    true == false
                        ? ButtonLoader(width: Get.width * 0.8)
                        : SlideInUp(
                            child: CustomButton(
                              width: Get.width * 0.8,
                              height: 48.h,
                              text: 'Continue with Google',
                              marginBottom: 20.h,
                              hasIcon: true,
                              icon: const Icon(
                                FlutterRemix.google_fill,
                              ),
                              onPressed: () =>
                                  AuthServices.continueWithGoogle(),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
