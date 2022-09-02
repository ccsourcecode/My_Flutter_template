import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_template/core/net/base_entity.dart';
import 'package:my_template/core/net/error_handle.dart';
import 'package:my_template/core/constants/constant.dart';
import 'package:my_template/core/utils/log_utils.dart';

/// 默認dio配置
int _connectTimeout = 15000;
int _receiveTimeout = 15000;
int _sendTimeout = 1000;
String _baseUrl = 'https://swapi.dev/api/';
List<Interceptor> _interceptors = [];

/// 初始化Dio配置
void configDio({
  int? connectTimeout,
  int? receiveTimeout,
  int? sendTimeout,
  String? baseUrl,
  List<Interceptor>? interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

typedef NetSuccessCallback<T> = Function(T data);
typedef NetSuccessListCallback<T> = Function(List<T> data);
typedef NetErrorCallback = Function(int code, String msg);

/// @weilu https://github.com/simplezhli
class DioUtils {
  factory DioUtils() => _singleton;

  DioUtils._() {
    debugPrint("hit dioUtil const");
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,

      /// dio默認json解析，這裏指定返回UTF8字符串，自己處理解析。（可也以自定義Transformer實現）
      responseType: ResponseType.plain,
      validateStatus: (_) {
        // 不使用http狀態碼判斷狀態，使用AdapterInterceptor來處理（適用於標準REST風格）
        return true;
      },
      baseUrl: _baseUrl,
//      contentType: Headers.formUrlEncodedContentType, // 適用於post form表單提交
    );

    _dio = Dio(options);

    /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (HttpClient client) {
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return 'PROXY 10.41.0.132:8888';
//      };
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) => true;
//    };

    /// 添加攔截器
    void addInterceptor(Interceptor interceptor) {
      debugPrint("hit dioUtil addInterceptor");
      _dio.interceptors.add(interceptor);
    }

    _interceptors.forEach(addInterceptor);
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  // 數據返回格式統一，統一處理異常
  Future<BaseEntity<T>> _request<T>(
    String method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );
    try {
      final String data = response.data.toString();

      /// 集成測試無法使用 isolate https://github.com/flutter/flutter/issues/24703
      /// 使用compute條件：數據大於10KB（粗略使用10 * 1024）且當前不是集成測試（後面可能會根據Web環境進行調整）
      /// 主要目的減少不必要的性能開銷
      final bool isCompute = !Constant.isDriverTest && data.length > 10 * 1024;
      debugPrint('isCompute: $isCompute');
      final Map<String, dynamic> map =
          isCompute ? await compute(parseData, data) : parseData(data);
      return BaseEntity<T>.fromJson(map);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of "2xx" and is also not "304".
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
        throw Exception('數據解析錯誤！');
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
        throw Exception('數據解析錯誤！');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('數據解析錯誤！');
    }
    // return BaseEntity<T>(ExceptionHandle.parse_error, '數據解析錯誤！', null);
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  Future<dynamic> requestNetwork<T>(
    Method method,
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    return _request<T>(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ).then<void>((BaseEntity<T> result) {
      if (result.data != null) {
        var data = result.data as T;
        onSuccess?.call(data);
      } else {
        _onError(9999, "Got error...", onError);
      }
    }, onError: (dynamic e) {
      _cancelLogdebugPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  /// 統一處理(onSuccess返回T對象，onSuccessList返回 List<T>)
  void asyncRequestNetwork<T>(
    Method method,
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    Stream.fromFuture(_request<T>(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    )).asBroadcastStream().listen((result) {
      if (result.data != null) {
        var data = result.data as T;
        if (onSuccess != null) {
          onSuccess(data);
        }
      } else {
        _onError(9999, "Got error...", onError);
      }
    }, onError: (dynamic e) {
      _cancelLogdebugPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  void _cancelLogdebugPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e('取消請求接口： $url');
    }
  }

  void _onError(int? code, String msg, NetErrorCallback? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知異常';
    }
    Log.e('接口請求異常： code: $code, msg: $msg');
    onError?.call(code, msg);
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚舉替代 switch判斷取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
