// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"trays" : MessageLookupByLibrary.simpleMessage("Trays"),
		"beReadyIn" : (day) => "BE READY IN = ${day} DAYS",
		"humidity" : MessageLookupByLibrary.simpleMessage("HUMIDITY"),
		"temperature" : MessageLookupByLibrary.simpleMessage("TEMPERATURE"),
		"light" : MessageLookupByLibrary.simpleMessage("LIGHT"),
		"healthStatus" : MessageLookupByLibrary.simpleMessage("HEALTH STATUS"),
		"minerals" : MessageLookupByLibrary.simpleMessage("Minerals"),
		"vitaminsAndMinerals" : MessageLookupByLibrary.simpleMessage("VITAMINS & MINERALS"),
		"aboutPlant" : MessageLookupByLibrary.simpleMessage("ABOUT PLANT"),
		"trayNumber" : (number) => "Tray ${number}",
		"infoTrayPot" : (trayId, potId) => "TRAY ${trayId} - POT ${potId}",
		"perOnePlantGrams" : MessageLookupByLibrary.simpleMessage("per 1 plant (approx. 30 g)"),
		"grams" : (grams) => "${grams} g",
		"percent" : (percents) => "${percents}%",
		"F" : (temperature) => "${temperature} F",
		"lux" : (light) => "${light} LUX",
		"pot" : (potId) => "pot ${potId}",
		"readyForHarvest" : MessageLookupByLibrary.simpleMessage("ready for harvest"),
		"all" : MessageLookupByLibrary.simpleMessage("all"),
		"setUpNewPots" : MessageLookupByLibrary.simpleMessage("SET UP NEW POTS"),
		"next" : MessageLookupByLibrary.simpleMessage("NEXT"),
		"back" : MessageLookupByLibrary.simpleMessage("BACK"),
		"submit" : MessageLookupByLibrary.simpleMessage("SUBMIT"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"en": () => Future.value(null),

};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case "en":
        return _$en;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

// ignore_for_file: unnecessary_brace_in_string_interps
