library screens;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoplogy/models/users.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// The Screen that represents the current
/// logged in Users Data
class UserScreen extends StatefulWidget {
  const UserScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  /// The User this Screen represents.
  final User user;

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _loggingIn = false;

  @override
  Widget build(BuildContext context) {
    if (widget.user != User.anonymous()) {
      return Scaffold(
        appBar: _anonymousAppBar,
        body: _anonymousBody,
      );
    } else {
      return Scaffold(
        appBar: _appBar,
        body: _body,
      );
    }
  }

  /// The Appbar if the User is not
  /// logged in
  AppBar get _anonymousAppBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(_loggingIn ? 'Log in'.tr() : 'User'.tr()),
    );
  }

  /// The Appbar if a User has already
  /// logged in.
  AppBar get _appBar {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(widget.user.name),
    );
  }

  /// The Body that gives the
  /// user the Opportunity to log in.
  Widget get _anonymousBody {
    return Center(
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        textBaseline: TextBaseline.alphabetic,
        verticalDirection: VerticalDirection.down,
        children: _loggingIn ? _logInChildren : _anonymousChildren,
      ),
    );
  }

  /// Children of the
  /// Anonymous Body.
  List<Widget> get _anonymousChildren {
    return [
      Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          'You are not logged in'.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextButton(
          autofocus: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onPressed: () {
            setState(() {
              _loggingIn = true;
            });
          },
          child: Text('Log in'.tr()),
        ),
      ),
    ];
  }

  /// Children of the Column when the User is logging in
  List<Widget> get _logInChildren {
    return [
      _logInTextField('Name'.tr()),
      _logInTextField('Lastname'.tr()),
      _logInTextField(
        'Admin Key'.tr(),
        obscure: true,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextButton(
          autofocus: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onPressed: () {
            setState(() {
              _loggingIn = false;
            });
          },
          child: Text('Cancel'.tr()),
        ),
      ),
    ];
  }

  /// A single TextField to enter
  /// a single Information to log in.
  Padding _logInTextField(
    String textFieldName, {
    TextInputAction textInputAction = TextInputAction.next,
    TextInputType textInputType = TextInputType.name,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        clipBehavior: Clip.antiAlias,
        autofocus: false,
        textDirection: TextDirection.ltr,
        toolbarOptions: const ToolbarOptions(
          selectAll: true,
          paste: true,
          cut: true,
          copy: true,
        ),
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.words,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        smartQuotesType: SmartQuotesType.enabled,
        smartDashesType: SmartDashesType.enabled,
        scrollPhysics: const BouncingScrollPhysics(),
        scribbleEnabled: true,
        readOnly: false,
        keyboardType: textInputType,
        obscureText: obscure,
        keyboardAppearance: Theme.of(context).brightness,
        enableSuggestions: true,
        enableInteractiveSelection: true,
        enableIMEPersonalizedLearning: true,
        enabled: true,
        dragStartBehavior: DragStartBehavior.down,
        autocorrect: true,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: textFieldName,
        ),
      ),
    );
  }

  /// The Body that represents the User.
  Widget get _body {
    return Container();
  }
}
