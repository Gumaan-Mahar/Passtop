import 'dart:io';

import '../core/imports/packages_imports.dart';
import '../core/instances.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class AuthServices {
  /// Function to generate a random 16 character string.
  static String _generateRandomString() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  static Future<AuthResponse?> continueWithGoogle() async {
    try {
      final rawNonce = _generateRandomString();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final clientId = Platform.isIOS
          ? '692485480338-nrv3rbnshc7mdvg141f3mk0l2um6gjro.apps.googleusercontent.com'
          : '692485480338-1hgfl5pjvdm21vm45aj6kmdhildgi2dh.apps.googleusercontent.com';

      final applicationId =
          Platform.isIOS ? 'com.example.passtop' : 'com.example.passtop';

      final redirectUrl = '$applicationId:/google_auth';

      /// Fixed value for google login
      const discoveryUrl =
          'https://accounts.google.com/.well-known/openid-configuration';

      const appAuth = FlutterAppAuth();

      // Authorize the user by opening the consent page
      final result = await appAuth.authorize(
        AuthorizationRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          nonce: hashedNonce,
          scopes: [
            'openid',
            'email',
            'profile',
          ],
        ),
      );

      if (result == null) {
        return null;
      }

      // Request the access and id token from Google
      final tokenResult = await appAuth.token(
        TokenRequest(
          clientId,
          redirectUrl,
          authorizationCode: result.authorizationCode,
          discoveryUrl: discoveryUrl,
          codeVerifier: result.codeVerifier,
          nonce: result.nonce,
          scopes: ['openid', 'email', 'profile'],
        ),
      );

      final idToken = tokenResult?.idToken;

      if (idToken == null) {
        return null;
      }

      EasyLoading.dismiss(); // Dismiss loading indicator

      return supabase.auth.signInWithIdToken(
        provider: Provider.google,
        idToken: idToken,
        nonce: rawNonce,
      );
    } catch (e) {
      return null; // Handle the error appropriately in your UI
    }
  }
}
