import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_template/core/utils/toast_utils.dart';

/// 雙擊返回退出
class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2500),
  });

  final Widget child;

  /// 兩次點擊返回按鈕的時間間隔
  final Duration duration;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      Toast.show('再次點擊退出應用');
      return Future.value(false);
    }
    Toast.cancelToast();

    /// 不推薦使用 `dart:io` 的 exit(0)
    await SystemNavigator.pop();
    return Future.value(true);
  }
}
