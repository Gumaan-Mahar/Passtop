import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.total});

  final String title;
  final IconData icon;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      height: Get.height * 0.18,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
                color: AppColors.customDarkColor.withOpacity(0.5),
                shape: BoxShape.circle),
            child: Icon(
              icon,
              color: AppColors.primaryColorShade300,
              size: 28.w,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            title,
            style: context.theme.textTheme.labelSmall,
          ),
          Text(
            '$total passwords',
            style: context.theme.textTheme.labelSmall!.copyWith(
              color: AppColors.primaryColorShade200,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
