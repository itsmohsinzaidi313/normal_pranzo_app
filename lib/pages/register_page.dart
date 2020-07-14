import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:normalpranzoapp/pages/dashboard_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../app_theme.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;
  String user, key, secKey, shop, mobile, name;

  @override
  Widget build(BuildContext context) {
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
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.height * 0.39,
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
                                    onSaved: (value) => mobile = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Delivery Address',
                                        icon: Icon(Icons.account_box)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => key = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'total',
                                        icon: Icon(Icons.vpn_key)),
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
                                  child: AppTheme.textWidget('Register',
                                      fontSize: 16, fontColor: Colors.white),
                                  onPressed: () {
                                    //progressDialog.show();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                DashBoardView()),
                                        (route) => false);
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
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
