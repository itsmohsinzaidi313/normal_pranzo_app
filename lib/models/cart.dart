import 'package:normalpranzoapp/models/product.dart';

import 'deal.dart';

class Cart {
  static Cart cart;

  List<Product> listProducts = [];

  List<Deal> listDeals = [];

  List<Product> getProducts() => listProducts;

  List<Deal> getDeals() => listDeals;

  add({Product product, Deal deal}) {
    bool exists = false;
    if (product != null) {
      for (int i = 0; i < listProducts.length; i++) {
        print(listProducts[i].productId);
        print(product.productId);
        if (listProducts[i].productId == product.productId) {
          listProducts[i].quantity = product.quantity;
          exists = true;
        }
      }

      if (!exists) {
        listProducts.add(product);
      }
    }

    exists = false;
    if (deal != null) {
      for (int i = 0; i < listDeals.length; i++) {
        if (listDeals[i].dealId == deal.dealId) {
          listDeals[i].quantity = deal.quantity;
          exists = true;
        }
      }

      if (!exists) {
        listDeals.add(deal);
      }
    }
  }

  void remove({Product product, Deal deal}) {
    if (product != null) {
      for (int i = 0; i < listProducts.length; i++) {
        if (listProducts[i].productId == product.productId)
          listProducts.removeAt(i);
      }
    }

    if (deal != null) {
      for (int i = 0; i < listDeals.length; i++) {
        if (listDeals[i].dealId == deal.dealId) listDeals.removeAt(i);
      }
    }
  }

  void less({Product product, Deal deal}) {
    if (product != null) {
      listProducts.forEach((element) {
        if (element.productId == product.productId) {
          element.quantity--;
        }
      });
    }

    if (deal != null) {
      listDeals.forEach((element) {
        if (element.dealId == deal.dealId) {
          element.quantity--;
        }
      });
    }
  }

  double getTotalAmount() {
    double totalPrice = 0;
    listProducts.forEach((element) {
      totalPrice += element.quantity * element.price;
    });

    listDeals.forEach((element) {
      totalPrice += element.quantity * element.price;
    });
    return totalPrice;
  }

  int getProductQuantity() {
    return listProducts.length + listDeals.length;
  }
}
