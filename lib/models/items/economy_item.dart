library models.items;

import 'item.dart';

/// The Class for all Economy Items.
/// These Items can be money or other
/// things, you can buy with gems
class EconomyItem extends Item {
  const EconomyItem({
    required super.name,
    required this.pricePerPiece,
    super.icon,
  });

  @override
  final int pricePerPiece;

  /// All the Economy Items that are
  /// available in this App.
  static final Set<EconomyItem> allItems = {};
}
