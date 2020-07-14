class Customer {
  String _id;
  String _name;
  String _shippingAddress;
  String _paymentAddress;
  String _contact;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  String get contact => _contact;

  set contact(String value) {
    _contact = value;
  }

  String get paymentAddress => _paymentAddress;

  set paymentAddress(String value) {
    _paymentAddress = value;
  }

  String get shippingAddress => _shippingAddress;

  set shippingAddress(String value) {
    _shippingAddress = value;
  }

  set name(String value) {
    _name = value;
  }
}
