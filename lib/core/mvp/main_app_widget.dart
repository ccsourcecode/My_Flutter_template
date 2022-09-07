import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_template/core/constants/constant.dart';
import 'package:my_template/core/net/dio_utils.dart';
import 'package:my_template/core/net/interceptors/intercept.dart';
import 'package:my_template/core/routers/routers.dart';
import 'package:my_template/core/utils/device_utils.dart';
import 'package:my_template/core/utils/log_utils.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:sizer/sizer.dart';
import 'package:my_template/core/home/home_page.dart';
import 'package:my_template/core/l10n/generated/my_localizations.dart';
import 'package:sp_util/sp_util.dart';

import '../../config/config_reader.dart';
import '../../config/environment.dart';
import '../constants/colors.dart';
import '../net/http_utils.dart';
import '../utils/sp_utils.dart';

class MainAppWidget extends StatefulWidget {
  const MainAppWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainAppWidgetState();
  }
}

class MainAppWidgetState extends State<MainAppWidget> {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  late Locale? _locale;
  Color _themeColor = Colours.app_main;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ConfigReader.initializeApp(Environment.dev);
    Routes.initRoutes();
    Log.init();
    _initDio();
    _initQuickActions();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void _initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];

    /// 統一添加身份驗證請求頭
    // interceptors.add(AuthInterceptor());
    /// 刷新Token
    // interceptors.add(TokenInterceptor());

    /// 打印Log(生產模式去除)
    if (!Constant.inProduction) {
      interceptors.add(LoggingInterceptor());
    }

    /// 適配數據(根據自己的數據結構，可自行選擇添加)
    interceptors.add(AdapterInterceptor());
    configDio(
      // baseUrl: 'https://api.github.com/',
      interceptors: interceptors,
    );
  }

  void _initQuickActions() {
    if (Device.isMobile) {
      const QuickActions quickActions = QuickActions();
      if (Device.isIOS) {
        // Android每次是重新啟動activity，所以放在了splash_page處理。
        // 總體來説使用不方便，這種動態的方式在安卓中侷限性高。這裏僅做練習使用。
        quickActions.initialize((String shortcutType) async {
          if (shortcutType == 'demo') {
            navigatorKey.currentState?.push<dynamic>(MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const HomePage(),
            ));
          }
        });
      }

      quickActions.setShortcutItems(<ShortcutItem>[
        const ShortcutItem(
            type: 'demo', localizedTitle: 'Demo', icon: 'flutter_dash_black'),
      ]);
    }
  }

  void _loadLocale() {
    setState(() {
      LanguageModel? model =
          SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
      if (model != null) {
        _locale = Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }

      String colorKey = SpUtils.getThemeColor();
      if (themeColorMap[colorKey] != null) {
        _themeColor = themeColorMap[colorKey]!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Listener(
          onPointerUp: (_) {
            if (Platform.isIOS) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
            localizationsDelegates: MyLocalizations.localizationsDelegates,
            supportedLocales: MyLocalizations.supportedLocales,
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
