import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';

class Global {
  //初始化全局信息
  static Future init(VoidCallback callback) async {
    WidgetsFlutterBinding.ensureInitialized();
    await SpUtil.getInstance();
    callback();
    if (Platform.isAndroid) {
      // 以下兩行 設置android狀態欄為透明的沉浸。寫在組件渲染之後，是為了在渲染後進行set賦值，覆蓋狀態欄，寫在渲染之前MaterialApp組件會覆蓋掉這個值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
