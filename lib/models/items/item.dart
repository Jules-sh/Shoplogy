library models.items;

import 'package:flutter/material.dart' show IconData;

/// The Superclass for all Items.
abstract class Item {
  const Item({
    required this.name,
    this.description = 'No Description provided',
    this.icon,
  });

  /// The Name of this Item
  final String name;

  /// A closer and more precise description of this
  /// Item.
  final String description;

  /// The Price for one single piece
  /// of this Item.
  abstract final num pricePerPiece;

  /// An optional Icon to represent this
  /// Item.
  final IconData? icon;

  /// Returns the Price for
  /// the specified [forAmount] parameter.
  num price({num forAmount = 1}) {
    return pricePerPiece * forAmount;
  }
}
