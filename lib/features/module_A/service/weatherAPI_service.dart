import 'dart:developer';

import 'package:my_template/features/module_A/service/weatherAPI_provider.dart';

class WeatherAPIservice {
  final _provider = WeatherAPIProvider();

  void fetchFilm() async {
    String service = "/films/2";
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
