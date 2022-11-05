library screens;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart';
import 'package:shoplogy/models/shop_item.dart';
import 'package:shoplogy/models/users.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// Shows detailed Information
/// about a single [item].
class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({
    required this.item,
    super.key,
  });

  /// The Item this
  /// Screen has ti be
  /// generated for.
  final ShopItem item;

  @override
  State<StatefulWidget> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  double _amount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  /// The Appbar for this Screen.
  AppBar get _appBar {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      automaticallyImplyLeading: true,
      title: Text(widget.item.name),
    );
  }

  /// Body of this Screen.
  Scrollbar get _body {
    return Scrollbar(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: ListView(
              addSemanticIndexes: true,
              addRepaintBoundaries: true,
              addAutomaticKeepAlives: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              dragStartBehavior: DragStartBehavior.down,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              reverse: false,
              scrollDirection: Axis.horizontal,
              children: _images,
            ),
          ),
          _title,
          _price,
          _amountWanted,
          _buyButton,
          _amountOwned,
        ],
      ),
    );
  }

  /// The Amount the User wants
  /// to buy
  Widget get _amountWanted {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      textBaseline: TextBaseline.alphabetic,
      textDirection: TextDirection.ltr,
      verticalDirection: VerticalDirection.down,
      children: [
        IconButton(
          onPressed: () => setState(() => _amount--),
          icon: const Icon(Icons.minimize),
          color: Coloring.contrastColor(Coloring.secondaryColor),
        ),
        Text(_amount.toStringAsFixed(2)),
        IconButton(
          onPressed: () => setState(() => _amount++),
          icon: const Icon(Icons.add),
          color: Coloring.contrastColor(Coloring.secondaryColor),
        ),
      ],
    );
  }

  /// The Button with which the
  /// User can buy an Item
  SizedBox get _buyButton {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width / 1.2,
      child: TextButton(
        onPressed: () {
          if (_amount == 0) {
            return;
          } else {
            setState(() {
              final i = widget.item;
              i.amount = _amount;
              if (User.currentUser.buy(i)) {
                return;
              } else {
                _showNotEnoughMoneyDialog();
              }
            });
          }
        },
        child: Text('Buy'.tr()),
      ),
    );
  }

  /// Dialog shown if the User does
  /// not have enough money to buy something.
  void _showNotEnoughMoneyDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Not enough Money'.tr()),
          content: Text('You don\'t have anough money to buy this Item.'.tr()),
          actions: <TextButton>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'.tr()),
            ),
            TextButton(
                onPressed: () {
                  // TODO: add Action Code
                },
                child: Text('Buy money'.tr())),
          ],
        );
      },
    );
  }

  /// The Amount the user owns
  /// of this item.
  Text get _amountOwned {
    final String text;
    if (User.currentUser.hasItem(widget.item)) {
      text = User.currentUser.items
          .where((element) => element == widget.item)
          .first
          .amount
          .toString();
    } else {
      text = '0';
    }
    return Text(text);
  }

  /// The Images
  /// presented in the first Row
  /// of this Screen.
  List<SizedBox> get _images {
    final List<SizedBox> l = [];
    final mq = MediaQuery
        .of(context)
        .size;
    if (widget.item.images != null) {
      for (Image i in widget.item.images!) {
        l.add(SizedBox(
          height: mq.height / 4,
          width: mq.width,
          child: Center(child: i),
        ));
      }
    } else if (widget.item.icon != null) {
      l.add(SizedBox(
          height: mq.height / 4,
          width: mq.width,
          child: Center(
            child: Icon(
              widget.item.icon,
              size: 200,
            ),
          )));
    } else {
      l.add(SizedBox(
          height: mq.height / 4,
          width: mq.width,
          child: const Center(
            child: Icon(Icons.shopping_cart),
          )));
    }
    return l;
  }

  /// The Title of this Screen.
  Padding get _title {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        widget.item.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  /// The Widget representing the Price of this
  /// Item.
  Padding get _price {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        '${widget.item.pricePerOne.toStringAsFixed(2)} €',
        textAlign: TextAlign.center,
      ),
    );
  }
}
