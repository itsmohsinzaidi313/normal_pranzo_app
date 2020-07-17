import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:normalpranzoapp/json_manipulator.dart';
import 'package:normalpranzoapp/objects/customer.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../app_theme.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;
  String name, contact, add1, add2, password;

  @override
  Widget build(BuildContext context) {
    progressDialog = AppTheme.showProgressDialog(context);
    progressDialog.hide();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: Column(
              children: <Widget>[
                Center(
                  heightFactor: 1.1,
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
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(8),
                              color: AppTheme.appThemeColor,
                              child: Center(
                                child: Text(
                                  'SIGN UP',
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
                                        hintText: 'Your Name',
                                        icon: Icon(Icons.person)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => name = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Mobile #',
                                        icon: Icon(Icons.phone)),
                                    validator: (value) =>
                                        value.isEmpty ? 'Required' : null,
                                    onSaved: (value) => contact = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Delivery Address',
                                        icon: Icon(Icons.home)),
                                    validator: (value) =>
                                    value.isEmpty ? "Required" : null,
                                    onSaved: (value) => add1 = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Payment Address',
                                        icon: Icon(Icons.location_city)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => add2 = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        icon: Icon(Icons.vpn_key)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => password = value,
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
                                  child: AppTheme.textWidget('Register',
                                      fontSize: 16, fontColor: Colors.white),
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      progressDialog.show();
                                      Customer customer = new Customer();
                                      customer.name = name;
                                      customer.contact = contact;
                                      customer.shippingAddress = add1;
                                      customer.paymentAddress = add2;
                                      customer.password = password;
                                      JsonManipulator jsonManipulator = new JsonManipulator();
                                      jsonManipulator
                                          .signUp(customer)
                                          .then((value) {
                                        progressDialog.hide();
                                        if (value)
                                          AppTheme.showAlertDialogOK(
                                              context,
                                              'Success',
                                              ('Your account has been created.\nPlease go back and sign in to place order'),
                                                  () => Navigator.pop(context));
                                        else
                                          AppTheme.showAlertDialogOK(
                                              context,
                                              'Failure',
                                              ('${jsonManipulator
                                                  .messages[0]}\nPlease try again later.'),
                                                  () => Navigator.pop(context));
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
