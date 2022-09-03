import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

final sembastProvider =
    Provider<Database>((_) => throw Exception('Database not initialized'));

Future createDatabase() async {
  // final appPath = await getApplicationDocumentsDirectory();
  // appPath.createSync(recursive: true);
  String filename = 'cakes.db';
  if (!kIsWeb) {
    final appDocDir = await getApplicationDocumentsDirectory();
    await appDocDir.create(recursive: true);
    databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
  } else {
    databaseFactoryWeb.openDatabase(filename);
  }
}
