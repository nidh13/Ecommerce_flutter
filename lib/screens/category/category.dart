import 'dart:convert';
import 'package:ecomerce/screens/category/product_item.dart';
import 'package:ecomerce/screens/product/list_product.dart';
import 'package:ecomerce/services/category_service.dart';
import 'package:ecomerce/widgets/category_item.dart';
import 'package:ecomerce/services/product_service.dart';
import 'package:ecomerce/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  const Category({
    Key key,
  }) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool loading = true;
  final Color divider = Colors.grey.shade600;
  String nameCategory = "";
  var prdList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _fetchCategories();
  }

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }

  _fetchPrdByCat(String idCat) async {
    print("_fetchPrdByCat");
    var prdByCat = await ProductService().getProductsByCat(idCat);
    print(prdByCat.toString());
    if (prdByCat.length > 0) {
      setState(() {
        prdList = prdByCat;
      });
      print(prdList.toString());
    } else {
      setState(() {
        prdList = [];
      });
    }
  }

  var categoryList = [];
  _fetchCategories() async {
    print("_fetchCategories");
    var categories = await CategoryService().getCategory();
    print("categories.toString()");
    print(categories.toString());
    if (categories.length > 0) {
      setState(() {
        categoryList = categories;
        nameCategory = categories[0]["name"].toString();
        _fetchPrdByCat(categories[0]["id"].toString());
        //fetch Products of firs Cat
        // currentCat = cats[0]["id"];
      });

      print(categories.toString());
      // _fetchcatProducts();
    } else {
      setState(() {
        categoryList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: Text(
                        'Recherche sur moll',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            width: 35,
            child: Center(
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  onPressed: null),
            ),
          )
        ],
      ),
      body: Container(
        child: loading
            ? CircularProgressIndicator()
            : Container(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: ListView.builder(
                          itemCount: categoryList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print(categoryList[index]['name']);
                                    setState(() {
                                      nameCategory = categoryList[index]['name']
                                          .toString();
                                      _fetchPrdByCat(
                                          categoryList[index]['id'].toString());
                                    });
                                  },
                                  child: CategoryItem(
                                    categoryList[index]['name'],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor,
                      ),
                      width: 5,
                    ),
                    Container(
                        width: 300,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).hoverColor,
                              ),
                              height: 7,
                            ),
                            Container(
                              child: FlatButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      "Tous les Produits",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'JosefinSans',
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.navigate_next_rounded,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ProductItem(
                                nameCategory: nameCategory, prdList: prdList),
                          ],
                        ))),
                  ],
                ),
              ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }
}
