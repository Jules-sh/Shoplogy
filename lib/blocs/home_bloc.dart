library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;

/// The Bloc with all the Logic for
/// the Homescreen.
class HomeBloc extends Bloc {
  /// The current Index of the
  /// Bottom Navigation Bar
  /// on the Homescreen.
  int cBnbI = 1;

  @override
  void dispose() {}
}
