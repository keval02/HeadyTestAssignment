import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heady_assignment/src/model/category_sub_category_model.dart';
import 'package:heady_assignment/src/themes/theme.dart';
import 'package:heady_assignment/src/utilities/api_service_handler.dart';
import 'package:heady_assignment/src/utilities/api_url.dart';
import 'package:heady_assignment/src/utilities/app_helper.dart';
import 'package:heady_assignment/src/widgets/custom_category_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CategorySubCategoryModel categorySubCategoryModel =
      new CategorySubCategoryModel();

  @override
  void initState() {
    super.initState();
    getAllCategorySubCategoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 210,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _categoryWidget(),
          ],
        ),
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categorySubCategoryModel.categories
            .map(
              (category) => CategoryWidget(
                model: category,
                onSelected: (model) {
                  setState(() {
                    categorySubCategoryModel.categories.forEach((item) {
                      item.isSelected = false;
                    });
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

// The function is used to call the api for category, subcategory and products.
// Http get method is used to call the api and no params is required to pass.
// The return json format will contain all the details for category, subcategory and products and it will also return the most popular product, most buy product etc.
  void getAllCategorySubCategoryDetails() async {
    try {
      String apiResponse =
          await callGetMethod(APIURLs.categorySubCategoryAPIURL);

      if (jsonDecode(apiResponse) != null) {
        setState(() {
          categorySubCategoryModel =
              CategorySubCategoryModel.fromJson(json.decode(apiResponse));
          if (categorySubCategoryModel.categories != null &&
              categorySubCategoryModel.categories.length > 0) {}

          if (categorySubCategoryModel.rankings != null &&
              categorySubCategoryModel.rankings.length > 0) {}
        });
      } else {
        AppHelper.showToastMessage(AppHelper.message_something_went_wrong);
      }
    } catch (e) {
      AppHelper.showToastMessage(AppHelper.message_something_went_wrong);
      print(e.toString());
    }
  }
}
