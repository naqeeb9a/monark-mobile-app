import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import '../utils/config.dart';

// ignore: must_be_immutable
class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            rowText("Orders", context),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Text("Total Orders : " + cartItems.length.toString());
            }),
            SizedBox(
              height: 20,
            ),
            getOrderCards(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
            )
          ],
        ),
      ),
    );
  }
}

Widget orderCards(snapshot) {
  return ListView.builder(
      itemCount: (snapshot as List).length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.amber,
          child: Column(
            children: [
              Text("Order Number : " +
                  snapshot[index]["node"]["orderNumber"].toString()),
              Text("Email : " + snapshot[index]["node"]["email"].toString()),
              Text("Status : " +
                  snapshot[index]["node"]["fulfillmentStatus"].toString()),
              Text("Cancelled : " +
                  snapshot[index]["node"]["cancelReason"].toString()),
              orderActualCard(
                  context, snapshot[index]["node"]["lineItems"]["edges"])
            ],
          ),
        );
      });
}

Widget orderActualCard(context, snaphot) {
  return ListView.builder(
      itemCount: (snaphot as List).length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          child: Row(
            children: [
              (snaphot[index]["node"]["variant"] == null)
                  ? SizedBox()
                  : CachedNetworkImage(
                      imageUrl: snaphot[index]["node"]["variant"]["product"]
                          ["images"]["edges"][0]["node"]["src"],
                      height: 100,
                      width: 100,
                    ),
              Column(
                children: [
                  Text(snaphot[index]["node"]["title"]),
                  Text(snaphot[index]["node"]["quantity"].toString()),
                ],
              ),
            ],
          ),
        );
      });
}

Widget getOrderCards() {
  return Expanded(
    child: FutureBuilder(
      future: getUserOrders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return (snapshot.data == "Server Error")
              ? Center(
                  child: Text("Server Error"),
                )
              : orderCards(snapshot.data);
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            child: Image.asset(
              "assets/loader.gif",
              scale: 6,
            ),
          );
        }
      },
    ),
  );
}
