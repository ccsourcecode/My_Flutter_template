import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:my_template/core/constants/constant.dart';

/// 捕獲全局異常，進行統一處理。
void handleError(void Function() body) {
  /// 重寫Flutter異常回調 FlutterError.onError
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!Constant.inProduction) {
      // debug時，直接將異常信息打印。
      FlutterError.dumpErrorToConsole(details);
    } else {
      // release時，將異常交由zone統一處理。
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  /// 使用runZonedGuarded捕獲Flutter未捕獲的異常
  runZonedGuarded(body, (Object error, StackTrace stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

Future<void> _reportError(Object error, StackTrace stackTrace) async {
  if (!Constant.inProduction) {
    debugPrintStack(
      stackTrace: stackTrace,
      label: error.toString(),
      maxFrames: 100,
    );
  } else {
    /// 將異常信息收集並上傳到服務器。可以直接使用類似`flutter_bugly`插件處理異常上報。
  }
}
