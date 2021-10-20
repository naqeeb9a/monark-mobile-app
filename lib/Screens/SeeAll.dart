import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:http/http.dart' as http;

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
        appBar: bar(context, check: true),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              rowText(text, context),
              SizedBox(
                height: 20,
              ),
              detailGrid(function, context, check, productCheck: checkProducts),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
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
                return GridView.builder(
                    itemCount: (snapshot.data as List).length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
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
                return Image.asset(
                  "assets/loader.gif",
                  scale: 7,
                );
              }
            },
          )
        : FutureBuilder(
            future: function,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return GridView.builder(
                    itemCount: (snapshot.data as List).length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 8,
                    ),
                    itemBuilder: (context, index) {
                      return (productCheck == true)
                          ? basicCards(context, snapshot.data[index]["image"]["src"], snapshot.data[index]["title"],
                              price: snapshot.data[index]["variants"][0]["price"]
                                  .toString()
                                  .substring(
                                      0,
                                      snapshot.data[index]["variants"][0]["price"].length -
                                          3),
                              description: snapshot.data[index]["body_html"].toString().substring(
                                  3,
                                  snapshot.data[index]["body_html"].length - 4))
                          : basicCards(
                              context,
                              snapshot.data[index]["image"]["src"],
                              snapshot.data[index]["title"],
                              id: snapshot.data[index]["id"],
                              description: snapshot.data[index]["body_html"]
                                  .toString()
                                  .substring(3, snapshot.data[index]["body_html"].length - 4));
                    });
              } else {
                return Image.asset(
                  "assets/loader.gif",
                  scale: 7,
                );
              }
            }),
  );
}

getShopifyCollection(id) async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/collections/$id/products.json"));
  var jsonData = jsonDecode(response.body);
  return jsonData["products"];
}
