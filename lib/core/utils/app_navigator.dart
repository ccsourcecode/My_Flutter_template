import 'package:flutter/material.dart';

/// Navigator工具類
/// 更推薦使用'routers/fluro_navigator.dart'
class AppNavigator {
  static void push(BuildContext context, Widget scene) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  /// 替換頁面 當新的頁面進入後，之前的頁面將執行dispose方法
  static void pushReplacement(BuildContext context, Widget scene) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  /// 指定頁面加入到路由中，然後將其他所有的頁面全部pop
  static void pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        ),
        (route) => false);
  }

  static void pushResult(
      BuildContext context, Widget scene, Function(Object?) function) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((dynamic result) {
      // 頁面返回result為null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      debugPrint('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// 帶參數返回
  static void goBackWithParams(BuildContext context, dynamic result) {
    Navigator.pop<dynamic>(context, result);
  }
}
