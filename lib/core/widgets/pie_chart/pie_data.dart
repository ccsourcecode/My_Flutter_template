import 'package:flutter/material.dart';

class PieData {
  /// 顏色
  late Color color;

  /// 百分比
  late num percentage;

  /// 數量
  late int number;

  /// 名稱
  late String name;

  @override
  String toString() => 'name: $name, color: $color, '
      'number: $number, percentage: $percentage';
}
