import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:my_template/core/net/base_response.dart';
import 'package:my_template/core/net/error_handle.dart';
import 'package:my_template/core/constants/constant.dart';
import 'package:my_template/core/utils/log_utils.dart';

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚舉替代 switch判斷取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
    required this.options,
    required this.pem,
    required this.pKCSPath,
    required this.pKCSPwd,
  });

  /// BaseResp [String status] 字段 key, 默認：status.
  String status;

  /// BaseResp [int code] 字段 key, 默認：errorCode.
  String code;

  /// BaseResp [String msg] 字段 key, 默認：errorMsg.
  String msg;

  /// BaseResp [T data] 字段 key, 默認：data.
  String data;

  /// Options.
  Options options;

  /// 詳細使用請查看dio官網 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https證書校驗.
  /// PEM證書內容.
  String pem;

  /// 詳細使用請查看dio官網 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https證書校驗.
  /// PKCS12 證書路徑.
  String pKCSPath;

  /// 詳細使用請查看dio官網 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https證書校驗.
  /// PKCS12 證書密碼.
  String pKCSPwd;
}

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
    Log.d("Hit dioUtil DioUtils constructor");
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
    //? proxy all request to localhost:8888
//        return 'PROXY 10.41.0.132:8888';
//      };
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) => true;
//    };

    /// 添加攔截器
    void addInterceptor(Interceptor interceptor) {
      Log.d("Hit dioUtil addInterceptor");
      _dio.interceptors.add(interceptor);
    }

    _interceptors.forEach(addInterceptor);
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  /// 是否是debug模式.
  static bool _isDebug = false;

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  /// BaseResp [String status] 字段 key, 默認：status.
  String _statusKey = "status";

  /// BaseResp [int code] 字段 key, 默認：errorCode.
  String _codeKey = "code";

  /// BaseResp [String msg] 字段 key, 默認：errorMsg.
  String _msgKey = "message";

  /// BaseResp [T data] 字段 key, 默認：data.
  String _dataKey = "data";

  /// Options.
  final BaseOptions _options = getDefOptions();

  /// PEM證書內容.
  late String _pem;

  /// PKCS12 證書路徑.
  late String _pKCSPath;

  /// PKCS12 證書密碼.
  late String _pKCSPwd;

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
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ).then<void>((BaseResp<T> result) {
      if (result.data != null) {
        var data = result.data;
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

/*
  // 數據返回格式統一，統一處理異常
  Future<BaseResp<T>> _requestX<T>(
    String method,
    String url, {
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    debugPrint('URL: $url');
    final Response<String> response = await _dio.request<String>(
      url,
      data: params,
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
        Log.e('STATUS: ${e.response?.statusCode}');
        Log.e('DATA: ${e.response?.data}');
        Log.e('HEADERS: ${e.response?.headers}');
        throw Exception('數據解析錯誤！');
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        Log.e(e.message);
        throw Exception('數據解析錯誤 1！');
      }
    } catch (e) {
      debugPrint('Json parsing error');
      Log.e(e.toString());
      throw Exception('數據解析錯誤 2！');
    }
    // return BaseEntity<T>(ExceptionHandle.parse_error, '數據解析錯誤！', null);
  }
*/

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
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    )).asBroadcastStream().listen((result) {
      if (result.data != null) {
        var data = result.data;
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

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseResp<T> 返回 status code, msg, data .
  /// 數據返回格式統一，統一處理異常
  Future<BaseResp<T>> _request<T>(
    String method,
    String url, {
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    debugPrint('URL: $url');
    Response response = await _dio.request(url,
        data: params,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printHttpLog(response);
    String status;
    int code;
    String msg;
    T data;
    // Http code: 200 or 201
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          // status = (response.data[_statusKey] is int)
          //     ? response.data[_statusKey].toString()
          //     : response.data[_statusKey];
          code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          msg = response.data[_msgKey];
          data = response.data[_dataKey];
        } else {
          final String dataString = response.data.toString();
          final bool isCompute =
              !Constant.isDriverTest && dataString.length > 10 * 1024;
          debugPrint('isCompute: $isCompute');
          final Map<String, dynamic> dataMap = isCompute
              ? await compute(_parseData, response)
              : _parseData(response);
          // status = (dataMap[_statusKey] is int)
          //     ? dataMap[_statusKey].toString()
          //     : dataMap[_statusKey];
          code = (dataMap[_codeKey] is String)
              ? int.tryParse(dataMap[_codeKey])
              : dataMap[_codeKey];
          msg = dataMap[_msgKey];
          data = dataMap[_dataKey];
        }
        return BaseResp(code, msg, data);
      } catch (e) {
        return Future.error(DioError(
          requestOptions: RequestOptions(path: url),
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.response,
        ));
      }
    }
    return Future.error(DioError(
      requestOptions: RequestOptions(path: url),
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.response,
    ));
  }

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseRespR<T> 返回 status code, msg, data, response.
  Future<BaseRespR<T>> requestR<T>(
    String method,
    String url, {
    Object? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Response response = await _dio.request(url,
        data: params,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printHttpLog(response);
    String status;
    int code;
    String msg;
    T data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          // status = (response.data[_statusKey] is int)
          //     ? response.data[_statusKey].toString()
          //     : response.data[_statusKey];
          code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          msg = response.data[_msgKey];
          data = response.data[_dataKey];
        } else {
          /// 集成測試無法使用 isolate https://github.com/flutter/flutter/issues/24703
          /// 使用compute條件：數據大於10KB（粗略使用10 * 1024）且當前不是集成測試（後面可能會根據Web環境進行調整）
          /// 主要目的減少不必要的性能開銷
          final String dataString = response.data[_dataKey].toString();
          final bool isCompute =
              !Constant.isDriverTest && dataString.length > 10 * 1024;
          debugPrint('isCompute: $isCompute');
          final Map<String, dynamic> dataMap = isCompute
              ? await compute(_parseData, response)
              : _parseData(response);
          // status = (dataMap[_statusKey] is int)
          //     ? dataMap[_statusKey].toString()
          //     : dataMap[_statusKey];
          code = (dataMap[_codeKey] is String)
              ? int.tryParse(dataMap[_codeKey])
              : dataMap[_codeKey];
          msg = dataMap[_msgKey];
          data = dataMap[_dataKey];
        }
        return BaseRespR(code, msg, data, response);
      } catch (e) {
        return Future.error(DioError(
          requestOptions: RequestOptions(path: url),
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.response,
        ));
      }
    }
    return Future.error(DioError(
      requestOptions: RequestOptions(path: url),
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.response,
    ));
  }

  /// Download the file and save it in local. The default http method is "GET",you can custom it by [Options.method].
  /// [urlPath]: The file url.
  /// [savePath]: The path to save the downloading file later.
  /// [onProgress]: The callback to listen downloading progress.please refer to [onReceiveProgress].
  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    data,
    Options? options,
  }) {
    return _dio.download(urlPath, savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        data: data,
        options: options);
  }

  /// decode response data.
  Map<String, dynamic> _parseData(Response response) {
    if (response.data == null || response.data.toString().isEmpty) {
      return {};
    }
    return json.decode(response.data.toString());
  }

  /// check Options.
  Options _checkOptions(method, options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  /// merge Option.
  void _mergeOption(Options opt) {
    _options.method = opt.method ?? _options.method;
    _options.receiveDataWhenStatusError =
        opt.receiveDataWhenStatusError ?? _options.receiveDataWhenStatusError;
    _options.sendTimeout = opt.sendTimeout ?? _options.sendTimeout;
    _options.receiveTimeout = opt.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = opt.responseType ?? _options.responseType;
    // _options.headers = (Map.from(_options.headers))..addAll(opt.headers);
    // _options.data = opt.data ?? _options.data;
    // _options.extra = (Map.from(_options.extra))..addAll(opt.extra);
    _options.contentType = opt.contentType ?? _options.contentType;
    _options.validateStatus = opt.validateStatus ?? _options.validateStatus;
    _options.followRedirects = opt.followRedirects ?? _options.followRedirects;
    _options.maxRedirects = opt.maxRedirects ?? _options.maxRedirects;
    _options.requestEncoder = opt.requestEncoder ?? _options.requestEncoder;
    _options.responseDecoder = opt.responseDecoder ?? _options.responseDecoder;
    _options.listFormat = opt.listFormat ?? _options.listFormat;
  }

  /// print Http Log.
  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------\n[statusCode]:"
          "   ${response.statusCode}\n[request   ]:   ${_getOptionsStr(response.requestOptions)}");
      _printDataStr("Request data: ", response.requestOptions.data);
      _printDataStr("Response: ", response.data);
    } catch (ex) {
      print("Http Log" " error......");
    }
  }

  /// get Options Str.
  String _getOptionsStr(RequestOptions request) {
    return "method: ${request.method} | baseUrl: ${request.baseUrl} | path: ${request.path}";
  }

  /// print Data Str.
  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   ${da.substring(0, 512)}");
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   $da");
        da = "";
      }
    }
  }

  void setCookie(String cookie) {
    Map<String, dynamic> headers = {};
    headers["Cookie"] = cookie;
    _dio.options.headers.addAll(headers);
  }

  /// set Config.
  void setConfig(HttpConfig config) {
    _statusKey = config.status ?? _statusKey;
    _codeKey = config.code ?? _codeKey;
    _msgKey = config.msg ?? _msgKey;
    _dataKey = config.data ?? _dataKey;
    _mergeOption(config.options);
    _pem = config.pem ?? _pem;
    _dio.options = _options;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        if (cert.pem == _pem) {
          // 證書一致，則放行
          return true;
        }
        return false;
      };
      return null;
    };
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      SecurityContext sc = SecurityContext();
      //file為證書路徑
      sc.setTrustedCertificates(_pKCSPath, password: _pKCSPwd);
      HttpClient httpClient = HttpClient(context: sc);
      return httpClient;
    };
  }

  /// get Def Options.
  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    options.sendTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    return options;
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}
