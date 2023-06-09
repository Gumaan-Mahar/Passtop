import 'package:cached_network_image/cached_network_image.dart';
import 'package:passtop/core/imports/packages_imports.dart';

import '../core/imports/core_imports.dart';


class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.profileUrl,
    this.width,
    this.height,
    this.iconSize,
    this.borderColor = AppColors.primaryColor,
  });

  final String profileUrl;
  final double? width;
  final double? height;
  final double? iconSize;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 38.w,
      height: height ?? 38.h,
      padding: EdgeInsets.all(2.w),
      margin: EdgeInsets.only(right: 6.w, top: 2.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2.5),
        color: Colors.transparent,
      ),
      child: Container(
        width: width ?? 38.w,
      height: height ?? 38.h,
        decoration: BoxDecoration(
          image: profileUrl.isNotEmpty
              ? DecorationImage(
                  image: CachedNetworkImageProvider(profileUrl),
                  fit: BoxFit.cover)
              : null,
          shape: BoxShape.circle,
        ),
        child: profileUrl.isEmpty
            ? CircleAvatar(
                backgroundColor: AppColors.customDarkColor,
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.primaryColor,
                  size: iconSize ?? 24.w,
                ),
              )
            : null,
      ),
    );
  }
}
