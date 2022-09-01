import 'dart:async';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:my_template/features/module_A/screen/todo/router/todo_router.dart';
import 'package:my_template/core/home/home_page.dart';
import 'package:my_template/core/constants/constant.dart';
import 'package:my_template/core/routers/fluro_navigator.dart';
import 'package:my_template/core/utils/app_navigator.dart';
import 'package:my_template/core/utils/device_utils.dart';
import 'package:my_template/core/utils/image_utils.dart';
import 'package:my_template/core/utils/theme_utils.dart';
import 'package:my_template/core/widgets/fractionally_aligned_sized_box_widget.dart';
import 'package:my_template/core/widgets/load_image_widget.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sp_util/sp_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      await Device.initDeviceInfo();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)!) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        void _precacheImage(String image) {
          precacheImage(
              ImageUtils.getAssetImage(image, format: ImageFormat.webp),
              context);
        }

        _guideList.forEach(_precacheImage);
      }
      _initSplash();
    });

    /// 设置桌面端窗口大小
    if (Device.isDesktop) {
      DesktopWindow.setWindowSize(const Size(400, 800));
    }
    if (Device.isAndroid) {
      const QuickActions quickActions = QuickActions();
      quickActions.initialize((String shortcutType) async {
        if (shortcutType == 'demo') {
          AppNavigator.pushReplacement(context, const HomePage());
          _subscription?.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 1500)).listen((_) {
      _goLogin();

      if (SpUtil.getBool(Constant.keyGuide, defValue: true)! ||
          Constant.isDriverTest) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, TodoRouter.homePage, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    print("at page 2 splash screen");

    return Material(
        color: context.backgroundColor,
        child: _status == 0
            ? const FractionallyAlignedSizedBox(
                heightFactor: 0.3,
                widthFactor: 0.33,
                leftFactor: 0.33,
                bottomFactor: 0,
                child: LoadAssetImage('logo'))
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: false,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    format: ImageFormat.webp,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goLogin();
                  }
                },
              ));
  }
}
