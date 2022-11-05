library models;

import 'package:flutter/material.dart' show IconData, Icons, Image;

/// The Model that represents every single
/// Item in this App.
class ShopItem {
  ShopItem({
    required this.name,
    required this.pricePerOne,
    this.description,
    this.images,
    this.icon,
    this.amount = double.infinity,
  });

  /// The Name of this Item
  final String name;

  /// The Price.
  /// Should have to digits after the point.
  final double pricePerOne;

  /// Returns the Price for
  /// the specified [forAmount] parameter.
  double price({double forAmount = 1}) {
    return pricePerOne * forAmount;
  }

  /// An optional Icon to present this
  /// Item in the Shop
  final IconData? icon;

  /// A List
  /// of different Images
  /// to present the Item.
  final Set<Image>? images;

  /// A closer and more precise
  /// Description of this Item.
  final String? description;

  /// The Amount the User has
  /// of this Object.
  double amount;

  /// All the Items in this App.
  static final Set<ShopItem> allItems = {
    ShopItem(
      name: 'Diamond',
      pricePerOne: 100.00,
      icon: Icons.diamond,
    ),
    ShopItem(
      name: 'Clock',
      pricePerOne: 20.00,
      icon: Icons.timelapse,
    ),
    ShopItem(
      name: 'Car',
      pricePerOne: 20000.00,
      icon: Icons.car_rental,
    ),
  };

  @override
  String toString() {
    return 'name:$name;amount:$amount';
  }

  factory ShopItem.fromString(String string) {
    final List<String> l = string.split(';');
    final List<String> values = [];
    for (String s in l) {
      values.add(s.split(':')[1]);
    }
    final String name = values[0];
    final double amount = double.parse(values[1]);
    final item =
        ShopItem.allItems.where((element) => element.name == name).first;
    item.amount = amount;
    return item;
  }
}
