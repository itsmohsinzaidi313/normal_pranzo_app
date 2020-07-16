import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/objects/cart.dart';
import 'package:normalpranzoapp/objects/product.dart';
import 'package:normalpranzoapp/pages/single_product_page.dart';

class ProductsView extends StatefulWidget {
  List<Product> list;
  String title;

  ProductsView({this.list, this.title});

  @override
  _ProductsViewState createState() =>
      _ProductsViewState(list: list, title: title);
}

class _ProductsViewState extends State<ProductsView> {
  List<Product> list;
  String title;
  int quantity = 0;

  _ProductsViewState({this.list, this.title});

  @override
  void initState() {
    quantity = Cart.cart.getProductQuantity();
  }

  @override
  Widget build(BuildContext context) {
    Cart.cart = new Cart();
    return Scaffold(
      appBar: AppTheme.optpAppBarB(
          title: title,
          onPressed: () => Navigator.of(context).pop(),
          context: context),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) =>
              getProductWidget(context, index)),
    );
  }

  Widget getProductWidget(BuildContext context, int index) {
    Image image = Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTsphabW9FdQml5MQm_Z2lM8lDYBcPe-GEocA&usqp=CAU',
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
    });
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: image),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: AppTheme.autoTextSizeWidget('${list[index].name}'),
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
                product: list[index],
                title: list[index].name,
              ))),
    );
  }
}
