import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  final SharedPreferences _sharedPreferences;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      _instance = SharedPreferencesService._(sharedPreferences);
    }
    return _instance!;
  }

  SharedPreferencesService._(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  String? getString(String key) {
    var x = _sharedPreferences.getString(key);
    return _sharedPreferences.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }
}
