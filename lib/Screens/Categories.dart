import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'SeeAll.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = [];
  var categoryList;
  bool loading = false;

  addCategory() async {
    setState(() {
      loading = true;
    });
    categoryList = await getShopifyCategory();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    addCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        menuIcon: true,
        bgColor: noColor,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.04),
              ),
              child: rowText(
                "Categories",
                context,
              ),
            ),
            heightBox(context, .04),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.02),
                vertical: dynamicHeight(context, 0.02),
              ),
              child: Container(
                height: dynamicHeight(context, 0.05),
                width: dynamicWidth(context, 1),
                child: (loading == true)
                    ? Center(
                        child: JumpingDotsProgressIndicator(
                          color: darkTheme == true ? myWhite : myBlack,
                          numberOfDots: 5,
                          fontSize: dynamicWidth(context, .08),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          isSelected.add(false);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: dynamicWidth(context, 0.01)),
                            child: ChoiceChip(
                              label: Text(
                                categoryList[index]["node"]["title"],
                                style: TextStyle(
                                  color: isSelected[index] == true
                                      ? myWhite
                                      : darkTheme == true
                                          ? myWhite
                                          : myBlack,
                                ),
                              ),
                              selected: isSelected[index],
                              selectedColor: myRed,
                              backgroundColor:
                                  darkTheme == true ? darkThemeBlack : myWhite,
                              side: BorderSide(
                                color: darkTheme == true
                                    ? myWhite
                                    : myBlack.withOpacity(.3),
                                width: .1,
                              ),
                              labelStyle: TextStyle(),
                              onSelected: (value) {
                                if (isSelected[index] == true) {
                                  setState(() {
                                    isSelected[index] = false;
                                  });
                                } else if (isSelected.contains(true)) {
                                  for (var i = 0; i < isSelected.length; i++) {
                                    isSelected[i] = false;
                                  }
                                  setState(() {
                                    isSelected[index] = value;
                                  });
                                } else {
                                  setState(() {
                                    isSelected[index] = value;
                                  });
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(
              height: dynamicHeight(context, 0.01),
            ),
            (loading == true)
                ? Center()
                : detailGrid(
                    getShopifyCategory(),
                    context,
                    true,
                  ),
          ],
        ),
      ),
    );
  }
}
