import 'package:normalpranzoapp/objects/product.dart';

class DealItem extends Product {
  String _dealId;

  String get dealId => _dealId;

  set dealId(String value) {
    _dealId = value;
  }
}
