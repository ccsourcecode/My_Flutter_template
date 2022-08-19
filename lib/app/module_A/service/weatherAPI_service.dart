import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../common/interceptors/auth_interceptor.dart';
import '../model/filmModel.dart';
import 'weatherAPI_provider.dart';
import 'package:dartz/dartz.dart';

class WeatherAPIservice {
  final _provider = WetherAPIprovider();

  void fetchFilm() async {
    String service = "/films/1";
    var params = {};

    final getData = await _provider.fetchFilm(service);
    getData.fold(
      (failure) => log("$failure"),
      (filmModel) {
        // log("$filmModel");
         var wx = filmModel.director;
         log("Json response: $wx");
      },
    );
  }
  
}

class NetworkError extends Error {}
