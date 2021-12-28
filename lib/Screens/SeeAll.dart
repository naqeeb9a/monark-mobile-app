import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:recase/recase.dart';

class SeeAll extends StatefulWidget {
  final bool check;
  final String text;
  final dynamic function;
  final dynamic handle;

  SeeAll({
    Key? key,
    required this.text,
    this.function,
    required this.check,
    this.handle = "",
  }) : super(key: key);

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: bar(
        context,
        menuIcon: true,
        leadingIcon: true,
        bgColor: darkTheme == true ? darkThemeBlack : myWhite,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: dynamicWidth(context, 0.04),
                right: dynamicWidth(context, 0.012),
              ),
              child: rowText(
                widget.text,
                context,
                check: true,
              ),
            ),
            heightBox(context, .04),
            sortFilterCheck != ""
                ? getFilteredGrid(widget.handle, context, widget.check)
                : detailGrid(widget.function, context, widget.check),
            SizedBox(
              height: dynamicHeight(context, .02),
            )
          ],
        ),
      ),
    );
  }
}

getFilteredGrid(handle, context, check) {
  if (sortFilterCheck == "Best Sellers") {
    return detailGrid(
        getShopifyCollection(handle, sortKey: "BEST_SELLING"), context, check);
  } else if (sortFilterCheck == "Low - High") {
    return detailGrid(
        getShopifyCollection(handle, sortKey: "PRICE"), context, check);
  } else {
    return detailGrid(
        getShopifyCollection(handle, sortKey: "PRICE", reverse: true),
        context,
        check);
  }
}

Widget detailGrid(function, context, check,
    {expandedCheck = true, function1 = "", handle = ""}) {
  return (expandedCheck == true)
      ? Expanded(
          child: detailGridExtension(
              function, context, check, expandedCheck, function1, handle))
      : detailGridExtension(
          function, context, check, expandedCheck, function1, handle);
}

Widget detailGridExtension(
    function, context, check, expandedCheck, function1, handle) {
  return FutureBuilder(
    future: function,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data != null) {
        if (snapshot.data == "Server Error" || snapshot.data == false) {
          return Center(child: retryFunction(context, function: function1));
        } else if ((snapshot.data as List).length != 0) {
          return customGrid(context, expandedCheck, check, snapshot.data);
        } else {
          return check == true
              ? SingleChildScrollView(
                  child: detailGrid(
                      getShopifyCollection(handle), context, false,
                      expandedCheck: false),
                )
              : Center(
                  child: Text(
                    "No Products Found",
                    style: TextStyle(
                      color: darkTheme == true ? myWhite : myBlack,
                      fontSize: dynamicWidth(context, .05),
                    ),
                  ),
                );
        }
      } else {
        return (expandedCheck == true)
            ? Image.asset(
                "assets/loader.gif",
                scale: 4,
              )
            : SizedBox(
                height: dynamicHeight(context, 0.4),
                child: Image.asset(
                  "assets/loader.gif",
                  scale: 4,
                ),
              );
      }
    },
  );
}

Widget customGrid(context, expandedCheck, check, data) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .04),
    ),
    child: GridView.builder(
        itemCount: (data as List).length,
        physics: expandedCheck == true
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: expandedCheck == true ? false : true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: dynamicWidth(context, .03),
          mainAxisSpacing: check == true
              ? dynamicHeight(context, .001)
              : dynamicHeight(context, .01),
          crossAxisCount: 2,
          childAspectRatio: 5 / 8.5,
        ),
        itemBuilder: (context, index) {
          return Center(
            child: check == true
                ? basicCards(
                    context,
                    data[index]["url"],
                    data[index]["title"].toString().titleCase,
                    categoriesCheck: true,
                    handle: data[index]["handle"],
                  )
                : basicCards(context, data[index]["node"]["images"]["edges"],
                    data[index]["node"]["title"].toString().titleCase,
                    variantProduct: data[index]["node"]["variants"]["edges"],
                    sizeOption: data[index]["node"]["options"][0]["values"],
                    description: data[index]["node"]["description"],
                    productType: data[index]["node"]["productType"],
                    wishList: data[index],
                  ),
          );
        }),
  );
}
