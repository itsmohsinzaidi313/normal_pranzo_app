class Event {
  String _restaurantId;
  String _name;
  String _guest;
  String _image;
  String _isActive;

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
}
