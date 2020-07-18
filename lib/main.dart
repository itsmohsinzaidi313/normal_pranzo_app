import 'package:flutter/material.dart';
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
