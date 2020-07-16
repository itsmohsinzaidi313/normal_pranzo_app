import 'package:flutter/material.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/promotion.dart';
import '../app_theme.dart';

class PromotionsView extends StatefulWidget {
  final List<Promotion> list = [];

  PromotionsView(List<Promotion> value) {
    list.addAll(value);
  }

  @override
  _PromotionsViewState createState() => _PromotionsViewState(list);
}

class _PromotionsViewState extends State<PromotionsView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Promotion> promotions = [];
  JsonManipulator jsonManipulator;

  _PromotionsViewState(List<Promotion> list) {
    promotions.addAll(list);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(promotions[index].image,
                          fit: BoxFit.fill,
                          width: MediaQuery
                              .of(context)
                              .size.width * 0.92,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.25,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 8, left: 8),
                        child: AppTheme.autoTextSizeWidget('${promotions[index]
                            .itemName
                            .toUpperCase()}', fontWeight: FontWeight.bold,
                            minFontSize: 16,
                            maxFontSize: 21))
                    ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: AppTheme.autoTextSizeWidget(
                              'From: ${promotions[index].dateFrom
                                  .substring(0, 10)}', minFontSize: 16,
                              maxFontSize: 21)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: AppTheme.autoTextSizeWidget(
                              'To: ${promotions[index].dateTo.substring(
                                  0, 10)}', minFontSize: 16, maxFontSize: 21))
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
