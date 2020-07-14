import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:normalpranzoapp/config.dart';
import 'package:normalpranzoapp/objects/category.dart';
import 'package:normalpranzoapp/objects/customer.dart';
import 'package:normalpranzoapp/objects/deal.dart';
import 'package:normalpranzoapp/objects/deal_item.dart';
import 'package:normalpranzoapp/objects/json_elements.dart';
import 'package:normalpranzoapp/objects/product.dart';

import 'objects/restaurant.dart';

class JsonManipulator {
  Logger _log = Config.log;
  Customer customer;
  List<String> messages = [];
  List<Exception> exceptions = [];

  JsonManipulator();

  Future<List<Restaurant>> getRestaurants() async {
    Response response;
    try {
      response = await get(Config.apiRestaurant)
          .timeout(Duration(seconds: Config.connectionTimeout), onTimeout: () {
        _log.w('CONNECTION TIMEOUT');
        return null;
      }).catchError((onError) {
        exceptions.add(onError);
        if (onError is SocketException)
          messages.add('No internet connection.');
        else
          messages.add(onError.toString());
        return null;
      });
    } catch (e) {
      return null;
    }
    if (response != null) {
      Map map = jsonDecode(response.body);
      if (map['success'] == true) {
        List<dynamic> data = [];
        data = map['data'];
        if (data.length > 0) {
          List<Restaurant> restaurants = [];
          List<Category> categories = [];
          List<Product> products = [];
          List<Deal> deals = [];

          data.forEach((element) {
            Restaurant restaurant = new Restaurant();
            restaurant.restaurantId = element['branchId'];
            restaurant.name = element['restaurantName'];
            restaurant.address = element['areaName'];
            restaurant.status = element['isActive'];
            restaurant.contact = element['phone'];

            //CATEGORIES
            List<dynamic> categoriesJson = element['categories'];
            categoriesJson.forEach((categoryJson) {
              Category category = new Category();
              category.categoryId = categoryJson['categoryId'];
              category.isActive = categoryJson['isActive'];
              category.name = categoryJson['name'];
              category.products = [];

              List<dynamic> itemsJson = categoryJson['items'];
              itemsJson.forEach((itemJson) {
                Product product = new Product();
                product.branchId = itemJson['branchId'];
                product.categoryId = itemJson['categoryId'];
                product.productId = itemJson['itemId'];
                product.name = itemJson['name'];
                product.image = itemJson['image'];
                product.price = double.parse(itemJson['price'].toString());
                product.quantity = 1;
                category.products.add(product);
              });
              categories.add(category);
            });

            //DEALS
            List<dynamic> dealsJson = element['deals'];
            Category dealCategory = new Category();
            dealCategory.name = 'Deals';
            for (int i = 0; i < dealsJson.length; i++) {
              Deal deal = new Deal();
              deal.dealId = dealsJson[i]['dealId'];
              deal.name = dealsJson[i]['name'];
              deal.image = dealsJson[i]['image'];
              deal.quantity = 1;
              deal.isHolDeal = dealsJson[i]['isHotDeal'].toString();
              deal.isActive = dealsJson[i]['isActive'];

              List<dynamic> dealItemsJson = dealsJson[i]['dealItems'];
              dealItemsJson.forEach((dealItemJson) {
                DealItem dealItem = new DealItem();
                dealItem.productId = dealItemJson['itemId'];
                dealItem.dealId = dealItemJson['dealId'];
                dealItem.name = dealItemJson['name'];
                dealItem.price = double.parse(dealItemJson['price'].toString());
                dealItem.image = dealItemJson['image'];
                dealItem.quantity =
                    int.parse(dealItemJson['quantity'].toString());
                deal.dealItems.add(dealItem);
              });
              if (dealsJson[i]['isHotDeal'] == 1) {
                restaurant.deals.add(deal);
                deals.add(deal);
              } else {
                deals.add(deal);
              }
            }
//            dealsJson.forEach((dealJson) {
//              Deal deal = new Deal();
//              deal.dealId = dealJson['dealId'];
//              deal.name = dealJson['name'];
//              deal.image = dealJson['image'];
//              deal.quantity = int.parse(dealJson['quantity']);
//              deal.isHolDeal = dealJson['isHotDeal'];
//              deal.isActi = dealJson['isActive'];
//              deal.dealItems = [];
//
//              List<dynamic> dealItemsJson = dealJson['dealItems'];
//              dealItemsJson.forEach((dealItemJson) {
//                DealItem dealItem = new DealItem();
//                dealItem.productId = dealItemJson['itemId'];
//                dealItem.dealId = dealItemJson['dealId'];
//                dealItem.name = dealItemJson['name'];
//                dealItem.price = dealItemJson['price'];
//                dealItem.image = dealItemJson['image'];
//                dealItem.quantity = int.parse(dealItemJson['quantity']);
//                deal.dealItems.add(dealItem);
//              });
//              if (dealJson['isHotDeal'] == 1) {
//                restaurant.deals.add(deal);
//                deals.add(deal);
//              } else {
//                deals.add(deal);
//              }
//            });
            restaurant.categories = [];
            restaurant.categories.addAll(categories);
            restaurant.categories.add(dealCategory);
            restaurants.add(restaurant);
          });
          return restaurants;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
    return null;
  }

  Future<bool> signIn(String username, String password) async {
    bool status = false;
    Map<String, String> packet = {'mobile': username, 'password': password};
    Response response = await post(Config.apiLogin, body: packet)
        .timeout(Duration(seconds: 10), onTimeout: () => null)
        .catchError((onError) => messages.add('$onError'));
    if (response != null) {
      bool success = jsonDecode(response.body)['success'];
      Map data = jsonDecode(response.body)['data'];
      if (success) {
        status = true;
        customer = new Customer();
        customer.id = data['customerId'].toString();
        customer.name = data['customerName'].toString();
        customer.contact = data['customerMobile'].toString();
        customer.paymentAddress = data['paymentAddress'].toString();
        customer.shippingAddress = data['shippingAddress'].toString();
      } else {
        messages.add(data['message']);
      }
    }
    return status;
  }

  Future<bool> signUpUser() async {
    try {
      Response response = await post(Config.apiCustomerSignUp);
      return false;
    } catch (e) {
      _log.e(e);
      return false;
    }
  }

  Future<bool> postOrder(PostOrder postOrder) async {
    bool status = false;
    Map<String, String> header = {
      'content-type': 'application/x-www-form-urlencoded'
    };
    Response response = await post(Config.apiPostOrder,
            headers: header, body: postOrder.getMap())
        .timeout(Duration(seconds: 10), onTimeout: () => null);
    print(Config.apiPostOrder);
    print(postOrder.getMap());
    bool success = jsonDecode(response.body)['success'];
    Map data = jsonDecode(response.body)['data'];
    if (success) {
      status = true;
      messages.add('Your order is placed. \n Order #:${data['orderNo']}');
    } else {
      messages.add(data['message']);
    }
    return status;
  }
}
