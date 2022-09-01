import 'dart:io';

import 'package:flutter/services.dart';

/// https://github.com/flutter/flutter/issues/25511
/// 主要針對TextInput有設置maxLength且在iOS平台使用原生輸入法輸入中文時崩潰問題。
/// 使用方法：
/// TextField(
///   inputFormatters: [FixIOSTextInputFormatter()],
/// )
/// 使用後問題是輸入的拼音不展示。
///
/// 1.22已修復：https://github.com/flutter/flutter/pull/63754
@Deprecated('1.22已修復')
class FixIOSTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if (Platform.isIOS) {
      // ios Composing變化也執行format，因為在拼音階段沒有執行LengthLimitingTextInputFormatter，從拼音到漢字需要重新執行
      if (newValue.composing.isValid) {
        // ios拼音階段不執行長度限制的format
        return TextEditingValue.empty;
      }
    }
    return TextEditingValue(
      text: newValue.text,
      selection: TextSelection.collapsed(offset: newValue.selection.end),
    );
  }

}
