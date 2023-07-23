import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';

import '../../../core/imports/core_imports.dart';

class SettingsOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool showTrailing;
  final VoidCallback onPressed;
  const SettingsOptionTile({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.showTrailing = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: context.theme.textTheme.labelMedium!.copyWith(
          color: AppColors.primaryColorShade200,
          fontWeight: FontWeight.w600
        ),
      ),
      leading: Icon(
        icon,
        color: AppColors.primaryColorShade300,
      ),
      trailing: showTrailing
          ? const Icon(
              FlutterRemix.arrow_right_s_line,
              color: AppColors.primaryColorShade300,
            )
          : const SizedBox.shrink(),
      onTap: onPressed,
    );
  }
}
