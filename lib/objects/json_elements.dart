import 'dart:convert';

class PostOrder {
  String _mobileNo;
  String _customerName;
  String _customerId;
  String _shippingAddress;
  String _paymentAddress;
  double _total;
  List<Map> _orderDetails;

  String get mobileNo => _mobileNo;

  set mobileNo(String value) {
    _mobileNo = value;
  }

  String get customerName => _customerName;

  List<Map> get orderDetails => _orderDetails;

  set orderDetails(List<Map> value) {
    _orderDetails = value;
  }

  double get total => _total;

  set total(double value) {
    _total = value;
  }

  String get paymentAddress => _paymentAddress;

  set paymentAddress(String value) {
    _paymentAddress = value;
  }

  String get shippingAddress => _shippingAddress;

  set shippingAddress(String value) {
    _shippingAddress = value;
  }

  String get customerId => _customerId;

  set customerId(String value) {
    _customerId = value;
  }

  set customerName(String value) {
    _customerName = value;
  }

  Map<String, String> getMap() {
    return {
      'customerId': customerId.toString(),
      'mobileNo': mobileNo.toString(),
      'total': total.toString(),
      'customerName': customerName.toString().toUpperCase(),
      'shippingAddress': shippingAddress.toString(),
      'paymentAddress': paymentAddress.toString(),
      'orderDetails': orderDetails.toString()
    };
  }
}
