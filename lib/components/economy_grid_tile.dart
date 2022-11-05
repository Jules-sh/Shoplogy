library components;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart' show Coloring;

class EconomyGridTile extends StatelessWidget {
  const EconomyGridTile({
    required this.name,
    required this.price,
    Key? key,
  }) : super(key: key);

  /// The Name of this Item.
  final String name;

  /// The Price of this
  /// Item in Gems.
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        behavior: HitTestBehavior.deferToChild,
        onTap: _onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.srcATop,
            color: Coloring.mainColor.withOpacity(.6),
            shape: BoxShape.rectangle,
            border: const BorderDirectional(),
            borderRadius: const BorderRadius.all(Radius.circular(33)),
          ),
          position: DecorationPosition.background,
          child: Column(),
        ),
      ),
    );
  }

  void _onTap() {}
}
