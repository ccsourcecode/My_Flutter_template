import 'dart:convert' as convert;
import 'package:common_utils/common_utils.dart';
import 'package:intl/intl.dart';
import 'package:my_template/core/constants/constant.dart';

/// 輸出Log工具類
class Log {
  static const String tag = '*LOG*';

  /*  open emoji panel for windows OS: win + .
  📕: error message 🚀
  📙: warning message
  📗: ok status message
  📘: action message
  📓: canceled status message
  📔: Or anything you like and want to recognize immediately by color
  */

  static void init() {
    LogUtil.init(isDebug: !Constant.inProduction);
  }

  static void d(String msg, {String tag = tag}) {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    String formattedTime = formatter.format(now);
    if (!Constant.inProduction) {
      LogUtil.d(msg, tag: '📗 $formattedTime');
    }
  }

  static void v(String msg, {String tag = tag}) {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    String formattedTime = formatter.format(now);
    if (!Constant.inProduction) {
      LogUtil.v(msg, tag: '📘 $formattedTime');
    }
  }

  static void e(String msg, {String tag = tag}) {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    String formattedTime = formatter.format(now);
    if (!Constant.inProduction) {
      LogUtil.e(msg, tag: '📕 $formattedTime');
    }
  }

  static void json(String msg, {String tag = tag}) {
    print('📔 json');
    if (!Constant.inProduction) {
      try {
        final dynamic data = convert.json.decode(msg);
        if (data is Map) {
          _printMap(data);
        } else if (data is List) {
          _printList(data);
        } else {
          LogUtil.v(msg, tag: tag);
        }
      } catch (e) {
        LogUtil.e(msg, tag: tag);
      }
    }
  }

  // https://github.com/Milad-Akarie/pretty_dio_logger
  static void _printMap(Map<dynamic, dynamic> data,
      {String tag = tag,
      int tabs = 1,
      bool isListItem = false,
      bool isLast = false}) {
    print('📔 Map');
    final bool isRoot = tabs == 1;
    final String initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) {
      LogUtil.v('$initialIndent{', tag: tag);
    }

    data.keys.toList().asMap().forEach((index, dynamic key) {
      final bool isLast = index == data.length - 1;
      dynamic value = data[key];
      if (value is String) {
        value = '"$value"';
      }
      if (value is Map) {
        if (value.isEmpty) {
          LogUtil.v('${_indent(tabs)} $key: $value${!isLast ? ',' : ''}',
              tag: tag);
        } else {
          LogUtil.v('${_indent(tabs)} $key: {', tag: tag);
          _printMap(value, tabs: tabs);
        }
      } else if (value is List) {
        if (value.isEmpty) {
          LogUtil.v('${_indent(tabs)} $key: ${value.toString()}', tag: tag);
        } else {
          LogUtil.v('${_indent(tabs)} $key: [', tag: tag);
          _printList(value, tabs: tabs);
          LogUtil.v('${_indent(tabs)} ]${isLast ? '' : ','}', tag: tag);
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        LogUtil.v('${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}', tag: tag);
      }
    });

    LogUtil.v('$initialIndent}${isListItem && !isLast ? ',' : ''}', tag: tag);
  }

  static void _printList(List<dynamic> list, {String tag = tag, int tabs = 1}) {
    print('📔 List');
    list.asMap().forEach((i, dynamic e) {
      final bool isLast = i == list.length - 1;
      if (e is Map) {
        if (e.isEmpty) {
          LogUtil.v('${_indent(tabs)}  $e${!isLast ? ',' : ''}', tag: tag);
        } else {
          _printMap(e, tabs: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        LogUtil.v('${_indent(tabs + 2)} $e${isLast ? '' : ','}', tag: tag);
      }
    });
  }

  static String _indent([int tabCount = 1]) => '  ' * tabCount;
}
