library models;

import 'package:shoplogy/models/permissions.dart';
import 'package:shoplogy/models/shop_item.dart';

/// User class for all users
class User {
  /// Standard Constructor used
  /// for most of the Users
  User({
    required this.name,
    required this.lastname,
    Set<Permission> permissions = const {},
  }) {
    _isAdmin = false;
  }

  /// Admin Constructor used for Admins only
  User.admin({
    required this.name,
    required this.lastname,
  }) {
    _permissions = {};
    _isAdmin = true;
  }

  /// An Anonymous User.
  User.anonymous({
    this.name = '',
    this.lastname = '',
  }) {
    _isAdmin = false;
  }

  /// First Name of the User
  final String name;

  /// Last name of the User
  final String lastname;

  /// All the Items the User has
  Set<ShopItem> items = {};

  /// The Permissions this User has.
  late final Set<Permission> _permissions;

  /// Whether this User is an Admin or not.
  late final bool _isAdmin;

  /// Whether this User is an Admin or not.
  bool get isAdmin => _isAdmin;

  /// The Amount of money the user has.
  double money = 0;

  /// The Current User of this App
  static User? _currentUser;

  /// The current User of this App
  static User get currentUser => _currentUser ?? User.anonymous();

  /// Change the User
  /// from the current User to
  /// the specified [newUser].
  static void changeUser(User newUser) {
    _currentUser = newUser;
  }

  /// Whether the User
  /// exists or not.
  bool get exists {
    return name.isNotEmpty && lastname.isNotEmpty;
  }

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

  bool hasItem(ShopItem item) {
    return items.contains(item);
  }

  /// Buys an Item.
  void buy(ShopItem item) {
    items.add(item);
    money -= item.price;
  }
}
