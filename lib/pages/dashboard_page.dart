import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/config.dart';
import 'package:normalpranzoapp/models/cart.dart';
import 'package:normalpranzoapp/models/restaurant.dart';
import 'package:normalpranzoapp/pages/categories_page.dart';

class DashBoardView extends StatefulWidget {
  final List<Restaurant> restaurants = [];

  DashBoardView(List<Restaurant> restaurants) {
    this.restaurants.addAll(restaurants);
  }

  @override
  _DashBoardViewState createState() => _DashBoardViewState(restaurants);
}

class _DashBoardViewState extends State<DashBoardView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Restaurant> restaurants = [];
  List<Image> hotDealsImages = [];
  int quantity = 0;

  _DashBoardViewState(List<Restaurant> restaurants) {
    this.restaurants.addAll(restaurants);
    this.restaurants.forEach((element) {
      element.hotDeals.forEach((hotDeal) {
        hotDealsImages.add(
          AppTheme.loadNetworkImage(url: hotDeal.image, boxFit: BoxFit.fill),
          // Image.network(hotDeal.image, fit: BoxFit.fill, loadingBuilder:
          //     (BuildContext context, Widget child,
          //         ImageChunkEvent loadingProgress) {
          //   if (loadingProgress == null) return child;
          //   return Center(
          //     child: CircularProgressIndicator(
          //       value: loadingProgress.expectedTotalBytes != null
          //           ? loadingProgress.cumulativeBytesLoaded /
          //               loadingProgress.expectedTotalBytes
          //           : null,
          //     ),
          //   );
          // }),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Cart.cart = new Cart();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppTheme.optpAppBarB(
          title: 'Pranzo',
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          context: context),
      drawer: AppTheme.drawerWidget(context),
      body: ListView(
        children: <Widget>[
          Container(
              height: 400,
              width: 400,
              child: Carousel(
                dotSize: 3,
                images: hotDealsImages,
              )),
          Container(
              child: Center(
                  child: AppTheme.autoTextSizeWidget('BRANCHES',
                      fontWeight: FontWeight.bold,
                      fontColor: AppTheme.appThemeColor))),
          Container(
              width: Config.deviceDisplayWidth,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (BuildContext context, int index) =>
                      getRestaurant2Widget(context, index)))
        ],
      ),
    );
  }

  Widget getRestaurantWidget(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Card(
          child: Column(children: <Widget>[
            Image.network(
              restaurants[index].image,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            ListTile(
              title: AppTheme.autoTextSizeWidget('${restaurants[index].name}',
                  minFontSize: 16, maxFontSize: 18),
            ),
          ]),
        ),
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new CategoriesView(
                  list: restaurants[index].categories,
                ))),
      ),
    );
  }

  Widget getRestaurant2Widget(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: AppTheme.loadNetworkImage(
                      url: restaurants[index].image,
                      boxFit: BoxFit.fill,
                      height: 125,
                      width: 125)),
              Container(
                child: AppTheme.textWidget('${restaurants[index].name}',
                    fontSize: 18),
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
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new CategoriesView(
                list: restaurants[index].categories,
              ))),
    );
  }
}
