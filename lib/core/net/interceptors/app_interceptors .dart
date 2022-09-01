import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// https://gpalma.pt/blog/dio-interceptors/
class AppInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // dio.get("/todos/1", options: Options(headers: {"requiresToken" : true}));

    if (options.headers.containsKey("requiresToken")) {
      //remove the auxiliary header
      options.headers.remove("requiresToken");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var header = prefs.get("Header");
      var token = prefs.get("token");

      // Adding dynamic headers
      options.headers.addAll({"Header": "$header${DateTime.now()}"});
      options.headers.addAll({"Token": "$token${DateTime.now()}"});

      super.onRequest(options, handler);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.message.contains("ERROR_001")) {
      // this will push a new route and remove all the routes that were present
      // navigatorKey.currentState.pushNamedAndRemoveUntil(
      //     "/login", (Route<dynamic> route) => false);
    }

    // message: "User is no longer active";

    super.onError(
        DioError(requestOptions: RequestOptions(path: err.requestOptions.path)),
        handler);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // Verifying the Response
    if (response.headers.value("verifyToken") != null) {
      //if the header is present, then compare it with the Shared Prefs key
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var verifyToken = prefs.get("VerifyToken");

      // if the value is the same as the header, continue with the request
      if (response.headers.value("verifyToken") == verifyToken) {
        super.onResponse(response, handler);
      }
    }
    super.onResponse(response, handler);
  }
}
