import 'package:flutter/material.dart';

class UnknownPage extends MaterialPage {
  UnknownPage() : super(key: ValueKey('Unknown'), child: UnknownScreen());
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
