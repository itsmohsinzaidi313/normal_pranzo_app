import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/models/cart.dart';
import 'package:normalpranzoapp/models/product.dart';
import 'package:normalpranzoapp/pages/single_product_page.dart';

class ProductsView extends StatefulWidget {
  final List<Product> list;
  final String title;
  final bool isDeal;

  ProductsView({this.list, this.title, this.isDeal});

  @override
  _ProductsViewState createState() =>
      _ProductsViewState(listProducts: list, title: title, isDeal: isDeal);
}

class _ProductsViewState extends State<ProductsView> {
  List<Product> listProducts;
  String title;
  bool isDeal;
  int quantity = 0;

  _ProductsViewState({this.listProducts, this.title, this.isDeal});

  @override
  void initState() {
    super.initState();
    quantity = Cart.cart.getProductQuantity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.optpAppBarB(
          title: title,
          onPressed: () => Navigator.of(context).pop(),
          context: context),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: listProducts.length,
          itemBuilder: (BuildContext context, int index) =>
              getProductWidget(context, index)),
    );
  }

  Widget getProductWidget(BuildContext context, int index) {
    if (isDeal) {
      return getWidget(listProducts[index].image, listProducts[index].name,
          listProducts[index]);
    } else {
      return getWidget(listProducts[index].image, listProducts[index].name,
          listProducts[index]);
    }
  }

  Widget getWidget(String imageUrl, String name, Product product) {
    Image image = AppTheme.loadNetworkImage(
        url: product.image, boxFit: BoxFit.fill, height: 125, width: 125);
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
//                  width: MediaQuery.of(context).size.width * 0.35,
//                  height: MediaQuery.of(context).size.height * 0.15,
                  child: image),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: AppTheme.autoTextSizeWidget('$name'),
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Container(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => SingleProduct(
                product: product,
                title: name,
              ))),
    );
  }
}
