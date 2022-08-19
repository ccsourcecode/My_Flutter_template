import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:loggy/loggy.dart';
import '../../../common/constant/serviceURL.dart';
import '../../../common/interceptors/auth_interceptor.dart';
import '../model/filmModel.dart';
import 'package:dartz/dartz.dart';
import '../model/service_failure.dart';

abstract class ApiDataSource {
  Future<Either<ServiceFailure, FilmModel>> fetchFilm(String service,
      {Map<String, dynamic>? parameters});
}

class WetherAPIprovider implements ApiDataSource {
  late Dio _dio;

  WetherAPIprovider() {
    var options = BaseOptions(
      baseUrl: APIbase,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    var dio = Dio(options);
    dio.interceptors.add(LoggyDioInterceptor(responseLevel: LogLevel.info, requestLevel: LogLevel.info, errorLevel: LogLevel.error));
    // dio.interceptors.add(AuthInterceptor());
    this._dio = dio;
  }

  @override
  Future<Either<ServiceFailure, FilmModel>> fetchFilm(String service,
      {Map<String, dynamic>? parameters}) async {
    try {
      var response = await _dio.get(service, queryParameters: parameters);
      // json_serializable
      if (response.statusCode == 200) {
        // log(
        //   "${response.data}",
        //   name: response.statusCode.toString(),
        // );
        return right(FilmModel.fromJson(response.data));
      } else {
        return left(PostFailure(
          response.statusCode,
          response.data,
        ));
      }
    } catch (error, stacktrace) {
      log("Exception occured: $error stackTrace: $stacktrace");
      log(error.toString());

      FilmModel.withError("Data not found / Connection issue");
      return left(ServerException(error));
    }
  }
}
