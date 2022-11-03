library localizations;

import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show StandardTranslations;

/// Only the custom Translations used in this App.
final Map<String, Map<Locale, String>> _translations = {};

/// All the Translations used in this
/// App. Does also includes all [StandardTranslations]
Map<String, Map<Locale, String>> get translations {
  final Map<String, Map<Locale, String>> m = _translations;
  m.addAll(StandardTranslations.all);
  return m;
}
