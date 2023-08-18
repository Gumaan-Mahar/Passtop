import 'package:flutter/services.dart';
import 'package:passtop/controllers/settings_controller.dart';
import 'package:passtop/screens/settings_screen/components/change_master_password_dialog.dart';
import 'package:passtop/screens/settings_screen/components/delete_account_dialog.dart';
import 'package:passtop/screens/settings_screen/components/log_out_alert.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import 'components/setting_option_tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.secondaryColor,
        systemNavigationBarColor: AppColors.customDarkColor,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondaryColor,
            title: Text(
              AppStrings.settingsScreenTitle,
              style: context.theme.textTheme.titleLarge!.copyWith(
                color: AppColors.primaryColorShade200,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.w,
                        top: 16.h,
                      ),
                      child: Text(
                        'Account',
                        style: context.theme.textTheme.labelLarge!.copyWith(
                          color: AppColors.primaryColorShade300,
                        ),
                      ),
                    ),
                    SettingsOptionTile(
                      title: 'Change Master Password',
                      icon: FlutterRemix.lock_password_line,
                      showTrailing: true,
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return ChangeMasterPasswordDialog(
                            );
                          },
                        );
                      },
                    ),
                    SettingsOptionTile(
                      title: 'Delete Account',
                      icon: FlutterRemix.delete_bin_line,
                      showTrailing: true,
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return DeleteAccountDialog();
                          },
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.w,
                        top: 32.h,
                      ),
                      child: Text(
                        'About Us',
                        style: context.theme.textTheme.labelMedium!.copyWith(
                          color: AppColors.primaryColorShade300,
                        ),
                      ),
                    ),
                    SettingsOptionTile(
                      title: 'Feedback or Contact',
                      icon: FlutterRemix.feedback_line,
                      onPressed: () {},
                    ),
                    SettingsOptionTile(
                      title: 'Privacy Policy',
                      icon: FlutterRemix.chat_private_line,
                      onPressed: () {},
                    ),
                    SettingsOptionTile(
                      title: 'Terms of Service',
                      icon: FlutterRemix.service_line,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                ListTile(
                  title: Text(
                    'Logout',
                    style: context.theme.textTheme.labelLarge!.copyWith(
                      color: AppColors.shadeDanger,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: const Icon(
                    FlutterRemix.logout_box_line,
                    color: AppColors.shadeDanger,
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LogoutAlertDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
