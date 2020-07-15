import 'package:flutter/material.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/promotion.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../app_theme.dart';

class PromotionsView extends StatefulWidget {
  @override
  _PromotionsViewState createState() => _PromotionsViewState(key);
}

class _PromotionsViewState extends State<PromotionsView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Promotion> promotions = [];

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
      key: _scaffoldKey,
      appBar: AppTheme.optpAppBarA(
        title: 'promotions',

        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop()
        ),
      ),
      body: ListView.builder(
        itemCount: promotions.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.45,
            child: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.network(promotions[index].image,
                          fit: BoxFit.fill,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.95,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.3,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                    null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 8, left: 8),
                        child: AppTheme.textWidget('${promotions[index].itemName
                            .toUpperCase()}', fontWeight: FontWeight.bold),)
                    ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: AppTheme.textWidget(
                              'Date From: ${promotions[index].dateFrom
                                  .substring(0, 10)}')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: AppTheme.textWidget(
                              'Date To: ${promotions[index].dateTo.substring(
                                  0, 10)}'))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
