import 'package:flutter/foundation.dart';
import 'package:my_template/features/module_A/model/filmModel.dart';

class BaseEntity<T> {
  BaseEntity(this.data);

// Parsing the raw JSON data to the T class
  BaseEntity.fromJson(Map<String, dynamic> json) {
    final String type = T.toString();
    if (type == (FilmModel).toString()) {
      data = FilmModel.fromJson(json) as T;
    }

    debugPrint("ddd $data");

    // }
  }

  // int? code;
  // late String message;

  // nullable, so that in case of any error,
  // the server will return null instead of any actual data.
  T? data;
}

/*
  T? _generateOBJ<O>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}
*/
