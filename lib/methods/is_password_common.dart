import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'dart:convert';

Future<bool> isPasswordBreached(String password) async {
  final hash = sha1Hash(password);
  final prefix = hash.substring(0, 5);
  final suffix = hash.substring(5).toUpperCase();

  final response =
      await http.get(Uri.parse('https://api.pwnedpasswords.com/range/$prefix'));

  if (response.statusCode == 200) {
    final hashSuffixes = LineSplitter.split(response.body)
        .map((line) => line.split(':'))
        .where((parts) => parts.length == 2);
    final matchingHashes = hashSuffixes.where((parts) => parts[0] == suffix);

    return matchingHashes.isNotEmpty;
  }

  return false;
}

String sha1Hash(String input) {
  final bytes = utf8.encode(input);
  final digest = sha1.convert(bytes);
  return digest.toString();
}
