import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_template/core/mvp/app_widget.dart';
import 'package:flutter/foundation.dart';

void main() async {
  // var packageInfo = await PackageInfo.fromPlatform();
  var version = "logger";
  // "${packageInfo.packageName} ${packageInfo.version} (${packageInfo.buildNumber})";
  debugPrint = (String? message, {int? wrapWidth}) =>
      debugPrintSynchronouslyWithText(message, version, wrapWidth: wrapWidth);
  runApp(
    ProviderScope(
      child: AppWidget(),
    ),
  );
}

void debugPrintSynchronouslyWithText(String? message, String version,
    {int? wrapWidth}) {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String formattedDate = formatter.format(now);
  message = "[$formattedDate} - $version]: $message";
  debugPrintSynchronously(message, wrapWidth: wrapWidth);
}
