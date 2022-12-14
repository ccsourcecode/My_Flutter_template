import 'package:flutter/material.dart';
import '../localization/language/language_tc.dart';
import '../localization/language/language_en.dart';

import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tc'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    print("!!!!4");
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'tc':
        return LanguageTc();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
