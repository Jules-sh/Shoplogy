library navigation;

import '../screens/homescreen.dart';
import '../screens/unknown_screen.dart';

/// The Type for all Routes in this App
typedef Route = String;

/// Contains nearly all Routes used
/// in this App.
class Routes {
  /// The Route Name for the
  /// [UnknownScreen] in this App
  static const Route unknownScreen = 'unknown';

  /// The Route Name for
  /// the [Homescreen] in this App.
  static const Route homeScreen = '/';
}
