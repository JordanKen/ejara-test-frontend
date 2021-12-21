import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

final String defaultLocale = Platform.localeName;

class AppLocalizations {
  // localization variables
  final Locale? locale;
  Map<String, String>? localizedStrings;

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  // constructor
  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // This is a helper method that will load local specific strings from file
  // present in lang folder
  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    var currentLanguage ="${defaultLocale[0]}${defaultLocale[1]}";

    String jsonString = await rootBundle.loadString('assets/lang/${currentLanguage}.json');//locale.languageCode
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(
          key, value.toString().replaceAll(r"\'", "'").replaceAll(r"\t", " "));
    });

    return true;
  }
  String? newString(String oldString, int n) {
    if (oldString.length >= n) {
      return oldString.substring(oldString.length - n);
    } else {
      // return whatever you want
    }
  }
  // This method will be called from every widget which needs a localized text
  String? translate(String key) {
    return localizedStrings![key];
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // ignore: non_constant_identifier_names
  final String TAG = "AppLocalizations";

  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
