import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/core/mvp/base_presenter.dart';
// import 'package:my_template/routers/fluro_navigator.dart';
import 'package:my_template/core/utils/log_utils.dart';
import 'package:my_template/core/utils/toast_utils.dart';
import 'package:my_template/core/widgets/progress_dialog_widget.dart';
import 'mvps.dart';

mixin BasePageMixin<T extends ConsumerStatefulWidget, P extends BasePresenter>
    on ConsumerState<T> implements IMvpView {
  P? presenter;

  P createPresenter();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pop(context);
      // NavigatorUtils.goBack(context);
    }
  }

  bool _isShowDialog = false;

  @override
  void showProgress() {
    /// 避免重複彈出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          barrierColor:
              const Color(0x00FFFFFF), // 默認dialog背景色為半透明黑色，這裏修改為透明（1.20添加屬性）
          builder: (_) {
            return WillPopScope(
              onWillPop: () async {
                // 攔截到返回鍵，證明dialog被手動關閉
                _isShowDialog = false;
                return Future.value(true);
              },
              child: buildProgress(),
            );
          },
        );
      } catch (e) {
        /// 異常原因主要是頁面沒有build完成就調用Progress。
        debugPrint(e.toString());
      }
    }
  }

  @override
  void showToast(String string) {
    Toast.show(string);
  }

  /// 可自定義Progress
  Widget buildProgress() => const ProgressDialog(hintText: '正在加載...');

  @override
  void didChangeDependencies() {
    presenter?.didChangeDependencies();
    Log.d('$T ==> didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    presenter?.dispose();
    Log.d('$T ==> dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    presenter?.deactivate();
    Log.d('$T ==> deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    presenter?.didUpdateWidgets<T>(oldWidget);
    Log.d('$T ==> didUpdateWidgets');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    Log.d('$T ==> initState');
    presenter = createPresenter();
    presenter?.view = this;
    presenter?.initState();
    super.initState();
  }
}
