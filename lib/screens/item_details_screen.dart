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
  /// Screen has to be
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
          _description,
          const Spacer(),
          _price,
          _amountWanted,
          _buyButton,
          widget.item is ShopItem ? _amountOwned : Container(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  /// The Amount the User wants
  /// to buy
  Row get _amountWanted {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      textBaseline: TextBaseline.alphabetic,
      textDirection: TextDirection.ltr,
      verticalDirection: VerticalDirection.down,
      children: [
        IconButton(
          onPressed:
              _bloc!.amount > 1 ? () => setState(() => _bloc!.amount--) : null,
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

  /// Returns the Description
  /// of the Item if the Item
  /// Type provides it.
  Text get _description {
    return Text(widget.item.description);
  }

  /// The Button with which the
  /// User can buy an Item
  SizedBox get _buyButton {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextButton(
        onPressed: () async {
          if (await _showConfirmationDialog()) {
            setState(() {
              // TODO: implement Switch
              switch (_bloc!.buy(widget.item)) {
                case BuyResponse.amountZero:
                  // Cannot happen anymore.
                  break;
                case BuyResponse.success:
                  return;
                case BuyResponse.notEnoughMoney:
                  _showNotEnoughMoneyDialog();
                  break;
                case BuyResponse.permissionDenied:
                  _showPermissionDeniedDialog();
                  break;
                case BuyResponse.invalidItem:
                  _showErrorDialog();
                  break;
              }
            });
          } else {
            return;
          }
        },
        child: Text('Buy'.tr()),
      ),
    );
  }

  Future<bool> _showConfirmationDialog() async {
    bool result = false;
    await showModalBottomSheet<bool>(
        context: context,
        builder: (_) {
          return BottomSheet(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            enableDrag: true,
            onClosing: () {
              result = false;
            },
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('Do you really want to buy this Item?'.tr()),
                  TextButton(
                    onPressed: () => result = true,
                    child: Text('Confirm'.tr()),
                  ),
                  TextButton(
                    onPressed: () => result = false,
                    child: Text('Cancel'.tr()),
                  )
                ],
              );
            },
          );
        }).then((value) => );
    return result;
  }

  /// Dialog shown when an Error occurred
  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Error'.tr()),
            content: Text('Sorry, something went wrong.'.tr()),
            actions: <TextButton>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('It\'s ok'.tr()),
              )
            ],
          );
        });
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
          content: Text('You don\'t have enough money to buy this Item.'.tr()),
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
              child: Text('Buy money'.tr()),
            ),
          ],
        );
      },
    );
  }

  /// The Amount the user owns
  /// of this item.
  _DetailsRow get _amountOwned {
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
    return _DetailsRow(
      title: 'Owned:',
      data: text,
    );
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
  _DetailsRow get _price {
    return _DetailsRow(
      title: 'Price',
      data: () {
        final Item item = widget.item;
        final String s;
        if (item is ShopItem) {
          s = '${item.pricePerPiece.toStringAsFixed(2)} Cr';
        } else if (item is EconomyItem) {
          switch (item.type) {
            case EconomyType.credits:
              s = '${item.pricePerPiece} ${'???'.tr()}';
              break;
            case EconomyType.money:
              s = '${item.pricePerPiece} Unidentified';
              break;
          }
        } else {
          s = '';
        }
        return s;
      }(),
    );
  }
}

/// Represents a single Row of Information
/// on this Screen
class _DetailsRow extends StatelessWidget {
  const _DetailsRow({
    required this.title,
    required this.data,
    Key? key,
  }) : super(key: key);

  /// The Title of this Row
  final String title;

  /// The Data presented in this Row
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        textBaseline: TextBaseline.alphabetic,
        textDirection: TextDirection.ltr,
        verticalDirection: VerticalDirection.down,
        children: <Text>[
          Text(title),
          Text(data),
        ],
      ),
    );
  }
}
