class Reservation {
  String _customerName;
  String _contact;
  String _reservationDate;
  String _reservationTime;
  String _noOfGuests;
  String _paymentMode;

  String get customerName => _customerName;

  set customerName(String value) {
    _customerName = value;
  }

  String get contact => _contact;

  String get paymentMode => _paymentMode;

  set paymentMode(String value) {
    _paymentMode = value;
  }

  String get noOfGuests => _noOfGuests;

  set noOfGuests(String value) {
    _noOfGuests = value;
  }

  String get reservationTime => _reservationTime;

  set reservationTime(String value) {
    _reservationTime = value;
  }

  String get reservationDate => _reservationDate;

  set reservationDate(String value) {
    _reservationDate = value;
  }

  set contact(String value) {
    _contact = value;
  }

  Map<String, String> getMap() {
    return {
      'customerName': customerName,
      'mobileNo': contact,
      'reservationDate': reservationDate,
      'time': reservationTime,
      'No_Of_Guest': noOfGuests,
      'paymentMode': paymentMode
    };
  }
}
