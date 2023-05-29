import 'package:passtop/core/instances.dart';

import '../../core/imports/core_imports.dart';
import '../../core/imports/packages_imports.dart';
import '../signin_screen/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await supabase.auth.signOut();
              Get.offAll(() => const SigninScreen());
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
