import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_template/core/home/home_page.dart';
import 'package:my_template/core/home/webview_page.dart';
import 'package:my_template/features/module_A/screen/todo/router/todo_router.dart';
import 'package:my_template/core/routers/i_router.dart';
import 'package:my_template/core/routers/not_found_page.dart';

class Routes {
  static String home = '/home';
  static String webViewPage = '/webView';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳轉錯誤返回頁
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint('未找到目標頁');
      return const NotFoundPage();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext? context, Map<String, List<String>> params) =>
                    const HomePage()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first ?? '';
      final String url = params['url']?.first ?? '';
      return WebViewPage(title: title, url: url);
    }));

    _listRouter.clear();

    /// 各自路由由各自模塊管理，統一在此添加初始化
    _listRouter.add(TodoRouter());
    // _listRouter.add(TodoRouter());

    /// 初始化路由
    void initRouter(IRouterProvider routerProvider) {
      routerProvider.initRouter(router);
    }

    _listRouter.forEach(initRouter);
  }
}
