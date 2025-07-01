import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const _key = 'preferred_country';

  Future<void> save(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
  }

  Future<String> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'US';
  }
}
