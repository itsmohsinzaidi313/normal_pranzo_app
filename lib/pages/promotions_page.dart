import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/promotion.dart';

import '../app_theme.dart';

class PromotionsView extends StatefulWidget {
  GlobalKey<ScaffoldState> key;

  PromotionsView(key);

  @override
  _PromotionsViewState createState() => _PromotionsViewState(key);
}

class _PromotionsViewState extends State<PromotionsView> {
  GlobalKey<ScaffoldState> key;
  List<Promotion> promotions = [];

  _PromotionsViewState(key) {
    JsonManipulator jsonManipulator = new JsonManipulator();
    jsonManipulator
        .getPromotions()
        .then((value) => promotions.addAll(value))
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.optpAppBarB(
          title: 'pranzo',
          onPressed: () => key.currentState.openDrawer(),
          context: context),
      drawer: AppTheme.drawerWidget(),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Text(promotions[index].itemName),
        );
      }, itemCount: promotions.length,),
    );
  }
}
