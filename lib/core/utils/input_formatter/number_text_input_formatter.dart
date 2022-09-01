import 'package:flutter/services.dart';

/// 數字、小數格式化（默認兩位小數）
class UsNumberTextInputFormatter extends TextInputFormatter {
  UsNumberTextInputFormatter({this.digit = 2, this.max = 1000000});

  /// 允許輸入的小數位數，-1代表不限制位數
  final int digit;

  /// 允許輸入的最大值
  final double max;

  static const double _kDefaultDouble = 0.001;

  double _strToFloat(String str, [double defaultValue = _kDefaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///獲取目前的小數位數
  int _getValueDigit(String value) {
    if (value.contains('.')) {
      return value.split('.')[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == '.') {
      value = '0.';
      selectionIndex++;
    } else if (value != '' &&
            value != _kDefaultDouble.toString() &&
            _strToFloat(value) == _kDefaultDouble ||
        _getValueDigit(value) > digit ||
        _strToFloat(value) > max) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
