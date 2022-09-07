import 'package:flutter/material.dart';
import 'package:my_template/core/l10n/generated/L10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  void setLocale(Locale loc) {
    if (!L10n.supportedLocales.contains(loc)) return;
    _locale = loc;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
