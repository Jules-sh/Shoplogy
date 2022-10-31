library models;

import 'package:flutter/material.dart' show IconData, Icons, Image;

/// The Model that represents every single
/// Item in this App.
class ShopItem {
  const ShopItem({
    required this.name,
    required this.price,
    this.description,
    this.images,
    this.icon,
    this.amount = double.infinity,
  });

  /// The Name of this Item
  final String name;

  /// The Price.
  /// Should have to digits after the point.
  final double price;

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
  final double amount;

  /// All the Items in this App.
  static final Set<ShopItem> allItems = {
    const ShopItem(
      name: 'Diamond',
      price: 100.00,
      icon: Icons.diamond,
    ),
  };
}
