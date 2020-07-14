import 'package:normalpranzoapp/objects/deal.dart';
import 'package:normalpranzoapp/objects/product.dart';

abstract class CartEvent {}

class AddProduct extends CartEvent {
  Product product;
}

class AddDeal extends CartEvent {
  Deal deal;
}

class RemoveProduct extends CartEvent {
  Product product;
}

class RemoveDeal extends CartEvent {
  Deal deal;
}
