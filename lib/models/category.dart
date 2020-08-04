import 'package:normalpranzoapp/models/deal.dart';
import 'package:normalpranzoapp/models/product.dart';

class Category {
  String _categoryId;
  String _name;
  String _status;
  String _isActive;
  String _image;
  bool _isDeal = false;
  List<Product> _products = [];
  List<Deal> _deals = [];

  bool get isDeal => _isDeal;

  set isDeal(bool value) {
    _isDeal = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  List<Deal> get deals => _deals;

  set deals(List<Deal> value) {
    _deals = value;
  }

  String get isActive => _isActive;

  set isActive(String value) {
    _isActive = value;
  }

  String get categoryId => _categoryId;

  set categoryId(String value) {
    _categoryId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }
}
