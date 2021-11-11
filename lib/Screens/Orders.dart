import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

import '../utils/config.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var orderQuantity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Center(
        child: Container(
          width: dynamicWidth(context, .9),
          height: dynamicHeight(context, 1),
          child: Column(
            children: [
              SizedBox(
                height: dynamicHeight(context, .02),
              ),
              rowText("Orders", context),
              SizedBox(
                height: dynamicHeight(context, .01),
              ),
              // Text(
              //   "Total Orders : " + orderQuantity.toString(),
              // ),
              SizedBox(
                height: dynamicHeight(context, .01),
              ),
              getOrderCards(orderQuantity),
            ],
          ),
        ),
      ),
    );
  }
}

Widget orderCards(snapshot, orderQuantity) {
  return ListView.builder(
      itemCount: (snapshot as List).length,
      itemBuilder: (context, index) {
        orderQuantity = snapshot.length;
        return Container(
          padding: EdgeInsets.all(
            dynamicWidth(context, 0.03),
          ),
          margin: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .02),
            horizontal: dynamicWidth(context, .03),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              dynamicWidth(context, .04),
            ),
            boxShadow: [
              BoxShadow(
                color: myBlack.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: myWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("Order Number : " +
                    snapshot[index]["node"]["orderNumber"].toString()),
              ),
              SizedBox(
                height: dynamicHeight(context, 0.02),
              ),
              orderActualCard(
                context,
                snapshot[index]["node"]["lineItems"]["edges"],
              ),
              SizedBox(
                height: dynamicHeight(context, 0.01),
              ),
              Text(
                "Status : " +
                    snapshot[index]["node"]["fulfillmentStatus"].toString(),
              ),
              SizedBox(
                height: dynamicHeight(context, 0.01),
              ),
              Text(
                "Cancelled : " +
                    snapshot[index]["node"]["cancelReason"].toString(),
              ),
            ],
          ),
        );
      });
}

Widget orderActualCard(context, snaphot) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: (snaphot as List).length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .02),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (snaphot[index]["node"]["variant"] == null)
                  ? Image.asset(
                      "assets/Monark.png",
                      height: dynamicHeight(context, 0.15),
                      width: dynamicWidth(context, 0.2),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: snaphot[index]["node"]["variant"]["product"]
                            ["images"]["edges"][0]["node"]["src"],
                        fit: BoxFit.cover,
                        height: dynamicHeight(context, 0.15),
                        width: dynamicWidth(context, 0.2),
                      ),
                    ),
              SizedBox(
                height: dynamicHeight(context, 0.15),
                width: dynamicWidth(context, 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      snaphot[index]["node"]["title"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text("Quantity : " +
                        snaphot[index]["node"]["quantity"].toString()),
                    (snaphot[index]["node"]["variant"] == null)
                        ? Text("")
                        : Text("Price : " +
                            double.parse(snaphot[index]["node"]["variant"]
                                        ["product"]["variants"]["edges"][0]
                                    ["node"]["price"])
                                .toInt()
                                .toString()),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Widget getOrderCards(orderQuantity) {
  return Expanded(
    child: FutureBuilder(
      future: getUserOrders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == "Server Error") {
            return Center(
              child: SizedBox(
                height: dynamicHeight(context, .25),
                child: Image.asset("assets/network_error.png"),
              ),
            );
          } else if (snapshot.data == "Token Expired") {
            return Text("Token Expired");
          } else {
            return orderCards(snapshot.data, orderQuantity);
          }
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
