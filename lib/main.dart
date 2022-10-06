library main;

import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart';
import 'package:shoplogy/navigation/routes.dart';
import 'package:shoplogy/screens/homescreen.dart';
import 'package:shoplogy/screens/unknown_screen.dart';
import 'package:string_translate/string_translate.dart'
    hide StandardTranslations, Translate;

void main() {
  runApp(const Shoplogy());
}

/// The Main Widget, that returns the App.
class Shoplogy extends StatefulWidget {
  const Shoplogy({Key? key}) : super(key: key);

  @override
  State<Shoplogy> createState() => _ShoplogyState();
}

class _ShoplogyState extends State<Shoplogy> {
  @override
  void initState() {
    Translation.init(
      supportedLocales: TranslationLocales.all,
      defaultLocale: TranslationLocales.english,
      // TODO: add translations
      translations: {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Shoplogy App';
    return MaterialApp(
      /* Developer Section */
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      debugShowCheckedModeBanner: true,
      debugShowMaterialGrid: false,

      /* App Section */
      // General Values
      useInheritedMediaQuery: false,
      scrollBehavior: const MaterialScrollBehavior(),
      color: Coloring.mainColor,

      // Title
      title: title,
      onGenerateTitle: (_) => title,

      // Locales
      locale: Translation.activeLocale,
      supportedLocales: Translation.supportedLocales,
      localizationsDelegates: TranslationDelegates.localizationDelegates,

      // Themes
      themeMode: Themes.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      highContrastTheme: Themes.highContrastLightTheme,
      highContrastDarkTheme: Themes.highContrastDarkTheme,

      // Routes
      initialRoute: '/',
      routes: _routes,
      onUnknownRoute: _onUnknownRoute,
    );
  }

  /// The Routes that don't need any parameters
  Map<String, Widget Function(BuildContext)> get _routes {
    return {
      Routes.homeScreen: (_) => const Homescreen(),
      Routes.unknownScreen: (_) => const UnknownScreen(),
    };
  }

  /// The Unknown Screen that is returned if
  /// a unknown Route is passed.
  MaterialPageRoute<UnknownScreen> Function(RouteSettings) get _onUnknownRoute {
    return (_) {
      return MaterialPageRoute(builder: (_) {
        return const UnknownScreen();
      });
    };
  }
}
