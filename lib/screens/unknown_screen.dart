library screens;

import 'package:flutter/material.dart';

/// The Screen shown when
/// no Screen with the given Route is
/// found in the Scope of this App.
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: const Text('Huh...?'),
      automaticallyImplyLeading: true,
    );
  }

  Center get _body {
    return const Center(
      child: Text('Screen not found'),
    );
  }
}
