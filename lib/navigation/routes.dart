library navigation;

import 'package:shoplogy/screens/user_screen.dart';

import '../screens/homescreen.dart';
import '../screens/item_details_screen.dart';
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

  /// Route Name
  /// for the [ItemDetailsScreen].
  static const Route itemDetails = '/itemDetails';

  /// Route Name for the
  /// [UserScreen]
  static const Route userScreen = '/user';
}
