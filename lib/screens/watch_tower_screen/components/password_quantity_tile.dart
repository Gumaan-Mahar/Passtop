import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

class PasswordQuantityTile extends StatelessWidget {
  final String quantity;
  final String label;
  final Color? labelColor;

  const PasswordQuantityTile({
    required this.quantity,
    required this.label,
    this.labelColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.42,
      height: Get.height * 0.105,
      child: Card(
        color: AppColors.secondaryColor,
        elevation: 5.0,
        shadowColor: AppColors.customDarkColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quantity,
              style: context.theme.textTheme.titleLarge!.copyWith(
                color: AppColors.primaryColorShade200,
              ),
            ),
            Text(
              label,
              style: context.theme.textTheme.titleSmall!.copyWith(
                color: labelColor ?? AppColors.primaryColorShade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}