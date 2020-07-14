import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  Key key = new Key('appbar');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
    );
  }
}
