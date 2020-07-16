import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/objects/category.dart';
import 'package:normalpranzoapp/pages/products_page.dart';

class CategoriesView extends StatefulWidget {
  List<Category> list = [];

  CategoriesView({this.list});

  @override
  _CategoriesViewState createState() => _CategoriesViewState(list: list);
}

class _CategoriesViewState extends State<CategoriesView> {
  List<Category> list = [];
  int quantity = 0;

  _CategoriesViewState({this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.optpAppBarB(
          title: 'MENU',
          onPressed: () => Navigator.of(context).pop(),
          context: context),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) =>
              getCategoriesWidgets(context, index)),
    );
  }

  Widget getCategoriesWidgets(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Image.network(
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
                  })),
              Container(
                child: AppTheme.autoTextSizeWidget('${list[index].name}'),
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
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
          builder: (BuildContext context) => ProductsView(
                list: list[index].products,
                title: list[index].name,
              ))),
    );
  }
}
