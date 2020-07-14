import 'dart:async';

import 'package:normalpranzoapp/bloc/cart_event.dart';
import 'package:normalpranzoapp/objects/cart.dart';
import 'package:normalpranzoapp/objects/deal.dart';
import 'package:normalpranzoapp/objects/product.dart';

class Bloc {
//  static Bloc bloc;
  int qty = 0;
  final _cartEventController = StreamController<CartEvent>();

  Sink<CartEvent> get cartEventSink => _cartEventController.sink;

  final _cartStateController = StreamController<int>();

  StreamSink<int> get _inCart => _cartStateController.sink;

  Stream<int> get xcart => _cartStateController.stream;

  Bloc() {
    _cartEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CartEvent event) {
    if (event is AddProduct)
      Cart.cart.add(product: event.product);
    else if (event is RemoveProduct)
      Cart.cart.remove(product: event.product);
    else if (event is AddDeal)
      Cart.cart.add(deal: event.deal);
    else if (event is RemoveDeal) Cart.cart.remove(deal: event.deal);
    qty = Cart.cart.getProductQuantity();
    _inCart.add(qty);
  }

  void dispose() {
    _cartEventController.close();
    _cartStateController.close();
  }
}
