import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../methods/text_field_validator.dart';
import 'custom_text_area.dart';

class FieldTile extends StatelessWidget {
  const FieldTile({
    Key? key,
    required this.title,
    required this.value,
    this.isPassword = false,
    required this.textController,
  }) : super(key: key);

  final String title;
  final String value;
  final bool isPassword;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    RxBool obscurePassword = isPassword ? true.obs : false.obs;
    textController.text = value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.textTheme.labelMedium!.copyWith(
            color: AppColors.primaryColorShade300,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        title == 'Notes'
            ? CustomTextArea(
                maxLength: 500,
                controller: textController,
              )
            : Obx(
                () => TextFormField(
                  controller: textController,
                  obscureText: obscurePassword.value,
                  maxLength: 25,
                  decoration: InputDecoration(
                    counterText: '',
                    suffix: isPassword
                        ? GestureDetector(
                            onTap: () =>
                                obscurePassword.value = !obscurePassword.value,
                            child: obscurePassword.value
                                ? const Icon(FlutterRemix.eye_line,
                                    size: 22,
                                    color: AppColors.primaryColorShade300)
                                : const Icon(FlutterRemix.eye_off_line,
                                    size: 22,
                                    color: AppColors.primaryColorShade300),
                          )
                        : const SizedBox.shrink(),
                  ),
                  validator: (value) => validateTextField(
                    value: value,
                    focusNode: FocusNode(),
                  ),
                ),
              ),
      ],
    );
  }
}
