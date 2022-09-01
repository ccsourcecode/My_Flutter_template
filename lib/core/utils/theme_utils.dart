import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_template/core/constants/images.dart';
import 'package:my_template/core/utils/device_utils.dart';
import 'package:rxdart/rxdart.dart';

class ThemeUtils {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color? getDarkColor(BuildContext context, Color darkColor) {
    return isDark(context) ? darkColor : null;
  }

  static Color? getIconColor(BuildContext context) {
    return isDark(context) ? Colours.dark_text : null;
  }

  static Color getStickyHeaderColor(BuildContext context) {
    return isDark(context) ? Colours.dark_bg_gray_ : Colours.bg_gray_;
  }

  static Color getDialogTextFieldColor(BuildContext context) {
    return isDark(context) ? Colours.dark_bg_gray_ : Colours.bg_gray;
  }

  static Color? getKeyboardActionsColor(BuildContext context) {
    return isDark(context) ? Colours.dark_bg_color : Colors.grey[200];
  }

  static StreamSubscription<dynamic>? _subscription;

  /// 設置NavigationBar樣式，使得導航欄顏色與深色模式的設置相符。
  static void setSystemNavigationBar(ThemeMode mode) {
    /// 主題切換動畫（AnimatedTheme）時間為200毫秒，延時設置導航欄顏色，這樣過渡相對自然。
    _subscription?.cancel();
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 200)).listen((_) {
      bool isDark = false;
      if (mode == ThemeMode.dark ||
          (mode == ThemeMode.system &&
              window.platformBrightness == Brightness.dark)) {
        isDark = true;
      }
      setSystemBarStyle(isDark: isDark);
    });
  }

  /// 設置StatusBar、NavigationBar樣式。(僅針對安卓)
  /// 本項目在android MainActivity中已設置，不需要覆蓋設置。
  static void setSystemBarStyle({bool? isDark}) {
    if (Device.isAndroid) {
      final bool isDarkMode =
          isDark ?? window.platformBrightness == Brightness.dark;
      debugPrint('isDark: $isDarkMode');
      final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        /// 透明狀態欄
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDarkMode ? Colours.dark_bg_color : Colors.white,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

extension ThemeExtension on BuildContext {
  bool get isDark => ThemeUtils.isDark(this);
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get dialogBackgroundColor => Theme.of(this).canvasColor;
}
