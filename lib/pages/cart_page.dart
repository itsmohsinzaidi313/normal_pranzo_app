import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/objects/cart.dart';
import 'package:normalpranzoapp/objects/product.dart';
import 'package:normalpranzoapp/pages/login_page.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Product> listProducts;

  _CartViewState() {
    //    Product product = new Product();
//    product.name = 'Product Name';
//    product.quantity = 1;
//    product.productId = '1';
//    product.price = 123;
//    product.image =
//        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTsphabW9FdQml5MQm_Z2lM8lDYBcPe-GEocA&usqp=CAU';
//    product.isActive = 'true';
//    product.branchId = '1234567';
//    product.categoryId = '1234567';
//    _list = [];
//    _list.add(product);
//    _list = Cart.cart.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    this.listProducts = Cart.cart.getProducts();
    return Scaffold(
      appBar: AppTheme.optpAppBarA(
          title: 'cart',
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          quantity: Cart.cart.getProductQuantity()),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: listProducts.length,
          itemBuilder: (BuildContext context, int index) =>
              _getProductWidget(context, index)),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: AppTheme.appThemeColor,
            child: Text(
              'CHECKOUT',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new LoginView(
                      list: listProducts,
                    ))),
          )
        ],
      ),
    );
  }

  Widget _getProductWidget(BuildContext context, int index) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppTheme.appThemeColor,
                ),
                onPressed: () {
                  setState(() {
                    Cart.cart.remove(product: listProducts[index]);
                    if (Cart.cart.getProductQuantity() == 0)
                      Navigator.of(context).pop();
                  });
                },
              ),
            ),
            Positioned(
              left: 0,
              top: 50,
              child: Container(
                padding: EdgeInsets.only(left: 14),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.22,
                child: Image.network(listProducts[index].image,
                    fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              top: 50,
              left: 150,
              child: Container(
                child: AppTheme.textWidget(listProducts[index].name,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AppTheme.textWidget(
                          'X${listProducts[index].quantity}',
                          fontWeight: FontWeight.bold),
                    ),
                    AppTheme.textWidget(
                        'Rs.${listProducts[index].price * listProducts[index].quantity}',
                        fontColor: AppTheme.appThemeColor,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
