import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class SeeAll extends StatefulWidget {
  final bool check;
  final String text;
  final dynamic function;

  SeeAll({
    Key? key,
    required this.text,
    this.function,
    required this.check,
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
      endDrawer: drawer(context),
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.04),
              ),
              child: rowText(
                widget.text,
                context,
                check: true,
                function2: () {
                  setState(() {});
                },
              ),
            ),
            heightBox(context, .06),
            detailGrid(widget.function, context, widget.check),
            SizedBox(
              height: dynamicHeight(context, .02),
            )
          ],
        ),
      ),
    );
  }
}

Widget detailGrid(function, context, check, {expandedCheck = true}) {
  return (expandedCheck == true)
      ? Expanded(child: detailGridExtension(function, context, check))
      : detailGridExtension(function, context, check);
}

Widget detailGridExtension(function, context, check) {
  return FutureBuilder(
    future: function,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data != null) {
        if (snapshot.data == "Server Error") {
          return Center(
            child: SizedBox(
              height: dynamicHeight(context, .25),
              child: Image.asset("assets/network_error.png"),
            ),
          );
        } else if ((snapshot.data as List).length != 0) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, .04),
            ),
            child: GridView.builder(
                itemCount: (snapshot.data as List).length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: dynamicWidth(context, .04),
                  mainAxisSpacing: check == true
                      ? dynamicHeight(context, .001)
                      : dynamicHeight(context, .02),
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 9,
                ),
                itemBuilder: (context, index) {
                  return Center(
                    child: check == true
                        ? basicCards(
                        context,
                        snapshot.data[index]["node"]["image"]["src"],
                        snapshot.data[index]["node"]["title"],
                        snapshot.data[index]["node"]["handle"],
                        categoriesCheck: true)
                        : basicCards(
                        context,
                        snapshot.data[index]["node"]["images"]["edges"],
                        snapshot.data[index]["node"]["title"],
                        snapshot.data[index]["node"]["availableForSale"],
                        variantProduct: snapshot.data[index]["node"]
                        ["variants"]["edges"],
                        sizeOption: snapshot.data[index]["node"]["options"]
                        [0]["values"],
                        description: snapshot.data[index]["node"]
                        ["description"],
                        productType: snapshot
                            .data[index]["node"]["productType"],
                        check: snapshot
                            .data[index]["node"]["availableForSale"] == true
                            ? false
                            : true,
                        wishList: snapshot.data[index]),
                  );
                }),
          );
        } else {
          return Center(
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
        return Image.asset(
          "assets/loader.gif",
          scale: 4,
        );
      }
    },
  );
}
