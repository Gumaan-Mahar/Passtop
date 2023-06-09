import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../../services/user_services.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('Settings screen'),
          ),
          TextButton(
            onPressed: () async {
              await EasyLoading.show(status: 'Logging out...');
              await UserServices.signOut();
              await EasyLoading.dismiss();
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
