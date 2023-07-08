import 'package:passtop/controllers/watch_tower_controller.dart';
import 'package:passtop/core/imports/packages_imports.dart';

import '../../../core/imports/core_imports.dart';

class PasswordScoreChart extends StatelessWidget {
  final double? percentage;
  final Color firstColor;
  final Color secondColor;
  final double size;
  final WatchTowerController controller;

  const PasswordScoreChart({
    super.key,
    required this.size,
    this.percentage,
    required this.firstColor,
    required this.secondColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: size * 0.05,
            backgroundColor: secondColor,
            value: percentage! / 100,
            valueColor: AlwaysStoppedAnimation<Color>(firstColor),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              percentage!.toStringAsFixed(0),
              style: context.theme.textTheme.bodySmall!.copyWith(
                color: AppColors.primaryColorShade50,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Score',
              style: context.theme.textTheme.labelMedium!.copyWith(
                color: AppColors.primaryColorShade200,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
