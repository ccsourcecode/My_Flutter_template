import 'package:flutter/material.dart';

import 'i_lifecycle.dart';

abstract class IMvpView {
  BuildContext getContext();

  /// 顯示Progress
  void showProgress();

  /// 關閉Progress
  void closeProgress();

  /// 展示Toast
  void showToast(String string);
}

abstract class IPresenter extends ILifecycle {}
