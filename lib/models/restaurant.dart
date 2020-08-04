import 'package:normalpranzoapp/models/deal.dart';
import 'package:normalpranzoapp/models/promotion.dart';

import 'category.dart';

class Restaurant {
  String _restaurantId;
  String _name;
  String _address;
  String _contact;
  String _status;
  String _image;
  List<Category> _categories = [];
  List<Deal> _hotDeals = [];

  List<Deal> get hotDeals => _hotDeals;

  set hotDeals(List<Deal> value) {
    _hotDeals = value;
  }

  List<Promotion> _promotions = [];

  List<Promotion> get promotions => _promotions;

  set promotions(List<Promotion> value) {
    _promotions = value;
  }

  List<Deal> get deals => _hotDeals;

  set deals(List<Deal> value) {
    _hotDeals = value;
  }

  String get restaurantId => _restaurantId;

  set restaurantId(String value) {
    _restaurantId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<Category> get categories => _categories;

  set categories(List<Category> value) {
    _categories = value;
  }

  String get image {
    _image = _image == null
        ? 'https://cdn.shopify.com/s/files/1/1405/0664/products/4791207-9790062099-Pizza1_450x.jpg?v=1469649640'
        : _image;
    return _image;
  }

  set image(String value) {
    _image = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get contact => _contact;

  set contact(String value) {
    _contact = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }
}
