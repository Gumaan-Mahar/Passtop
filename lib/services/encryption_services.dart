import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:passtop/core/imports/packages_imports.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:convert/convert.dart';

import '../core/instances.dart';

class EncryptionServices {
  String hashMasterPassword(String masterPassword, String salt) {
    final masterPasswordBytes = Uint8List.fromList(utf8.encode(masterPassword));
    final saltBytes = Uint8List.fromList(utf8.encode(salt));

    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 32));
    pbkdf2.init(Pbkdf2Parameters(saltBytes, 10000, 32));

    final derivedKey = pbkdf2.process(masterPasswordBytes);

    return hex.encode(derivedKey);
  }

  Uint8List deriveEncryptionKey(String hashedMasterPassword, String salt) {
    final masterPasswordKey =
        Uint8List.fromList(hex.decode(hashedMasterPassword));
    final saltBytes = Uint8List.fromList(utf8.encode(salt));
    const iterations = 10000;
    const keyLength = 32;

    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), keyLength));
    pbkdf2.init(Pbkdf2Parameters(saltBytes, iterations, keyLength));

    final derivedKey = pbkdf2.process(masterPasswordKey);

    return derivedKey;
  }

  String encryptData(String data, Uint8List encryptionKey) {
    if (data.isEmpty) {
      throw Exception('Invalid data: Data to encrypt is empty.');
    }

    if (encryptionKey.isEmpty || encryptionKey.length != 32) {
      throw Exception(
          'Invalid encryption key: Key length must be 32 bytes (256 bits).');
    }
    log('Encryption Key: $encryptionKey');
    final key = Key(encryptionKey);
    final iv = IV.fromSecureRandom(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encryptedData = encrypter.encrypt(data, iv: iv);

    // Prepend the IV to the encrypted data
    final encryptedDataWithIV = iv.bytes + encryptedData.bytes;

    return base64.encode(encryptedDataWithIV);
  }

  String decryptData(String encryptedData, Uint8List encryptionKey) {
    if (encryptionKey.length != 32) {
      throw Exception(
          'Invalid encryption key: Key length must be 32 bytes (256 bits).');
    }
    final key = Key(encryptionKey);

    // Split the IV and encrypted data
    final encryptedDataWithIV = base64.decode(encryptedData);
    final iv = IV(encryptedDataWithIV.sublist(0, 16));
    final encryptedBytes = encryptedDataWithIV.sublist(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decryptedData =
        encrypter.decryptBytes(Encrypted(encryptedBytes), iv: iv);

    return utf8.decode(decryptedData);
  }

  String generateRandomSalt({int length = 32}) {
    final random = math.Random.secure();
    final List<int> saltCodeUnits = List.generate(length, (index) {
      return random.nextInt(256);
    });

    return String.fromCharCodes(saltCodeUnits);
  }

  Future<void> updateEncryptedPasswords({
    required String userId,
    required List<dynamic> reEncryptedPasswords,
    required Uint8List newEncryptionKey,
  }) async {
    try {
      final response = await supabase
          .from('passwords')
          .upsert(reEncryptedPasswords)
          .select();
      log('new encrypted data returned: $response');
    } catch (e) {
      
    }
  }
}
