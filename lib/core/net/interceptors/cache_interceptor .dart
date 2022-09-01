import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  final _cache = <Uri, Response>{};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var response = _cache[options.uri];
    if (options.extra['refresh'] == true) {
      debugPrint('${options.uri}: force refresh, ignore cache! \n');
      return handler.next(options);
    } else if (response != null) {
      debugPrint('cache hit: ${options.uri} \n');
      return handler.resolve(response);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _cache[response.requestOptions.uri] = response;
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('onError: $err');
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.other) {
      var cachedResponse = _cache[err.requestOptions.path];
      if (cachedResponse != null) {
        //
      }
    }
    super.onError(err, handler);
  }
}
