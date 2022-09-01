import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:my_template/core/home/home_page.dart';
import 'package:my_template/core/l10n/generated/my_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Listener(
          onPointerUp: (_) {
            if (Platform.isIOS) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            }
          },
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: MyLocalizations.localizationsDelegates,
            supportedLocales: MyLocalizations.supportedLocales,
            home: HomePage(),
          ),
        );
      },
    );
  }
}
