library models;

import 'package:flutter/material.dart' show Icon, Icons;

/// The Model that represents every single
/// Item in this App.
class ShopItem {
  const ShopItem({
    required this.name,
    required this.price,
    this.icon,
  });

  /// The Name of this Item
  final String name;

  /// The Price.
  /// Should have to digits after the point.
  final double price;

  /// An optional Icon to present this
  /// Item in the Shop
  final Icon? icon;

  /// All the Items in this App.
  static final Set<ShopItem> allItems = {
    const ShopItem(
      name: 'Diamond',
      price: 100.00,
      icon: Icon(Icons.diamond),
    ),
  };
}
