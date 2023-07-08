import 'package:passtop/methods/is_password_reused.dart';

import 'is_password_common.dart';

Future<Map<String, dynamic>> calculatePasswordScore(String password) async {
  int score = 0;
  bool isBreached = true;
  bool isReused = true;

  if (password.length >= 8) {
    score += 1;
  }
  if (password.contains(RegExp(r'[A-Z]'))) {
    score += 1;
  }
  if (password.contains(RegExp(r'[a-z]'))) {
    score += 1;
  }
  if (password.contains(RegExp(r'[0-9]'))) {
    score += 1;
  }
  if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    score += 1;
  }

  if (await isPasswordBreached(password) == false) {
    isBreached = false;
    score += 1;
  }

  if (isPasswordReused(password: password) == false) {
    isReused = false;
    score += 1;
  }

  return {
    'score': score,
    'isPasswordBreached': isBreached,
    'isPasswordReused': isReused
  };
}
