// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

class Constant {
  /// App運行在Release環境時，inProduction為true；
  /// 當App運行在Debug和Profile環境時，inProduction為false
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

  
  static const String keyLanguage = 'key_language';

  static const int status_success = 0;

  static const String server_address = wan_android;

  static const String wan_android = "https://www.wanandroid.com/";

  static const int type_sys_update = 1;
  static const int type_refresh_all = 5;

  static const String key_theme_color = 'key_theme_color';
  static const String key_guide = 'key_guide';
  static const String key_splash_model = 'key_splash_models';

}



class AppConfig {
  static const String appId = 'com.thl.flutterwanandroid';
  static const String appName = 'flutter_wanandroid';
  static const String version = '0.2.5';
  static const bool isDebug = kDebugMode;
}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}
