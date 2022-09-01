import 'package:flutter/services.dart';

class VersionUtils {
  static const MethodChannel _kChannel = MethodChannel('version');

  /// 應用安裝
  static void install(String path) {
    _kChannel.invokeMethod<void>('install', {'path': path});
  }

  /// AppStore跳轉
  static void jumpAppStore() {
    _kChannel.invokeMethod<void>('jumpAppStore');
  }
}
