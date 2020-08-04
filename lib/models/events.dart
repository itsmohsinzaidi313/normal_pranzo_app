class Event {
  String _restaurantId;
  String _name;
  String _guest;
  String _image;
  String _isActive;
  String _dateFrom;
  String _dateTo;

  String get dateFrom => _dateFrom;

  set dateFrom(String value) {
    _dateFrom = value;
  }

  String get restaurantId => _restaurantId;

  set restaurantId(String value) {
    _restaurantId = value;
  }

  String get name => _name;

  String get isActive => _isActive;

  set isActive(String value) {
    _isActive = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get guest => _guest;

  set guest(String value) {
    _guest = value;
  }

  set name(String value) {
    _name = value;
  }

  String get dateTo => _dateTo;

  set dateTo(String value) {
    _dateTo = value;
  }
}
