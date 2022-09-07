import 'package:flutter/material.dart';
import 'package:my_template/core/constants/images.dart';

/// 間隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {
  /// 水平間隔 Constant gap widths
  static const Widget hGap4 = SizedBox(width: Dimens.gap_p4);
  static const Widget hGap5 = SizedBox(width: Dimens.gap_p5);
  static const Widget hGap8 = SizedBox(width: Dimens.gap_p8);
  static const Widget hGap10 = SizedBox(width: Dimens.gap_p10);
  static const Widget hGap12 = SizedBox(width: Dimens.gap_p12);
  static const Widget hGap15 = SizedBox(width: Dimens.gap_p15);
  static const Widget hGap16 = SizedBox(width: Dimens.gap_p16);
  static const Widget hGap20 = SizedBox(width: Dimens.gap_p20);
  static const Widget hGap32 = SizedBox(width: Dimens.gap_p32);
  static const Widget hGap48 = SizedBox(width: Dimens.gap_p48);
  static const Widget hGap50 = SizedBox(width: Dimens.gap_p50);
  static const Widget hGap64 = SizedBox(width: Dimens.gap_p64);

  /// 垂直間隔 Constant gap heights
  static const Widget vGap4 = SizedBox(height: Dimens.gap_p4);
  static const Widget vGap5 = SizedBox(height: Dimens.gap_p5);
  static const Widget vGap8 = SizedBox(height: Dimens.gap_p8);
  static const Widget vGap10 = SizedBox(height: Dimens.gap_p10);
  static const Widget vGap12 = SizedBox(height: Dimens.gap_p12);
  static const Widget vGap15 = SizedBox(height: Dimens.gap_p15);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_p16);
  static const Widget vGap20 = SizedBox(height: Dimens.gap_p20);
  static const Widget vGap24 = SizedBox(height: Dimens.gap_p24);
  static const Widget vGap32 = SizedBox(height: Dimens.gap_p32);
  static const Widget vGap48 = SizedBox(height: Dimens.gap_p48);
  static const Widget vGap50 = SizedBox(height: Dimens.gap_p50);
  static const Widget vGap64 = SizedBox(height: Dimens.gap_p64);

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();

  /// 補充一種空Widget實現
  /// https://github.com/letsar/nil
  /// https://github.com/flutter/flutter/issues/78159
}
