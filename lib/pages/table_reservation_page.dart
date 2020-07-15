import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';

class TableReservationView extends StatefulWidget {
  GlobalKey<ScaffoldState> key;

  TableReservationView(this.key);

  @override
  _TableReservationViewState createState() => _TableReservationViewState(key);
}

class _TableReservationViewState extends State<TableReservationView> {
  GlobalKey<ScaffoldState> key;

  _TableReservationViewState(this.key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppTheme.optpAppBarA(
          title: 'table reservation',
          onPressed: () => key.currentState.openDrawer()),
      drawer: AppTheme.drawerWidget(),
    );
  }
}
