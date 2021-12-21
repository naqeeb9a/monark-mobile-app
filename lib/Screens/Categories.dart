import 'package:flutter/material.dart';
import 'package:monark_app/api/api.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

import 'SeeAll.dart';

class CategoriesPage extends StatefulWidget {
  final PageController controller;
  CategoriesPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = [];
  var categoryList;
  bool loading = false;
  var settedCategory = 5;
  dynamic globalIndex = 0;

  addCategory() async {
    setState(() {
      loading = true;
    });
    categoryList = await ApiData().getInfo("categories");
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
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(context,
          menuIcon: true,
          bgColor: noColor,
          function: () {
            _scaffoldKey.currentState!.openEndDrawer();
          },
          leadingIcon: true,
          functionIcon: () {
            widget.controller.animateTo(0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut);
          }),
      drawerScrimColor: Colors.white54,
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
            heightBox(context, .02),
            searchbar(context),
            heightBox(context, .02),
            (loading == true)
                ? Expanded(child: Center(child: jumpingDots(context)))
                : (categoryList == false)
                    ? Expanded(
                        child: retryFunction(context, function: addCategory))
                    : categoryList.length == 0
                        ? Center(
                            child: Text(
                              "No Categories Found",
                              style: TextStyle(
                                color: darkTheme == true ? myWhite : myBlack,
                                fontSize: dynamicWidth(context, .05),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, 0.02),
                              vertical: dynamicHeight(context, 0.02),
                            ),
                            child: Container(
                              height: dynamicHeight(context, 0.05),
                              width: dynamicWidth(context, 1),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <= 0) {
                                    isSelected.add(true);
                                    globalIndex = 0;
                                  } else {
                                    isSelected.add(false);
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: dynamicWidth(context, 0.01),
                                    ),
                                    child: ChoiceChip(
                                      label: Text(
                                        categoryList[index]["title"],
                                        style: TextStyle(
                                          fontFamily: "Aeonik",
                                          fontSize: dynamicWidth(context, 0.03),
                                          fontWeight: FontWeight.w700,
                                          color: isSelected[index] == true
                                              ? myWhite
                                              : darkTheme == true
                                                  ? myWhite
                                                  : myBlack,
                                        ),
                                      ),
                                      selected: isSelected[index],
                                      selectedColor: myRed,
                                      backgroundColor: darkTheme == true
                                          ? darkThemeBlack
                                          : myWhite,
                                      side: BorderSide(
                                        color: darkTheme == true
                                            ? myWhite
                                            : myBlack.withOpacity(.3),
                                        width: .1,
                                      ),
                                      labelStyle: TextStyle(),
                                      onSelected: (value) {
                                        globalIndex = index;
                                        if (isSelected[index] == true) {
                                          setState(() {
                                            isSelected[index] = true;
                                          });
                                        } else if (isSelected.contains(true)) {
                                          for (var i = 0;
                                              i < isSelected.length;
                                              i++) {
                                            isSelected[i] = false;
                                          }
                                          setState(() {
                                            settedCategory =
                                                categoryList[index]["id"];
                                            isSelected[index] = value;
                                          });
                                        } else {
                                          setState(() {
                                            settedCategory =
                                                categoryList[index]["id"];
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
            categoryList == false ? Container() : heightBox(context, 0.025),
            loading == true
                ? Center()
                : categoryList == false
                    ? Container()
                    : detailGrid(
                        ApiData().getInfo("categories/$settedCategory"),
                        context,
                        true, function1: () {
                        setState(() {});
                      }, handle: categoryList[globalIndex]["handle"]),
          ],
        ),
      ),
    );
  }
}

Widget retryFunction(context, {function = "", check = false}) {
  return check == true
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/network_error.png",
              scale: 8,
              color: myRed,
            ),
            heightBox(context, 0.02),
            coloredButton(context, "retry",
                width: dynamicWidth(context, 0.2),
                heigth: dynamicHeight(context, 0.04))
          ],
        )
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "..OOPS",
              style: TextStyle(
                  fontSize: dynamicWidth(context, 0.028),
                  fontWeight: FontWeight.bold,
                  color: darkTheme == true ? myWhite : myBlack),
            ),
            heightBox(context, 0.04),
            Image.asset(
              "assets/network_error.png",
              scale: 2.6,
              color: myRed,
            ),
            heightBox(context, 0.02),
            Text(
              "No Internet Connection",
              style: TextStyle(
                  fontSize: dynamicWidth(context, 0.032),
                  color: darkTheme == true ? myWhite : myBlack),
            ),
            heightBox(context, 0.025),
            coloredButton(context, "Retry",
                width: dynamicWidth(context, 0.3), function: function),
          ],
        );
}
