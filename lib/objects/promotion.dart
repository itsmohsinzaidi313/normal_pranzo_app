class Promotion {
  String _promotionId;
  String _branchId;
  String _title;
  String _image;
  String _itemName;
  String _discount;
  String _discountType;
  String _isActive;
  String _dateFrom;
  String _dateTo;

  String get promotionId => _promotionId;

  set promotionId(String value) {
    _promotionId = value;
  }

  String get branchId => _branchId;

  String get dateTo => _dateTo;

  set dateTo(String value) {
    _dateTo = value;
  }

  String get dateFrom => _dateFrom;

  set dateFrom(String value) {
    _dateFrom = value;
  }

  bool getIsActive() {
    bool value = this._isActive == 'true' ? true : false;
    return value;
  }

  set isActive(String value) {
    _isActive = value;
  }

  String get discoutType => _discountType;

  set discoutType(String value) {
    _discountType = value;
  }

  String get discount => _discount;

  set discount(String value) {
    _discount = value;
  }

  String get itemName => _itemName;

  set itemName(String value) {
    _itemName = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  set branchId(String value) {
    _branchId = value;
  }
}
