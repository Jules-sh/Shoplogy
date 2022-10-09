library main;

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart';
import 'package:shoplogy/blocs/home_bloc.dart';
import 'package:shoplogy/models/shop_item.dart';
import 'package:shoplogy/navigation/routes.dart' show Routes;
import 'package:shoplogy/screens/homescreen.dart';
import 'package:shoplogy/screens/item_details_screen.dart';
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
      onGenerateRoute: _onGenerateRoute,
    );
  }

  /// The Routes that don't need any parameters
  Map<String, Widget Function(BuildContext)> get _routes {
    return {
      Routes.homeScreen: (_) => BlocParent(
            bloc: HomeBloc(),
            child: const Homescreen(),
          ),
      Routes.unknownScreen: (_) => const UnknownScreen(),
    };
  }

  /// contains nearly all
  /// Routes that have a
  /// parameter to pass.
  MaterialPageRoute Function(RouteSettings) get _onGenerateRoute {
    return (settings) {
      late final Widget screen;
      final dynamic args = settings.arguments;

      switch (settings.name) {
        case Routes.itemDetails:
          screen = ItemDetailsScreen(item: args as ShopItem);
          break;
        default:
          screen = const UnknownScreen();
          break;
      }
      return MaterialPageRoute(builder: (_) => screen);
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
