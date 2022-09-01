// ignore_for_file: avoid_debugPrint

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// define a simple interceptor for logging different types of requests
class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    debugPrint(
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl ?? ""}${options.path ?? ""}"}");
    debugPrint("Headers:");
    options.headers.forEach((k, v) => debugPrint('$k: $v'));
    debugPrint("queryParameters:");
    options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
    if (options.data != null) {
      debugPrint("Body: ${options.data}");
    }
    debugPrint(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    debugPrint(
        "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    debugPrint("Headers:");
    response.headers.forEach((k, v) => debugPrint('$k: $v'));
    debugPrint("Response: ${response.data}");
    debugPrint("<-- END HTTP response");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    debugPrint(
        "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.requestOptions.baseUrl + err.requestOptions.path) : 'URL')}");
    debugPrint(
        "${err.response != null ? err.response!.data : 'Unknown Error'}");
    debugPrint("<-- End http error");

    return super.onError(err, handler);
  }
}
