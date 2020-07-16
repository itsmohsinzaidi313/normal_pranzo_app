import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/cart.dart';
import 'package:normalpranzoapp/pages/cart_page.dart';
import 'package:normalpranzoapp/pages/events_page.dart';
import 'package:normalpranzoapp/pages/promotions_page.dart';
import 'package:normalpranzoapp/pages/table_reservation_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'bloc/bloc.dart';

class AppTheme {
  static const Color appThemeColor = Color.fromARGB(255, 196, 16, 1);
  static Color darkShade = Colors.green[600];
  static Color standardShade = Colors.green;
  static Color lightShade = Colors.green[300];
  static Color devajTheme = Color.fromRGBO(130, 9, 63, 1);

  static Widget autoTextSizeWidget(String text,
      {double fontSize,
      FontWeight fontWeight,
      double minFontSize = 16,
      double maxFontSize = 16,
      Color fontColor}) {
    return AutoSizeText(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
    );
  }

  static Future<DateTime> datePicker(BuildContext context) async {
    DateTime dateTime = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: dateTime,
        lastDate:
            new DateTime(dateTime.year + 1, dateTime.month, dateTime.day));
  }

  static Future<TimeOfDay> timePicker(BuildContext context) async {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  static ListTile listTileWidget(String title,
      {Widget leading,
        Widget trailing,
        String subtitle = '',
        bool isThreeLine = false,
        double minFontSize,
        double maxFontSize,
        FontWeight fontWeight}) {
    return ListTile(
      leading: leading,
      title: AppTheme.autoTextSizeWidget(title,
          minFontSize: minFontSize,
          maxFontSize: maxFontSize,
          fontWeight: fontWeight),
      subtitle: AppTheme.textWidget(subtitle),
      isThreeLine: isThreeLine,
      trailing: trailing,
    );
  }

  static AppBar appBarWidget(String title, {Widget leadingWidget}) {
    return AppBar(
      title: Text(title),
      backgroundColor: darkShade,
      leading: leadingWidget,
    );
  }

  static Text textWidget(String value,
      {double fontSize = 21, FontWeight fontWeight, Color fontColor}) {
    return Text(
      value,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
    );
  }

  static ProgressDialog showProgressDialog(BuildContext context,
      {String text = '', bool isDismissible = true}) {
    final spinKit = new SpinKitFadingCube(
      itemBuilder: (context, index) => DecoratedBox(
        decoration: BoxDecoration(color: AppTheme.appThemeColor),
      ),
    );
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        customBody: Container(
          height: 250,
          width: 100,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                spinKit,
                SizedBox(
                  height: 30,
                ),
                AppTheme.textWidget('Loading...')
              ]),
        ));
    return progressDialog;
  }

  static void showAlertDialogYN(BuildContext context, String title,
      String message, Function onYPressed, Function onNPressed) {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Yes',
                      style: TextStyle(color: AppTheme.standardShade)),
                  onPressed: onYPressed,
                ),
                FlatButton(
                  child: Text('No',
                      style: TextStyle(color: AppTheme.standardShade)),
                  onPressed: onNPressed,
                )
              ],
            )
          ],
        ));
  }

  static void showAlertDialogOK(BuildContext context, String title,
      String message, Function onOKPressed) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child:
                Text('OK', style: TextStyle(color: AppTheme.standardShade)),
                onPressed: onOKPressed,
              )
            ],
          );
        });
  }

  static void showAlertDialogCustom(BuildContext context, String title,
      String message, List<Widget> buttons) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: buttons,
          );
        });
  }

  static AppBar optpAppBarA({String title, int quantity = 0, Widget leading}) {
    return AppBar(
      leading: leading,
      centerTitle: true,
      title: Text(title.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppTheme.appThemeColor)),
      backgroundColor: Colors.white,
    );
  }

  static AppBar optpAppBarB(
      {String title, Function onPressed, BuildContext context, int quantity}) {
    return AppBar(
      centerTitle: true,
      title: autoTextSizeWidget(title.toUpperCase(),
          fontWeight: FontWeight.bold, fontColor: AppTheme.appThemeColor),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
        ),
        onPressed: onPressed,
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 8, top: 4),
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 35,
                      color: appThemeColor,
                    ),
                    onPressed: () {
                      if (Cart.cart.getProductQuantity() >= 1)
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => CartView()));
                      else
                        FlutterToast(context).showToast(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey[600]),
                              child: Text(
                                'Your cart is empty.',
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white),
                              ),
                            ),
                            toastDuration: Duration(seconds: 3));
                    },
                  )),
            ],
          ),
        ),
      ],
    );
  }

  static AppBar optpAppBarC({String title,
    Function onPressed,
    BuildContext context,
    int quantity,
    Bloc bloc}) {
    return AppBar(
      centerTitle: true,
      title: Text(title.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppTheme.appThemeColor)),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
        ),
        onPressed: onPressed,
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 50,
                      color: appThemeColor,
                    ),
                    onPressed: () =>
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (BuildContext context) => CartView())),
                  )),
              Positioned(
                right: 25,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(175, 255, 255, 0),
                      shape: BoxShape.circle),
                  padding: EdgeInsets.all(4),
                  child: StreamBuilder(
                    stream: bloc.xcart,
                    initialData: 0,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Drawer drawerWidget(BuildContext context) {
    JsonManipulator jsonManipulator = new JsonManipulator();

    return Drawer(
      child: Container(
        color: Colors.grey[300],
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                padding: EdgeInsets.only(top: 0, left: 5, right: 5),
                decoration: BoxDecoration(color: Colors.white),
                child: Image.asset('images/pranzo_logo2.png')),
            GestureDetector(
                child: AppTheme.listTileWidget('Promotions',
                    minFontSize: 16,
                    maxFontSize: 18,
                    trailing: Icon(Icons.arrow_forward_ios)),
                onTap: () {
                  ProgressDialog progressDialog = showProgressDialog(context);
                  progressDialog.show();
                  jsonManipulator.getPromotions().then((value) {
                    progressDialog.hide();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new PromotionsView(value)));
                  });
                }),
            GestureDetector(
                child: AppTheme.listTileWidget('Events',
                    minFontSize: 16,
                    maxFontSize: 18,
                    trailing: Icon(Icons.arrow_forward_ios)),
                onTap: () {
                  ProgressDialog progressDialog = showProgressDialog(context);
                  progressDialog.show();
                  jsonManipulator.getEvents().then((value) {
                    progressDialog.hide();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new EventsView(value)));
                  });
                  ;
                }),
            GestureDetector(
                child: AppTheme.listTileWidget(
                  'Table Reservation',
                  minFontSize: 16,
                  maxFontSize: 18,
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onTap: () =>
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new TableReservationView()))),
          ],
        ),
      ),
    );
  }
}
