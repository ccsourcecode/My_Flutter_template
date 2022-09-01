import 'package:flutter/material.dart';
import 'package:my_template/core/constants/images.dart';
import 'package:my_template/core/l10n/string_hardcoded.dart';
import 'package:my_template/core/routers/fluro_navigator.dart';
import 'package:my_template/core/utils/device_utils.dart';
import 'package:my_template/core/widgets/my_button_widget.dart';

/// 自定義dialog的模板
class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {super.key,
      this.title,
      this.onPressed,
      this.hiddenTitle = false,
      required this.child});

  final String? title;
  final VoidCallback? onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    final Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          hiddenTitle ? '' : title ?? '',
          style: TextStyles.textBold18,
        ),
      ),
    );

    final Widget bottomButton = Row(
      children: <Widget>[
        _DialogButton(
          text: '取消'.hardcoded,
          textColor: Colours.text_gray,
          onPressed: () => NavigatorUtils.goBack(context),
        ),
        const SizedBox(
          height: 48.0,
          width: 0.6,
          child: VerticalDivider(),
        ),
        _DialogButton(
          text: '確定'.hardcoded,
          textColor: Theme.of(context).primaryColor,
          onPressed: onPressed,
        ),
      ],
    );

    final Widget content = Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.vGap24,
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap8,
          Gaps.line,
          bottomButton,
        ],
      ),
    );

    final Widget body = MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Center(
        child: SizedBox(
          width: 270.0,
          child: content,
        ),
      ),
    );

    /// Android 11添加了鍵盤彈出動畫，這與我添加的過渡動畫衝突（原先iOS、Android 沒有相關過渡動畫，相關問題跟蹤：https://github.com/flutter/flutter/issues/19279）。
    /// 因為在Android 11上，viewInsets的值在鍵盤彈出過程中是變化的（以前只有開始結束的值）。
    /// 所以解決方法就是在Android 11及以上系統中使用Padding代替AnimatedPadding。

    if (Device.getAndroidSdkInt() >= 30) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: body,
      );
    } else {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic, // easeOutQuad
        child: body,
      );
    }
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.text,
    this.textColor,
    this.onPressed,
  });

  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyButton(
        text: text,
        textColor: textColor,
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
