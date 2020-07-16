import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/config.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/cart.dart';
import 'package:normalpranzoapp/pages/dashboard_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  navigateToLogin() {
    Cart.cart = new Cart();
    JsonManipulator jsonManipulator = JsonManipulator();
    jsonManipulator.getRestaurants().then((value) {
      if (value != null) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => DashBoardView(
                  list: value,
                )));
      } else {
        AppTheme.showAlertDialogCustom(
            context, 'Error', jsonManipulator.messages[0], [
          FlatButton(
            child: Text('OK', style: TextStyle(color: AppTheme.standardShade)),
            onPressed: () => exit(0),
          ),
          FlatButton(
            child:
                Text('Retry', style: TextStyle(color: AppTheme.standardShade)),
            onPressed: () {
              setState(() {
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                        builder: (context) => new SplashView()),
                    (route) => false);
              });
            },
          ),
        ]);
//        AppTheme.showAlertDialogOK(context, 'Error',
//            jsonManipulator.messages[0], () => exit(0));
      }
    });
  }

  Timer loadView() {
    return Timer(Duration(seconds: Config.splashTime), navigateToLogin);
  }

  @override
  void initState() {
    super.initState();
    loadView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              heightFactor: 4,
              child: Image(
                image: AssetImage('images/pranzo_logo2.png'),
              ),
            ),
            Center(
              heightFactor: 0,
              child: SpinKitDualRing(
                color: AppTheme.appThemeColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
