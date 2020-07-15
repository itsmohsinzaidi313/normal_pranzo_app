import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';

class TableReservationView extends StatefulWidget {
  @override
  _TableReservationViewState createState() => _TableReservationViewState();
}

class _TableReservationViewState extends State<TableReservationView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppTheme.optpAppBarA(
          title: 'table reservation',
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      drawer: AppTheme.drawerWidget(context),
    );
  }
}
