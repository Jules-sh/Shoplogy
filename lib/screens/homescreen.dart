library screens;

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_themes/modern_themes_comps.dart';
import 'package:shoplogy/blocs/home_bloc.dart';
import 'package:shoplogy/components/item_grid_tile.dart';
import 'package:shoplogy/models/shop_item.dart';
import 'package:shoplogy/models/users.dart';
import 'package:string_translate/string_translate.dart';

/// The Standard Homescreen of this App.
class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  /// The Bloc that is
  /// resposible for all the Logic
  /// needed while the User is on this
  /// Screen.
  HomeBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocParent.of(context);

    return Scaffold(
      appBar: _appBar,
      bottomNavigationBar: _bnb,
      body: _body,
    );
  }

  /// The AppBar for this particiular Screen
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: TextField(
        expands: false,
        dragStartBehavior: DragStartBehavior.down,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        autocorrect: true,
        autofocus: false,
        enabled: true,
        enableIMEPersonalizedLearning: true,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardAppearance: Theme.of(context).brightness,
        keyboardType: TextInputType.text,
        maxLines: 1,
        minLines: 1,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        obscureText: false,
        readOnly: false,
        scribbleEnabled: true,
        scrollPhysics: const BouncingScrollPhysics(),
        smartDashesType: SmartDashesType.enabled,
        smartQuotesType: SmartQuotesType.enabled,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: TextCapitalization.words,
        textDirection: TextDirection.ltr,
        textInputAction: TextInputAction.search,
      ),
    );
  }

  /// The Body for this Screen.
  /// This returns a different Widet depending
  /// on the tab you're on.
  Scrollbar get _body {
    final Set<Scrollbar> s = {
      _economyBody,
      _shopBody,
      _inventoryBody,
    };
    return s.elementAt(_bloc!.cBnbI);
  }

  /// The Body for the Shop Tab.
  Scrollbar get _shopBody {
    return Scrollbar(
      child: _gridBuilder(
        items: ShopItem.allItems,
      ),
    );
  }

  /// The Screen to upload something yourself.
  Scrollbar get _economyBody {
    return Scrollbar(
      child: Container(),
    );
  }

  /// The Body for the Inventory Tab
  Scrollbar get _inventoryBody {
    return Scrollbar(
        child: _gridBuilder(
      items: User.currentUser.items,
    ));
  }

  /// The Bottom Navigation Bar for
  /// this Screen
  BottomNavigationBar get _bnb {
    return BottomNavigationBar(
      onTap: (i) => setState(() => _bloc!.cBnbI = i),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Coloring.mainColor,
      items: [
        BottomNavigationBarItem(
          label: 'Economy'.tr(),
          icon: const Icon(Icons.attach_money),
        ),
        BottomNavigationBarItem(
          label: 'Shop'.tr(),
          icon: const Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          label: 'Inventory'.tr(),
          icon: const Icon(Icons.inventory),
        ),
      ],
      currentIndex: _bloc!.cBnbI,
    );
  }

  /// A builder to build a grid
  /// view.
  /// This is used in all the
  /// Bodies in this Screen.
  Widget _gridBuilder({
    required Set<ShopItem> items,
  }) {
    if (items.isNotEmpty) {
      return GridView.builder(
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        reverse: false,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (_, counter) {
          return ItemGridTile(item: items.elementAt(counter));
        },
      );
    } else {
      return Center(
        child: Text('No Items'.tr()),
      );
    }
  }
}
