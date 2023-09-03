
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../imports/core_imports.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.customDarkColor,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.customDarkColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryColor,
    linearMinHeight: 5,
    linearTrackColor: Color(
      0xFFD9D9D9,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: Colors.transparent,
  ),
  textTheme: TextTheme(
    bodySmall: globalTextStyle(
      fontSize: headingLargeFontSize,
      color: AppColors.shadeLight,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: globalTextStyle(
      fontSize: headingOneFontSize,
      color: AppColors.shadeLight,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: globalTextStyle(
      fontSize: headingTwoFontSize,
      color: AppColors.shadeLight,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: globalTextStyle(
      fontSize: headingThreeFontSize,
      color: AppColors.shadeLight,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: globalTextStyle(
      fontSize: headingFourFontSize,
      color: AppColors.shadeLight,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: globalTextStyle(
      fontSize: headingFiveFontSize,
      color: AppColors.shadeLight,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: globalTextStyle(
      fontSize: headingSixFontSize,
      color: AppColors.shadeLight,
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: globalTextStyle(
      fontSize: headingSixFontSize,
      color: AppColors.primaryColorShade200,
      fontWeight: FontWeight.w500,
    ),
    errorStyle: globalTextStyle(
      fontSize: headingSixFontSize,
      color: AppColors.shadeDanger,
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primaryColorShade600,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primaryColorShade50,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primaryColorShade800,
        width: 1.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.shadeDanger,
        width: 1.0,
      ),
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: globalTextStyle(
      fontSize: 12.sp,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: globalTextStyle(
      fontSize: 12.sp,
      color: const Color(0xFF868590),
      fontWeight: FontWeight.w600,
    ),
    labelColor: AppColors.primaryColor,
    unselectedLabelColor: const Color(0xFF8E8E91),
    labelPadding: EdgeInsets.symmetric(vertical: 6.sp),
    indicator: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
