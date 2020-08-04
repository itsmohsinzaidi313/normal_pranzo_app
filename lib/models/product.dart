class Product {
  String _branchId;

  String get branchId => _branchId;

  set branchId(String value) {
    _branchId = value;
  }

  String _productId;
  String _categoryId;
  String _name;
  double _price;
  String _image;
  String _isActive;
  int _quantity = 0;

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  String get productId => _productId;

  set productId(String value) {
    _productId = value;
  }

  String get categoryId => _categoryId;

  String get isActive => _isActive;

  set isActive(String value) {
    _isActive = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set categoryId(String value) {
    _categoryId = value;
  }
}
