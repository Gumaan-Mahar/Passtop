import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/themes/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.text,
    required this.onPressed,
    this.height,
    this.icon = const SizedBox.shrink(),
    this.hasIcon = false,
    this.marginBottom = 0,
    this.color = AppColors.primaryColor,
  }) : super(key: key);
  final double width;
  final double? height;
  final String text;
  final Color color;
  final Widget icon;
  final bool hasIcon;
  final double marginBottom;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: width,
        height: height ?? 55.h,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: marginBottom),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: hasIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    text,
                    style: context.theme.textTheme.labelMedium!.copyWith(
                      color: AppColors.primaryColorShade200,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: context.theme.textTheme.labelMedium!.copyWith(
                  color: AppColors.primaryColorShade200,
                ),
              ),
      ),
    );
  }
}
