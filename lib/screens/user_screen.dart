library screens;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:shoplogy/blocs/user_bloc.dart';
import 'package:shoplogy/models/users.dart';
import 'package:string_translate/string_translate.dart' show Translate;

/// The Screen that represents the current
/// logged in Users Data
class UserScreen extends StatefulWidget {
  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);

    if (User.currentUser.exists) {
      return Scaffold(
        appBar: _appBar,
        body: _body,
      );
    } else {
      return Scaffold(
        appBar: _anonymousAppBar,
        body: _anonymousBody,
      );
    }
  }

  /// The Appbar if the User is not
  /// logged in
  AppBar get _anonymousAppBar {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      automaticallyImplyLeading: true,
      title: Text(_bloc!.loggingIn ? 'Log in'.tr() : 'User'.tr()),
    );
  }

  /// The Appbar if a User has already
  /// logged in.
  AppBar get _appBar {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      automaticallyImplyLeading: true,
      title: Text(User.currentUser.name),
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
        children: _bloc!.loggingIn ? _logInChildren : _anonymousChildren,
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
              _bloc!.loggingIn = true;
            });
          },
          child: Text('Log in'.tr()),
        ),
      ),
    ];
  }

  /// Children of the Column when the User is logging in
  List<Widget> get _logInChildren {
    return <Widget>[
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 10,
        child: FittedBox(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 100),
            child: Text(
              '''
Please enter your name and your lastname to log in
The Admin key is not required
If you have an Admin Key,
you can add it to enter admin mode.
              '''
                  .tr(),
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              textWidthBasis: TextWidthBasis.longestLine,
              maxLines: 10,
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
          ),
        ),
      ),
      _logInTextField('Name'.tr(), onChanged: (s) => _bloc!.name = s),
      _logInTextField('Lastname'.tr(), onChanged: (s) => _bloc!.lastname = s),
      _logInTextField(
        'Admin Key'.tr(),
        onChanged: (s) => _bloc!.adminKey = s,
        obscure: true,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
      ),
      Row(
        textDirection: TextDirection.ltr,
        verticalDirection: VerticalDirection.down,
        textBaseline: TextBaseline.alphabetic,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: TextButton(
              autofocus: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              onPressed: () {
                setState(() {
                  _bloc!.loggingIn = false;
                });
              },
              child: Text('Cancel'.tr()),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: _bloc!.readyToLogIn()
                ? TextButton(
                    autofocus: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: () => setState(() {
                      if (_bloc!.logIn()) {
                        return;
                      } else {
                        // TODO: Add Error Code
                      }
                    }),
                    child: Text('Log in'.tr()),
                  )
                : TextButton(
                    autofocus: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: null,
                    child: Text('Log in'.tr()),
                  ),
          ),
        ],
      ),
    ];
  }

  /// A single TextField to enter
  /// a single Information to log in.
  Padding _logInTextField(
    String textFieldName, {
    required void Function(String) onChanged,
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
        onChanged: (s) => {
          setState(() => {onChanged(s), _bloc!.readyToLogIn()})
        },
        onSubmitted: (s) => {
          setState(() => {onChanged(s), _bloc!.readyToLogIn()})
        },
      ),
    );
  }

  /// The Body that represents the User.
  Widget get _body {
    final User u = User.currentUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      textBaseline: TextBaseline.alphabetic,
      verticalDirection: VerticalDirection.down,
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          reverse: false,
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          dragStartBehavior: DragStartBehavior.down,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
          children: [
            ListTile(
              title: Text('Name'.tr()),
              subtitle: Text(u.name),
            ),
            ListTile(
              title: Text('Lastname'.tr()),
              subtitle: Text(u.lastname),
            ),
            ListTile(
              title: Text('Mode'.tr()),
              subtitle: Text(u.isAdmin ? 'Admin'.tr() : 'Normal'.tr()),
            ),
          ],
        ),
      ],
    );
  }
}
