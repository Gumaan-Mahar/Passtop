import 'package:passtop/core/imports/packages_imports.dart';

import '../core/imports/core_imports.dart';

class CustomTextArea extends StatelessWidget {
  const CustomTextArea({
    super.key,
    this.maxLines = 4,
    this.maxLength = 150,
    required this.controller,
    this.validator,
  });

  final int maxLines;
  final int maxLength;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: context.theme.textTheme.labelMedium!.copyWith(
        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      color: Colors.transparent,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: TextInputType.multiline,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: AppStrings.homeScreenEnterYourNotesHere,
          hintStyle: context.theme.inputDecorationTheme.hintStyle,
          filled: context.theme.inputDecorationTheme.filled,
          fillColor: context.theme.inputDecorationTheme.fillColor,
          counterStyle: context.theme.inputDecorationTheme.hintStyle,
          errorStyle: context.theme.inputDecorationTheme.errorStyle,
          border: context.theme.inputDecorationTheme.border,
          focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
          enabledBorder: context.theme.inputDecorationTheme.enabledBorder,
          focusedErrorBorder:
              context.theme.inputDecorationTheme.focusedErrorBorder,
        ),
        validator: validator,
      ),
    );
  }
}
