import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/config.dart';
import 'package:normalpranzoapp/objects/deal.dart';
import 'package:normalpranzoapp/objects/restaurant.dart';
import 'package:normalpranzoapp/pages/categories_page.dart';

class DashBoardView extends StatefulWidget {
  List<Restaurant> list;

  DashBoardView({this.list});

  @override
  _DashBoardViewState createState() => _DashBoardViewState(list: list);
}

class _DashBoardViewState extends State<DashBoardView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Restaurant> list;
  List<Deal> hotDeals = [];
  int quantity = 0;

  _DashBoardViewState({this.list}) {
    this.list.forEach((element) {
      hotDeals.addAll(element.deals);
    });
  }

  List<Image> images = [
    Image.network(
        'https://www.refrigeratedfrozenfood.com/ext/resources/NEW_RD_Website/DefaultImages/default-pizza.jpg?1430942592',
        fit: BoxFit.fill, loadingBuilder: (BuildContext context, Widget child,
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
    }),
    Image.network(
        'https://cdn.shopify.com/s/files/1/1405/0664/products/4791207-9790062099-Pizza1_450x.jpg?v=1469649640',
        fit: BoxFit.fill, loadingBuilder: (BuildContext context, Widget child,
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
    }),
    Image.network(
        'https://www.24newshd.tv/uploads/facebook_post_images/2020-04-03/facebook_post_image_1585907355.jpg',
        fit: BoxFit.fill, loadingBuilder: (BuildContext context, Widget child,
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
    }),
    Image.network(
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-1.2.1&w=1000&q=80',
        fit: BoxFit.fill, loadingBuilder: (BuildContext context, Widget child,
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
    }),
  ];

  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height * 0.5,
              child: Carousel(
                images: images,
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
                  itemCount: list.length,
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
              list[index].image,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            ListTile(
              title: AppTheme.textWidget('${list[index].name}'),
            ),
          ]),
        ),
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new CategoriesView(
                  list: list[index].categories,
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
                  child: Image.network(list[index].image, loadingBuilder:
                      (BuildContext context, Widget child,
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
                child: AppTheme.textWidget('${list[index].name}'),
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
          builder: (BuildContext context) => new CategoriesView(
                list: list[index].categories,
              ))),
    );
  }
}
