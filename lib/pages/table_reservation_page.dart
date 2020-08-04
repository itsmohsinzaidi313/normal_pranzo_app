import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/models/reservation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../json_manipulator.dart';

class TableReservationView extends StatefulWidget {
  @override
  _TableReservationViewState createState() => _TableReservationViewState();
}

class _TableReservationViewState extends State<TableReservationView> {
  final formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;
  String name, contact, date = 'Select Date', time = 'Select Time', noOfGuests;
  int paymentMode = 0;
  List<String> list = ['Cash', 'Credit'];

  @override
  Widget build(BuildContext context) {
    progressDialog = AppTheme.showProgressDialog(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppTheme.optpAppBarA(
        title: 'pranzo',
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Wrap(
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
                    height: MediaQuery.of(context).size.height * 0.80,
                    width: MediaQuery.of(context).size.width * 0.92,
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(8),
                              color: AppTheme.appThemeColor,
                              child: Center(
                                child: Text(
                                  'TABLE RESERVATION',
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
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        hintText: 'Mobile #',
                                        icon: Icon(Icons.phone)),
                                    validator: (value) =>
                                        value.isEmpty ? 'Required' : null,
                                    onSaved: (value) => contact = value,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: 'No of Guest',
                                        icon: Icon(Icons.group)),
                                    validator: (value) =>
                                        value.isEmpty ? "Required" : null,
                                    onSaved: (value) => noOfGuests = value,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.payment),
                                    title: DropdownButtonFormField(
                                      items: <DropdownMenuItem>[
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text('Cash'),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text('Credit'),
                                        ),
                                      ],
                                      onChanged: (value) => paymentMode = value,
                                      validator: (value) =>
                                          value == null ? "Required" : null,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: ListTile(
                                      leading: Icon(Icons.date_range),
                                      title: Text(date),
                                    ),
                                    onTap: () {
                                      AppTheme.datePicker(context)
                                          .then((value) {
                                        setState(() {
                                          date = DateFormat('yyyy-MM-dd')
                                              .format(value);
                                        });
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    child: ListTile(
                                      leading: Icon(Icons.timer),
                                      title: Text(time),
                                    ),
                                    onTap: () {
                                      AppTheme.timePicker(context)
                                          .then((value) {
                                        setState(() {
                                          time =
                                              value.format(context).toString();
                                        });
                                      });
                                    },
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
                                  child: AppTheme.textWidget('Reserve',
                                      fontSize: 16, fontColor: Colors.white),
                                  onPressed: () {
                                    if (formKey.currentState.validate() &&
                                        date != 'Select Date' &&
                                        time != 'Select Time') {
                                      formKey.currentState.save();
                                      progressDialog.show();
                                      Reservation reservation =
                                          new Reservation();
                                      reservation.customerName = name;
                                      reservation.noOfGuests = noOfGuests;
                                      reservation.paymentMode =
                                          paymentMode.toString();
                                      reservation.reservationDate = date;
                                      reservation.reservationTime = time;
                                      reservation.contact = contact;
                                      JsonManipulator jsonManipulator =
                                          new JsonManipulator();
                                      jsonManipulator
                                          .reserveTable(reservation)
                                          .then((value) {
                                        progressDialog.hide();
                                        if (value)
                                          AppTheme.showAlertDialogOK(
                                              context,
                                              'Success',
                                              ('Your request for table reservation has been sent.'),
                                              () => Navigator.pop(context));
                                        else
                                          AppTheme.showAlertDialogOK(
                                              context,
                                              'Failure',
                                              ('${jsonManipulator.messages[0]}\nPlease try again later.'),
                                              () => Navigator.pop(context));
                                      });
                                    } else if (date.toLowerCase() ==
                                        'select date') {
                                      AppTheme.showAlertDialogOK(
                                          context,
                                          'Attention',
                                          ('Please select date'),
                                          () => Navigator.of(context).pop());
                                    } else if (time.toLowerCase() ==
                                        'select time') {
                                      AppTheme.showAlertDialogOK(
                                          context,
                                          'Attention',
                                          ('Please select time'),
                                          () => Navigator.of(context).pop());
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
