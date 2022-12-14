// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ExceptionHandle {
  static const int success = 200;
  static const int success_not_content = 204;
  static const int not_modified = 304;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int not_found = 404;

  static const int net_error = 1000;
  static const int parse_error = 1001;
  static const int socket_error = 1002;
  static const int http_error = 1003;
  static const int connect_timeout_error = 1004;
  static const int send_timeout_error = 1005;
  static const int receive_timeout_error = 1006;
  static const int cancel_error = 1007;
  static const int unknown_error = 9999;

  static final Map<int, NetError> _errorMap = <int, NetError>{
    http_error: NetError(http_error, '服務器異常，請稍後重試！'),
    net_error: NetError(net_error, '網絡異常，請檢查你的網絡！'),
    socket_error: NetError(socket_error, '網絡異常，請檢查你的網絡！'),
    parse_error: NetError(parse_error, '數據解析錯誤！'),
    connect_timeout_error: NetError(connect_timeout_error, '連接超時！'),
    send_timeout_error: NetError(send_timeout_error, '請求超時！'),
    receive_timeout_error: NetError(receive_timeout_error, '響應超時！'),
    cancel_error: NetError(cancel_error, '取消請求'),
    unknown_error: NetError(unknown_error, '未知異常'),
  };

  static NetError handleException(dynamic error) {
    debugPrint(error.toString());
    if (error is DioError) {
      if (error.type.errorCode == 0) {
        return _handleException(error.error);
      } else {
        return _errorMap[error.type.errorCode]!;
      }
    } else {
      return _handleException(error);
    }
  }

  static NetError _handleException(dynamic error) {
    int errorCode = unknown_error;
    if (error is SocketException) {
      errorCode = socket_error;
    }
    if (error is HttpException) {
      errorCode = http_error;
    }
    if (error is FormatException) {
      errorCode = parse_error;
    }
    return _errorMap[errorCode]!;
  }
}

class NetError {
  NetError(this.code, this.msg);

  int code;
  String msg;
}

extension DioErrorTypeExtension on DioErrorType {
  int get errorCode => [
        ExceptionHandle.connect_timeout_error,
        ExceptionHandle.send_timeout_error,
        ExceptionHandle.receive_timeout_error,
        0,
        ExceptionHandle.cancel_error,
        0,
      ][index];
}
