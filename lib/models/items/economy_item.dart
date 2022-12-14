library models.items;

import 'package:flutter/material.dart' show Icons;

import 'item.dart';

enum EconomyType {
  credits,
  money,
}

/// The Class for all Economy Items.
/// These Items can be money or other
/// things, you can buy with gems
class EconomyItem extends Item {
  const EconomyItem({
    required super.name,
    required this.pricePerPiece,
    required this.value,
    super.icon,
    this.type = EconomyType.credits,
  });

  @override
  final int pricePerPiece;

  /// The Value of this Economy Item
  final int value;

  /// The Type of this
  /// Economy Item
  final EconomyType type;

  /// All the Economy Items that are
  /// available in this App.
  static final Set<EconomyItem> allItems = {
    const EconomyItem(
      name: 'Credits',
      pricePerPiece: 10,
      value: 100,
      icon: Icons.attach_money,
      type: EconomyType.credits,
    )
  };
}
