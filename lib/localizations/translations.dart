library localizations;

import 'dart:ui' show Locale;

import 'package:string_translate/string_translate.dart'
    show StandardTranslations, TranslationLocales;

/// Only the custom Translations used in this App.
final Map<String, Map<Locale, String>> _translations = {
  'Search something...': {
    TranslationLocales.german: 'Suche etwas...',
  }
};

/// All the Translations used in this
/// App. Does also includes all [StandardTranslations]
Map<String, Map<Locale, String>> get translations {
  final Map<String, Map<Locale, String>> m = _translations;
  m.addAll(StandardTranslations.all);
  return m;
}
