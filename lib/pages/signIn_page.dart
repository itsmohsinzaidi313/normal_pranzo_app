import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/customer.dart';
import 'package:normalpranzoapp/objects/json_elements.dart';
import 'package:normalpranzoapp/objects/product.dart';
import 'package:normalpranzoapp/pages/place_order_page.dart';
import 'package:normalpranzoapp/pages/signUp_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../app_theme.dart';

class SignInView extends StatefulWidget {
  final List<Product> list;

  SignInView({this.list});

  @override
  _SignInViewState createState() => _SignInViewState(products: list);
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  String user;
  String key;
  ProgressDialog progressDialog;
  List<Product> products;

  _SignInViewState({this.products});

  @override
  Widget build(BuildContext context) {
    progressDialog = AppTheme.showProgressDialog(context);
    return Scaffold(
      appBar: AppTheme.optpAppBarA(
          title: 'pranzo',
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                Center(
                  heightFactor: 1.1,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 50),
//                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          width: 3,
                          color: AppTheme.appThemeColor,
                        )),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(8),
                              color: AppTheme.appThemeColor,
                              child: Center(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Mobile #',
                                        icon: Icon(Icons.phone)),
                                    validator: (value) =>
                                        value.isEmpty ? 'Required' : null,
                                    onSaved: (value) => user = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        icon: Icon(Icons.lock_outline)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => key = value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                              child: RaisedButton(
                                  color: AppTheme.appThemeColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: AppTheme.textWidget('Login',
                                      fontSize: 16, fontColor: Colors.white),
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      progressDialog.show();
                                      JsonManipulator jsonManipulator =
                                          new JsonManipulator();
                                      jsonManipulator
                                          .signIn(user, key)
                                          .then((status) {
                                        progressDialog.hide();
                                        if (status) {
                                          PostOrder postOrder = new PostOrder();
                                          Customer customer =
                                              jsonManipulator.customer;
                                          postOrder.customerId = customer.id;
                                          postOrder.customerName =
                                              customer.name;
                                          postOrder.shippingAddress =
                                              customer.shippingAddress;
                                          postOrder.paymentAddress =
                                              customer.paymentAddress;
                                          postOrder.mobileNo = customer.contact;
                                          postOrder.orderDetails =
                                              getProductDetailJson(products);
                                          postOrder.total =
                                              getTotalPrice(products);
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlaceOrderView(
                                                        postOrder: postOrder,
                                                      )));
                                        } else {}
                                      }).catchError((onError) {
                                        print(onError);
                                        progressDialog.hide();
                                      });
//                                  Config.username = user;
//                                  Config.password = key;
                                    } else {
                                      progressDialog.hide();
                                    }
                                  })),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            child: Container(
                              child: Text(
                                'Create new account',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.appThemeColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (context) => SignUpView())),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map> getProductDetailJson(List<Product> productList) {
    List<Map> listMap = [];
    productList.forEach((element) {
      listMap.add({
        jsonEncode('itemId'): jsonEncode(element.productId),
        jsonEncode('itemName'): jsonEncode(element.name),
        jsonEncode('quantity'): jsonEncode(element.quantity.toString()),
        jsonEncode('price'): jsonEncode(element.price.toString()),
        jsonEncode('total'):
            jsonEncode((element.price * element.quantity).toString())
      });
    });
    return listMap;
  }

  double getTotalPrice(List<Product> productList) {
    double total = 0;
    productList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }
}
