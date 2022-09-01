
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

/// 本項目通用的佈局（SingleChildScrollView）
/// 1.底部存在按鈕
/// 2.底部沒有按鈕
class MyScrollView extends StatelessWidget {

  /// 注意：同時存在底部按鈕與keyboardConfig配置時，為保證軟鍵盤彈出高度正常。需要在`Scaffold`使用 `resizeToAvoidBottomInset: defaultTargetPlatform != TargetPlatform.iOS,`
  /// 除非Android與iOS平台均使用keyboard_actions
  const MyScrollView({
    super.key,
    required this.children,
    this.padding,
    this.physics = const BouncingScrollPhysics(),
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.bottomButton,
    this.keyboardConfig,
    this.tapOutsideToDismiss = false,
    this.overScroll = 16.0,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics physics;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? bottomButton;
  final KeyboardActionsConfig? keyboardConfig;
  /// 鍵盤外部按下將其關閉
  final bool tapOutsideToDismiss;
  /// 默認彈起位置在TextField的文字下面，可以添加此屬性繼續向上滑動一段距離。用來露出完整的TextField。
  final double overScroll;

  @override
  Widget build(BuildContext context) {

    Widget contents = Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );

    if (defaultTargetPlatform == TargetPlatform.iOS && keyboardConfig != null) {
      /// iOS 鍵盤處理

      if (padding != null) {
        contents = Padding(
          padding: padding!,
          child: contents
        );
      }

      contents = KeyboardActions(
        isDialog: bottomButton != null,
        overscroll: overScroll,
        config: keyboardConfig!,
        tapOutsideBehavior: tapOutsideToDismiss ? TapOutsideBehavior.opaqueDismiss : TapOutsideBehavior.none,
        child: contents
      );

    } else {
      contents = SingleChildScrollView(
        padding: padding,
        physics: physics,
        child: contents,
      );
    }

    if (bottomButton != null) {
      contents = Column(
        children: <Widget>[
          Expanded(
            child: contents
          ),
          SafeArea(
            child: bottomButton!
          )
        ],
      );
    }

    return contents;
  }
}
