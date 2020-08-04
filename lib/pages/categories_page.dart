import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/models/category.dart';
import 'package:normalpranzoapp/pages/products_page.dart';

class CategoriesView extends StatefulWidget {
  final List<Category> list = [];

  CategoriesView({List<Category> list}) {
    this.list.addAll(list);
  }

  @override
  _CategoriesViewState createState() =>
      _CategoriesViewState(listCategory: list);
}

class _CategoriesViewState extends State<CategoriesView> {
  final List<Category> listCategory = [];
  int quantity = 0;

  _CategoriesViewState({List<Category> listCategory}) {
    this.listCategory.addAll(listCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.optpAppBarB(
          title: 'MENU',
          onPressed: () => Navigator.of(context).pop(),
          context: context),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: listCategory.length,
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
                  child: AppTheme.loadNetworkImage(
                      url:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTsphabW9FdQml5MQm_Z2lM8lDYBcPe-GEocA&usqp=CAU',
                      boxFit: BoxFit.fill,
                      height: 125,
                      width: 125)),
              Container(
                child:
                    AppTheme.autoTextSizeWidget('${listCategory[index].name}'),
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
                list: listCategory[index].products,
                title: listCategory[index].name,
                isDeal: listCategory[index].isDeal,
              ))),
    );
  }
}
