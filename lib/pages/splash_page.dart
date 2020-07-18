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
    jsonManipulator.getRestaurants().then((restaurants) {
      if (restaurants != null) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => DashBoardView(
                  restaurants,
                )));
      } else {
        String message =
            jsonManipulator.messages == null ? "" : jsonManipulator.messages[0];
        AppTheme.showAlertDialogCustom(context, 'Error', message, [
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
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Center(
              heightFactor: 5,
              child: Image(
                image: AssetImage('images/pranzo_logo2.png'),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery
                .of(context)
                .size
                .height / 1.5,
            left: MediaQuery
                .of(context)
                .size
                .width / 2.4,
            child: Center(
              child: SpinKitDualRing(
                color: AppTheme.appThemeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
