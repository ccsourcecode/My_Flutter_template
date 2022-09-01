
// import 'package:flutter/material.dart';
// import 'package:my_template/main_copy.dart';

// import 'package:my_template/core/services/SharedPreferencesService.dart';

// const String prefSelectedLanguageCode = "SelectedLanguageCode";
// const String prefSelectedCountryCode = "SelectedCountryCode";

// Future<Locale> setLocale(String languageCode, String countryCode) async {
//   SharedPreferencesService prefs = await SharedPreferencesService.getInstance();
//   await prefs.setString(prefSelectedLanguageCode, languageCode);
//   await prefs.setString(prefSelectedCountryCode, countryCode);
//   return _locale(languageCode, countryCode);
// }

// Future<Locale> getLocale() async {
//   SharedPreferencesService prefs = await SharedPreferencesService.getInstance();
//   String languageCode = prefs.getString(prefSelectedLanguageCode) ?? "en";
//   String countryCode = prefs.getString(prefSelectedCountryCode) ?? "US";
//   return _locale(languageCode, countryCode);
// }

// Locale _locale(String languageCode, String countryCode) {
//   return languageCode.isNotEmpty
//       ? Locale(languageCode, countryCode)
//       : const Locale('en', 'US');
// }

// void changeLanguage(BuildContext context, String selectedLanguageCode,
//     String selectedCountryCode) async {
//   var locale = await setLocale(selectedLanguageCode, selectedCountryCode);
//   MyHomePage.setLocale(context, locale);
// }
