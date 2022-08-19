import 'dart:ui';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/service/SharedPreferencesService.dart';
import '../main.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String prefSelectedCountryCode = "SelectedCountryCode";

Future<Locale> setLocale(String languageCode, String countryCode) async {
  SharedPreferencesService _prefs  = await SharedPreferencesService.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  await _prefs.setString(prefSelectedCountryCode, countryCode);
  return _locale(languageCode, countryCode);
}

Future<Locale> getLocale() async {
  SharedPreferencesService _prefs  = await SharedPreferencesService.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";
  String countryCode = _prefs.getString(prefSelectedCountryCode) ?? "US";
  return _locale(languageCode, countryCode);
}

Locale _locale(String languageCode, String countryCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, countryCode)
      : Locale('en', 'US');
}

void changeLanguage(BuildContext context, String selectedLanguageCode, String selectedCountryCode) async {
  var _locale = await setLocale(selectedLanguageCode, selectedCountryCode);
  MyHomePage.setLocale(context, _locale);
}
