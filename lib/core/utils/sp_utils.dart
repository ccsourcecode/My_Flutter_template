

import 'package:sp_util/sp_util.dart';

import '../constants/constant.dart';

class SpUtils {
  /// T 用於區分存儲類型
  /// Example.
  /// SpHelper.putObject<int>(key, value);
  /// SpHelper.putObject<double>(key, value);
  /// SpHelper.putObject<bool>(key, value);
  /// SpHelper.putObject<String>(key, value);
  /// SpHelper.putObject<List>(key, value);
  ///
  /// SpHelper.putObject(key, UserModel);
  ///
  static void _putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.putInt(key, value as int);
        break;
      case double:
        SpUtil.putDouble(key, value as double);
        break;
      case bool:
        SpUtil.putBool(key, value as bool);
        break;
      case String:
        SpUtil.putString(key, value as String);
        break;
      case List:
        SpUtil.putStringList(key, value as List<String>);
        break;
      default:
        SpUtil.putObject(key, value);
        break;
    }
  }

  static String getThemeColor() {
    return SpUtil.getString(Constant.key_theme_color, defValue: 'deepPurpleAccent')!;
  }
}
