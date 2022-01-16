// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }

  String get trays {
    return Intl.message("Trays", name: 'trays');
  }

  String beReadyIn(day) {
    return Intl.message("BE READY IN = ${day} DAYS", name: 'beReadyIn', args: [day]);
  }

  String get humidity {
    return Intl.message("HUMIDITY", name: 'humidity');
  }

  String get temperature {
    return Intl.message("TEMPERATURE", name: 'temperature');
  }

  String get light {
    return Intl.message("LIGHT", name: 'light');
  }

  String get healthStatus {
    return Intl.message("HEALTH STATUS", name: 'healthStatus');
  }

  String get minerals {
    return Intl.message("Minerals", name: 'minerals');
  }

  String get vitaminsAndMinerals {
    return Intl.message("VITAMINS & MINERALS", name: 'vitaminsAndMinerals');
  }

  String get aboutPlant {
    return Intl.message("ABOUT PLANT", name: 'aboutPlant');
  }

  String trayNumber(number) {
    return Intl.message("Tray ${number}", name: 'trayNumber', args: [number]);
  }

  String infoTrayPot(trayId, potId) {
    return Intl.message("TRAY ${trayId} - POT ${potId}", name: 'infoTrayPot', args: [trayId, potId]);
  }

  String get perOnePlantGrams {
    return Intl.message("per 1 plant (approx. 30 g)", name: 'perOnePlantGrams');
  }

  String grams(grams) {
    return Intl.message("${grams} g", name: 'grams', args: [grams]);
  }

  String percent(percents) {
    return Intl.message("${percents}%", name: 'percent', args: [percents]);
  }

  String F(temperature) {
    return Intl.message("${temperature} F", name: 'F', args: [temperature]);
  }

  String lux(light) {
    return Intl.message("${light} LUX", name: 'lux', args: [light]);
  }

  String pot(potId) {
    return Intl.message("pot ${potId}", name: 'pot', args: [potId]);
  }

  String get readyForHarvest {
    return Intl.message("ready for harvest", name: 'readyForHarvest');
  }

  String get all {
    return Intl.message("all", name: 'all');
  }

  String get setUpNewPots {
    return Intl.message("SET UP NEW POTS", name: 'setUpNewPots');
  }

  String get next {
    return Intl.message("NEXT", name: 'next');
  }

  String get back {
    return Intl.message("BACK", name: 'back');
  }

  String get submit {
    return Intl.message("SUBMIT", name: 'submit');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
