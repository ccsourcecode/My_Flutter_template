import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  final SharedPreferences _sharedPreferences;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      // 實體化 SharedPreferences
      final sharedPreferences = await SharedPreferences.getInstance();
      _instance = SharedPreferencesService._(sharedPreferences);
    }
    return _instance!;
  }

  SharedPreferencesService._(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<bool> removeString(String key) {
    return _sharedPreferences.remove(key);
  }

  Future<bool> removeAllDate(String key) {
    return _sharedPreferences.clear();
  }

  // 設定寫入 SharedPreferences 資料, 其中 key 是儲存的名字，value 是儲存的資料
  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
    // string 資料
    // await _sharedPreferences.setString(key, value);

    // boolean 資料
    // await _sharedPreferences.setBool(key, value);

    // double 資料
    // await _sharedPreferences.setDouble(key, value);

    // int 資料
    // await _sharedPreferences.setInt(key, value);

    // string list 資料
    // await _sharedPreferences.setStringList(key, value);
  }
}
