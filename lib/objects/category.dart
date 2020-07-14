import 'package:normalpranzoapp/objects/deal.dart';
import 'package:normalpranzoapp/objects/product.dart';

class Category {
  String _categoryId;
  String _name;
  String _status;
  String _isActive;
  List<Product> _products = [];
  List<Deal> _deals = [];

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
