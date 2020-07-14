import 'package:flutter/material.dart';
import 'package:normalpranzoapp/bloc/bloc.dart';
import 'package:normalpranzoapp/config.dart';
import 'package:normalpranzoapp/objects/cart.dart';
import 'package:normalpranzoapp/pages/splash_page.dart';

void main() {
//  Bloc.bloc = Bloc();
  runApp(new MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SplashView(),
    },
  ));
}
