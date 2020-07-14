import 'package:normalpranzoapp/objects/deal_item.dart';
import 'package:normalpranzoapp/objects/product.dart';

class Deal {
  String _dealId;
  String _name;
  double _price;
  String _image;
  String _isHolDeal;
  String _isActive;
  List<String> _dealItemsNames = [];
  List<DealItem> _dealItems = [];

  String get isActive => _isActive;

  set isActive(String value) {
    _isActive = value;
  }

  List<String> get dealItemsNames => _dealItemsNames;

  set dealItemsNames(List<String> value) {
    _dealItemsNames = value;
  }

  int _quantity;

  String get isHolDeal => _isHolDeal;

  set isHolDeal(String value) {
    _isHolDeal = value;
  }

  String get dealId => _dealId;

  set dealId(String value) {
    _dealId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<Product> get dealItems => _dealItems;

  set dealItems(List<Product> value) {
    _dealItems = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  Product getAsProduct() {
    Product product = new Product();
    product.productId = this.dealId;
    product.name = this.name;
    product.image = this.image;
    product.price = this.price;
    product.quantity = this.quantity;
    product.isActive = this.isActive;
    return product;
  }
}
