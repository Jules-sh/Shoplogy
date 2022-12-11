library blocs;

import 'package:bloc_implementation/bloc_implementation.dart' show Bloc;
import 'package:shoplogy/models/items/economy_item.dart';
import 'package:shoplogy/models/items/item.dart' show Item;
import 'package:shoplogy/models/items/shop_item.dart';
import 'package:shoplogy/models/permissions.dart';
import 'package:shoplogy/models/users.dart';

/// The Enum that tells
/// the Screen the Response
/// of the Item Details Bloc's buy method.
enum BuyResponse {
  /// The Amount the User wants to buy is
  /// equal to zero.
  amountZero,

  /// Successful Transaction.
  /// All good.
  success,

  /// The User does not
  /// have enough money to
  /// buy this Item.
  notEnoughMoney,

  /// The User does not have the
  /// permission to buy this.
  permissionDenied,

  /// The Item passed isn't a valid Item.
  invalidItem,
}

/// The Bloc for the Item Details Screen
class ItemDetailsBloc extends Bloc {
  /// The Amount the User wants to buy of this
  /// Item.
  double amount = 1;

  /// Tries to buy the [item] specified
  /// and returns a response depending on
  /// the events happened during the
  /// process.
  BuyResponse buy(Item item) {
    final BuyResponse response;
    if (amount == 0) {
      response = BuyResponse.amountZero;
    } else if (item is ShopItem) {
      item.amount = amount;
      if (User.currentUser.buy(item)) {
        response = BuyResponse.success;
      } else {
        response = BuyResponse.notEnoughMoney;
      }
    } else if (item is EconomyItem) {
      switch (item.type) {
        case EconomyType.credits:
          if (User.currentUser.hasPermission(const CreditsBuyPermission())) {
            User.currentUser.money += item.value;
            response = BuyResponse.success;
          } else {
            response = BuyResponse.permissionDenied;
          }
          break;
        case EconomyType.money:
          if (User.currentUser.hasPermission(const MoneyBuyPermission())) {
            User.currentUser.gems += item.value;
            response = BuyResponse.success;
          } else {
            response = BuyResponse.permissionDenied;
          }
          break;
      }
    } else {
      response = BuyResponse.invalidItem;
    }
    return response;
  }

  @override
  void dispose() {}
}
