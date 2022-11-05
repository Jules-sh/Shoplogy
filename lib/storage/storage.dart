library storage;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplogy/models/shop_item.dart';
import 'package:shoplogy/models/users.dart';

/// Contains all Methods to
/// interfere with the Storage.
class Storage {
  /// The shared Preferences for
  /// the App.
  static SharedPreferences? prefs;

  /// The Key for the User name
  static const String _usernameKEY = 'username';

  /// The Key for the User lastname
  static const String _userlastnameKEY = 'userlastname';

  /// The Key for the List of the
  /// Items the User owns.
  static const String _userItemsListKEY = 'useritems';

  /// Initializes everything needed
  /// to work with the Storage.
  /// Has to be called on the start of the Program.
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    load();
  }

  /// Stores all Data to the local Storage.
  static Future<void> store() async {
    await prefs!.setString(_usernameKEY, User.currentUser.name);
    await prefs!.setString(_userlastnameKEY, User.currentUser.lastname);
    final List<String> l = [];
    for (ShopItem item in User.currentUser.items) {
      l.add(item.toString());
    }
    await prefs!.setStringList(_userItemsListKEY, l);
  }

  /// Loads all Data from the local Storage
  static void load() {
    final User user;
    if (prefs!.getString(_usernameKEY) != null) {
      user = User(
        name: prefs!.getString(_usernameKEY)!,
        lastname: prefs!.getString(_userlastnameKEY)!,
      );

      final List<String> l = prefs!.getStringList(_userItemsListKEY)!;
      final Set<ShopItem> items = {};
      for (String s in l) {
        final item = ShopItem.fromString(s);
      }
      user.items = items;
    } else {
      user = User.anonymous();
    }
    User.changeUser(user);
  }
}
