library screens;

import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes_comps.dart';
import 'package:shoplogy/blocs/home_bloc.dart';
import 'package:shoplogy/components/economy_grid_tile.dart';
import 'package:shoplogy/components/item_grid_tile.dart';
import 'package:shoplogy/models/items/shop_item.dart';
import 'package:shoplogy/models/users.dart';
import 'package:shoplogy/navigation/routes.dart';
import 'package:string_translate/string_translate.dart';

/// The Standard Homescreen of this App.
class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  /// The Bloc that is
  /// responsible for all the Logic
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

  /// The AppBar for this particular Screen
  AppBar get _appBar {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      automaticallyImplyLeading: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.userScreen,
            arguments: User.currentUser,
          );
        },
        icon: const Icon(Icons.account_circle),
      ),
      title: TextField(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        autocorrect: true,
        autofocus: false,
        dragStartBehavior: DragStartBehavior.down,
        enabled: true,
        enableIMEPersonalizedLearning: true,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardAppearance: Theme.of(context).brightness,
        obscureText: false,
        keyboardType: TextInputType.text,
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
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true,
        ),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          enabled: true,
          filled: false,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: 'Search something...'.tr(),
          hintStyle: TextStyle(
            color: Coloring.secondaryColor,
          ),
          border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Colors.white70,
              style: BorderStyle.solid,
              width: 1.5,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Colors.white70,
              style: BorderStyle.solid,
              width: 1.5,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Colors.white70,
              style: BorderStyle.solid,
              width: 1.5,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Colors.white70,
              style: BorderStyle.solid,
              width: 1.5,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Colors.white70,
              style: BorderStyle.solid,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(
              color: Colors.white70,
              style: BorderStyle.solid,
              width: .5,
            ),
          ),
        ),
      ),
    );
  }

  /// The Body for this Screen.
  /// This returns a different Widget depending
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
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dragStartBehavior: DragStartBehavior.down,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: false,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        children: const <EconomyGridTile>[
          EconomyGridTile(name: '100 €', price: 10),
        ],
      ),
    );
  }

  /// The Body for the Inventory Tab
  Scrollbar get _inventoryBody {
    return Scrollbar(
      child: _gridBuilder(
        items: User.currentUser.items,
      ),
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.highlight_off,
              size: 100,
            ),
            const SizedBox(height: 10),
            Text('No Items here'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  }
}
