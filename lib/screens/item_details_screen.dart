library screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart';
import 'package:shoplogy/blocs/item_details_bloc.dart';
import 'package:shoplogy/models/items/economy_item.dart';
import 'package:shoplogy/models/items/item.dart' show Item;
import 'package:shoplogy/models/items/shop_item.dart';
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
  final Item item;

  @override
  State<StatefulWidget> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  ItemDetailsBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);

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
            height: MediaQuery.of(context).size.height / 4,
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
          widget.item is ShopItem ? _amountOwned : Container(),
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
          onPressed: () => setState(() => _bloc!.amount--),
          icon: const Icon(Icons.minimize),
          color: Coloring.contrastColor(Coloring.secondaryColor),
        ),
        Text(_bloc!.amount.toStringAsFixed(2)),
        IconButton(
          onPressed: () => setState(() => _bloc!.amount++),
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
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextButton(
        onPressed: () => setState(() {
          // TODO: implement Switch
          switch (_bloc!.buy(widget.item)) {
            case BuyResponse.amountZero:
              break;
            case BuyResponse.success:
              break;
            case BuyResponse.notEnoughMoney:
              _showNotEnoughMoneyDialog();
              break;
            case BuyResponse.permissionDenied:
              _showPermissionDeniedDialog();
              break;
            case BuyResponse.invalidItem:
              break;
          }
        }),
        child: Text('Buy'.tr()),
      ),
    );
  }

  /// The Dialog shown when the
  /// User does not have the Permission to do something
  void _showPermissionDeniedDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Permission denied'.tr()),
            content: Text('You do not have the Permission to do that'.tr()),
            actions: <TextButton>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'.tr()),
              )
            ],
          );
        });
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
                  Navigator.pop(context);
                  Navigator.pop(context);
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
    final item = widget.item as ShopItem;
    if (User.currentUser.hasItem(item)) {
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
    final Item item = widget.item;
    final List<SizedBox> l = [];
    final mq = MediaQuery.of(context).size;
    if (item is ShopItem) {
      if (item.images != null) {
        for (Image i in item.images!) {
          l.add(
            SizedBox(
              height: mq.height / 4,
              width: mq.width,
              child: Center(child: i),
            ),
          );
        }
      }
    }
    if (item.icon != null) {
      l.add(
        SizedBox(
          height: mq.height / 4,
          width: mq.width,
          child: Center(
            child: Icon(item.icon, size: 200),
          ),
        ),
      );
    } else {
      l.add(
        SizedBox(
          height: mq.height / 4,
          width: mq.width,
          child: const Center(
            child: Icon(Icons.shopping_cart),
          ),
        ),
      );
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
        () {
          final Item item = widget.item;
          final String s;
          if (item is ShopItem) {
            s = '${item.pricePerPiece.toStringAsFixed(2)} €';
          } else if (item is EconomyItem) {
            switch (item.type) {
              case EconomyType.money:
                s = '${item.pricePerPiece} ${'Gems'.tr()}';
                break;
              case EconomyType.gems:
                s = '${item.pricePerPiece} Unidentified';
                break;
            }
          } else {
            s = '';
          }
          return s;
        }(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
