library components;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart' show Coloring;
import 'package:shoplogy/models/items/item.dart';
import 'package:shoplogy/navigation/routes.dart';

/// Tile to
/// represent a single
/// Item in this App.
/// Used to represent the Item in different
/// Screens.
class ItemGridTile extends StatefulWidget {
  const ItemGridTile({
    required this.item,
    super.key,
  });

  /// The Item represented.
  final Item item;

  @override
  State<StatefulWidget> createState() => _ItemGridTileState();
}

class _ItemGridTileState extends State<ItemGridTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        dragStartBehavior: DragStartBehavior.down,
        onTap: _onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.srcATop,
            color: Coloring.mainColor.withOpacity(.6),
            border: const BorderDirectional(),
            borderRadius: const BorderRadius.all(Radius.circular(33)),
            shape: BoxShape.rectangle,
          ),
          position: DecorationPosition.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            children: [
              widget.item.icon != null
                  ? Icon(
                      widget.item.icon,
                      size: 100,
                    )
                  : const Icon(
                      Icons.shopping_cart,
                      size: 100,
                    ),
              Text(
                widget.item.name,
                style: _nStyle,
              ),
              Text(widget.item.pricePerPiece.toStringAsFixed(2))
            ],
          ),
        ),
      ),
    );
  }

  /// The Textstyle applied to
  /// the Name of the Item.
  TextStyle get _nStyle {
    return const TextStyle(
      fontWeight: FontWeight.bold,
    );
  }

  /// Called when
  /// the Contaienr is
  /// clicked by the User.
  void _onTap() {
    Navigator.pushNamed(
      context,
      Routes.itemDetails,
      arguments: widget.item,
    );
  }
}
