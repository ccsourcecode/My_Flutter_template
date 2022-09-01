import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'routers.dart';

/// fluro的路由跳轉工具類
class NavigatorUtils {
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    unfocus();
    Routes.router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native,
      routeSettings: RouteSettings(
        arguments: arguments,
      ),
    );
  }

  static void pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    unfocus();
    Routes.router
        .navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native,
      routeSettings: RouteSettings(
        arguments: arguments,
      ),
    )
        .then((Object? result) {
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
    unfocus();
    Navigator.pop(context);
  }

  /// 帶參數返回
  static void goBackWithParams(BuildContext context, Object result) {
    unfocus();
    Navigator.pop<Object>(context, result);
  }

  /// 跳到WebView頁
  static void goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持傳中文,需轉換
    push(context,
        '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  static void unfocus() {
    // 使用下面的方式，會觸發不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
