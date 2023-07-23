
import '../imports/core_imports.dart';

TextStyle globalTextStyle({
  color = AppColors.shadeLight,
  required double fontSize,
  double letterSpacing = 0.5,
  double lineHeight = 0,
  FontWeight fontWeight = FontWeight.w500,
}) =>
    TextStyle(
      color: color,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      height: lineHeight,
      fontFamily: 'Poppins',
      decoration: TextDecoration.none,
    );
