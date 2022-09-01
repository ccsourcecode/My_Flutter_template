import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_template/core/net/interceptors/logging_inceptor.dart';
import 'package:my_template/features/module_A/model/service_failure.dart';
import 'package:my_template/features/module_A/model/filmModel.dart';
import 'package:my_template/core/net/interceptors/auth_interceptor.dart';

class WeatherAPIProvider {
  late Dio _dio;

  WeatherAPIProvider() {
    var options = BaseOptions(
      baseUrl: "https://swapi.dev/api/films/1/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);

    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(LoggingInterceptors());
    _dio = dio;
  }

  Future<Either<ServiceFailure, FilmModel>> fetchFilm(String service,
      {Map<String, dynamic>? parameters}) async {
    try {
      final response = await _dio.get(service, queryParameters: parameters);
      if (response.statusCode == 201) {
        // json_serializable
        return right(FilmModel.fromJson(response.data));
      } else {
        // print("Exception occured: $error stackTrace: $stacktrace");
        // print(error.toString());
        return left(PostFailure(
          response.statusCode,
          response.statusMessage,
        ));
      }
    } catch (e) {
      return left(ServerException(e));
    }
  }
}
