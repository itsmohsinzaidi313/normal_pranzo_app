import 'package:normalpranzoapp/models/deal.dart';
import 'package:normalpranzoapp/models/product.dart';

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
