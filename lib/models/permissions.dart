library models;

import 'package:shoplogy/secrets/keys.dart';

/// The Superclass for all Permissions
abstract class Permission {
  const Permission();

  /// Checks if the User
  /// has entered one of the right
  /// Admin Keys.
  static bool checkAdminKey(String key) {
    return AdminKeys.allKeys.contains(key);
  }
}

/// The Permission to buy Credits
class CreditsBuyPermission extends Permission {
  const CreditsBuyPermission();
}

/// The Permission to buy Money.
class MoneyBuyPermission extends Permission {
  const MoneyBuyPermission();
}
