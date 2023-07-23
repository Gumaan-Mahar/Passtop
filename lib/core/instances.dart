import 'imports/packages_imports.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

final supabase = Supabase.instance.client;
const uuid = Uuid();

class Preferences {
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferences? get instance => _sharedPreferences;
}
