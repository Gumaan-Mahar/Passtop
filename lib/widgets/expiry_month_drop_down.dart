import 'package:passtop/core/imports/packages_imports.dart';

import '../core/imports/core_imports.dart';

class ExpiryMonthDropDown extends StatelessWidget {
  const ExpiryMonthDropDown({
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
        AppStrings.homeScreenExpiryMonth,
        style: context.theme.inputDecorationTheme.hintStyle,
      ),
      menuMaxHeight: Get.height * 0.3,
      alignment: Alignment.center,
      items: List.generate(
              12, (index) => index < 9 ? '0${index + 1}' : '${index + 1}')
          .map(
            (month) => DropdownMenuItem<String>(
              value: month,
              child: Text(
                month,
                style: context.theme.textTheme.labelMedium,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
