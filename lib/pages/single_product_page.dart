import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:normalpranzoapp/models/cart.dart';
import 'package:normalpranzoapp/models/product.dart';

import '../app_theme.dart';

class SingleProduct extends StatefulWidget {
  final String title;
  final Product product;

  SingleProduct({this.title, this.product});

  @override
  _SingleProductState createState() =>
      _SingleProductState(title: title, product: product);
}

class _SingleProductState extends State<SingleProduct> {
  String title;
  Product product;

  _SingleProductState({this.title, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.optpAppBarB(
          title: product.name,
          onPressed: () => Navigator.of(context).pop(),
          context: context),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            color: Colors.grey[300],
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Image.network(product.image,
                          height: 400, width: 400, fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      })),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: AppTheme.autoTextSizeWidget(
                                product.name.toUpperCase(),
                                fontWeight: FontWeight.bold,
                                fontSize: 28)),
                        Expanded(child: SizedBox()),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: onLess,
                        ),
                        AppTheme.autoTextSizeWidget(product.quantity.toString(),
                            fontColor: AppTheme.appThemeColor,
                            fontWeight: FontWeight.bold),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: onAdd,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      children: <Widget>[
                        AppTheme.autoTextSizeWidget(
                            'Rs.${(product.quantity * product.price).toString()}',
                            fontWeight: FontWeight.bold,
                            fontColor: AppTheme.appThemeColor),
                        Expanded(
                          child: SizedBox(),
                        ),
                        FlatButton(
                          child: AppTheme.autoTextSizeWidget('Add To Cart',
                              fontColor: Colors.white,
                              minFontSize: 16,
                              maxFontSize: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21)),
                          color: AppTheme.appThemeColor,
                          onPressed: onAddToCart,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onAdd() {
    setState(() {
      this.product.quantity++;
    });
  }

  void onLess() {
    if (this.product.quantity > 1)
      setState(() {
        this.product.quantity--;
      });
  }

  void onAddToCart() {
    Cart.cart.add(product: product);
    new FlutterToast(context).showToast(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: Colors.grey[600]),
          child: Text(
            'Added to your cart',
            style: TextStyle(fontSize: 21, color: Colors.white),
          ),
        ),
        toastDuration: Duration(seconds: 3));
//    AddProduct addProduct = new AddProduct();
//    addProduct.product = product;
//    Bloc.bloc.cartEventSink.add(addProduct);
//    _bloc.cartEventSink.add(addProduct);
  }

//  @override
//  void dispose() {
//    super.dispose();
////    Bloc.bloc.dispose();
//    _bloc.dispose();
//  }
}
