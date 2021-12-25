import 'dart:async';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:alien_mates/utils/localization/languages/en.dart';
import 'package:alien_mates/utils/localization/languages/kr.dart';

class AppLocalizations {
  static bool? showCode = false;
  static bool showUserInputCode = false;
  static String? languageCode = 'en';

  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> get langCode => _localizedValues;
  static set langCode(Map<String, Map<String, String>> data) {
    _localizedValues = data;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': EnglishLocale.EN,
    'kr': KoreanLocale.KR,
  };

  String? getString(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    if (_localizedValues[AppLocalizations.languageCode!]!.containsKey(value)) {
      var text = _localizedValues[AppLocalizations.languageCode!]![value];
      if (showCode!) {
        var code = showUserInputCode ? value : _localizedValues['code']![value];
        return '[$code]$text';
      }

      return text;
    } else {
      // 다국어 번역 확인이 필요할 경우 아래 주석 풀 것
      // developer.log(
      // 'I18N string not found: [${AppLocalizations.languageCode}]$value');
    }

    return value;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ko'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
