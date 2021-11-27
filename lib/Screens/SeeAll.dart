import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class SeeAll extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar(context,
          menuIcon: true, bgColor: Colors.transparent, leadingIcon: true),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .03),
                  horizontal: dynamicWidth(context, 0.02)),
              child: rowText(text, context, check: true),
            ),
            detailGrid(function, context, check),
            SizedBox(
              height: dynamicHeight(context, .02),
            )
          ],
        ),
      ),
    );
  }
}

Widget detailGrid(function, context, check) {
  return Expanded(
    child: FutureBuilder(
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
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                  itemCount: (snapshot.data as List).length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: dynamicWidth(context, .01),
                    mainAxisSpacing: check == true
                        ? dynamicHeight(context, .01)
                        : dynamicHeight(context, .05),
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
                              sizeOption: snapshot.data[index]["node"]
                                  ["options"][0]["values"],
                              description: snapshot.data[index]["node"]
                                  ["description"],
                              check: snapshot.data[index]["node"]
                                          ["availableForSale"] ==
                                      true
                                  ? false
                                  : true,
                            ),
                    );
                  }),
            );
          } else {
            return Center(
              child: Text("No Products Found"),
            );
          }
        } else {
          return Image.asset(
            "assets/loader.gif",
            scale: 4,
          );
        }
      },
    ),
  );
}
