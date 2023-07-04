import 'package:passtop/core/imports/packages_imports.dart';

import '../core/imports/core_imports.dart';

class ExpiryYearDropDown extends StatelessWidget {
  const ExpiryYearDropDown({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  final void Function(String?)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      dropdownColor: AppColors.secondaryColor,
      hint: Text(
        AppStrings.homeScreenExpiryYear,
        style: context.theme.inputDecorationTheme.hintStyle,
      ),
      menuMaxHeight: Get.height * 0.5,
      alignment: Alignment.center,
      items: List.generate(
        30,
        (index) => (DateTime.now().year + index).toString(),
      )
          .map(
            (year) => DropdownMenuItem<String>(
              value: year,
              child: Text(
                year,
                style: context.theme.textTheme.labelMedium,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}