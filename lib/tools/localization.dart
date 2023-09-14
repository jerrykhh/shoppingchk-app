import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localization {
  Localization._privateConstructor();
  static final Localization _localization = Localization._privateConstructor();
  static const String PERFS_KEY = "locale";
  static const Map<String, String> _languages = {"English": "en", "繁體中文": "zh"};

  static Localization get instance => _localization;
  Map<String, String> get languages => _languages;

  Locale _toLocale({String langCode = "en"}) {
    switch (langCode) {
      case "en":
      case "zh":
      case "zh_HK":
        return Locale(langCode);
      default:
        throw UnimplementedError();
    }
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(PERFS_KEY) ?? 'en';
    return _toLocale(langCode: languageCode);
  }

  Future<Locale> setLocale(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PERFS_KEY, langCode);
    return _toLocale(langCode: langCode);
  }

  AppLocalizations get(BuildContext context) => AppLocalizations.of(context)!;
}
