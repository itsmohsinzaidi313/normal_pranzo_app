import 'package:flutter/material.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/json_elements.dart';
import 'package:normalpranzoapp/pages/dashboard_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../app_theme.dart';

class PlaceOrderView extends StatefulWidget {
  final PostOrder postOrder;

  PlaceOrderView({this.postOrder});

  @override
  _PlaceOrderViewState createState() =>
      _PlaceOrderViewState(postOrder: postOrder);
}

class _PlaceOrderViewState extends State<PlaceOrderView> {
  final PostOrder postOrder;

  _PlaceOrderViewState({this.postOrder});

  final formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;
  String mobile, name, add1, add2, id, total;

  @override
  Widget build(BuildContext context) {
    if (postOrder != null) {
      id = postOrder.customerId;
      name = postOrder.customerName;
      mobile = postOrder.mobileNo;
      add1 = postOrder.shippingAddress;
      add2 = postOrder.paymentAddress;
      total = postOrder.total.toString();
    }
    progressDialog = AppTheme.showProgressDialog(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppTheme.optpAppBarA(title: 'pranzo'),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  heightFactor: 1.5,
                  child: Container(
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.38,
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    initialValue: name,
                                    decoration: InputDecoration(
                                        hintText: 'Your Name',
                                        icon: Icon(Icons.person)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => name = value,
                                  ),
                                  TextFormField(
                                    initialValue: mobile,
                                    decoration: InputDecoration(
                                        hintText: 'Mobile #',
                                        icon: Icon(Icons.phone)),
                                    validator: (value) =>
                                        value.isEmpty ? 'Required' : null,
                                    onSaved: (value) => mobile = value,
                                  ),
                                  TextFormField(
                                    initialValue: add1,
                                    decoration: InputDecoration(
                                        hintText: 'Delivery Address',
                                        icon: Icon(Icons.home)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => add1 = value,
                                  ),
                                  TextFormField(
                                    initialValue: total,
                                    decoration: InputDecoration(
                                        hintText: 'total',
                                        icon: Icon(Icons.attach_money)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => total = value,
                                    enabled: false,
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
                                  child: AppTheme.textWidget('Place Order',
                                      fontSize: 16, fontColor: Colors.white),
                                  onPressed: () {
                                    progressDialog.show();
                                    if (formKey.currentState.validate()) {
                                      postOrder.customerName = name;
                                      postOrder.shippingAddress = add1;
                                      postOrder.mobileNo = mobile;
                                      formKey.currentState.save();
                                      JsonManipulator jsonManipulator =
                                          new JsonManipulator();
                                      jsonManipulator
                                          .postOrder(postOrder)
                                          .then((value) {
                                        if (value) {
                                          jsonManipulator
                                              .getRestaurants()
                                              .then((restaurants) {
                                            progressDialog.hide();
                                            AppTheme.showAlertDialogOK(
                                                context,
                                                'Success',
                                                jsonManipulator.messages[0],
                                                () => Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                DashBoardView(
                                                                  restaurants:
                                                                      restaurants,
                                                                )),
                                                        (route) => false));
                                          });
                                        } else {
                                          AppTheme.showAlertDialogOK(
                                              context,
                                              'Failure',
                                              jsonManipulator.messages[0],
                                              () =>
                                                  Navigator.of(context).pop());
                                        }
                                      });
                                    }
                                  })),
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
}
