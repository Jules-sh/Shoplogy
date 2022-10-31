library models;

import 'package:shoplogy/models/permission.dart';
import 'package:shoplogy/models/shop_item.dart';

/// User class for all users
abstract class User {
  /// Standard Constructor used
  /// for most of the Users
  User({
    required this.name,
    required this.lastname,
    required this.items,
    Set<Permission> permissions = const {},
  });

  /// Admin Constructor used for Admins only
  User.admin({
    required this.name,
    required this.lastname,
    required this.items,
  }) {
    _permissions = {};
  }

  /// First Name of the User
  final String name;

  /// Last name of the User
  final String lastname;

  /// All the Items the User has
  final Set<ShopItem> items;

  /// The Permissions this User has.
  late final Set<Permission> _permissions;

  /// The Amount of money the user has.
  double money = 0;

  /// Whether the User has the Permission
  /// to execute a specific action.
  /// Check it by passing the required
  /// permission for that action.
  bool checkPermission(Permission p) {
    return _permissions.contains(p);
  }

  /// Adds Money to the Users "Account Balance"
  void addMoney(double amount) {
    money += amount;
  }

  /// Buys an Item.
  void buy(ShopItem item) {
    items.add(item);
    money -= item.price;
  }
}
