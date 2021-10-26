import 'package:flutter/material.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class SeeAll extends StatelessWidget {
  final bool check;
  final String text;
  final dynamic function;
  final dynamic checkProducts;

  SeeAll({
    Key? key,
    required this.text,
    this.function,
    this.checkProducts = false,
    required this.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar(context, true),
      body: Center(
        child: Container(
          width: dynamicWidth(context, .94),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .03),
                ),
                child: rowText(text, context),
              ),
              detailGrid(function, context, check, productCheck: checkProducts),
              SizedBox(
                height: dynamicHeight(context, .02),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget detailGrid(function, context, check, {productCheck = false}) {
  return Expanded(
    child: (check == true)
        ? FutureBuilder(
            future: function,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                if ((snapshot.data as List).length != 0) {
                  return GridView.builder(
                      itemCount: (snapshot.data as List).length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: dynamicWidth(context, .02),
                        crossAxisSpacing: dynamicHeight(context, .03),
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 1.5,
                      ),
                      itemBuilder: (context, index) {
                        return categoryCards(
                            context,
                            snapshot.data[index]["title"],
                            snapshot.data[index]["id"],
                            check: true);
                      });
                } else {
                  return Center(child: Text("No products Found"));
                }
              } else {
                return Image.asset(
                  "assets/loader.gif",
                  scale: 6,
                );
              }
            },
          )
        : FutureBuilder(
            future: function,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                if ((snapshot.data as List).length != 0) {
                  return GridView.builder(
                      itemCount: (snapshot.data as List).length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: dynamicWidth(context, .02),
                        crossAxisSpacing: dynamicHeight(context, .016),
                        crossAxisCount: 2,
                        childAspectRatio: 5 / 8,
                      ),
                      itemBuilder: (context, index) {
                        return (productCheck == true)
                            ? basicCards(
                                context,
                                snapshot.data[index]["image"]["src"],
                                snapshot.data[index]["title"],
                                price: snapshot.data[index]["variants"][0]
                                        ["price"]
                                    .toString()
                                    .substring(
                                        0,
                                        snapshot
                                                .data[index]["variants"][0]
                                                    ["price"]
                                                .length -
                                            3),
                                description: snapshot.data[index]["body_html"]
                                    .toString())
                            : basicCards(
                                context,
                                snapshot.data[index]["image"]["src"],
                                snapshot.data[index]["title"],
                                id: snapshot.data[index]["id"],
                                sizeOption: snapshot.data[index]["options"][0]
                                    ["values"],
                                description: snapshot.data[index]["body_html"]
                                    .toString(),
                              );
                      });
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
            }),
  );
}
