library models.items;

import 'package:flutter/material.dart' show Icons, Image;

import 'item.dart';

/// The Model that represents every single
/// Item in this App.
class ShopItem extends Item with ExtendedItemMixin {
  ShopItem({
    required super.name,
    required this.pricePerPiece,
    this.description,
    this.images,
    super.icon,
    this.amount = double.infinity,
  });

  @override
  final double pricePerPiece;

  /// A List
  /// of different Images
  /// to present the Item.
  final Set<Image>? images;

  @override
  final String? description;

  /// The Amount the User has
  /// of this Object.
  double amount;

  /// All the Items in this App.
  static final Set<ShopItem> allItems = {
    ShopItem(
      name: 'Diamond',
      pricePerPiece: 100.00,
      icon: Icons.diamond,
    ),
    ShopItem(
      name: 'Clock',
      pricePerPiece: 20.00,
      icon: Icons.timelapse,
    ),
    ShopItem(
      name: 'Car',
      pricePerPiece: 20000.00,
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
