import 'package:flutter/material.dart';
import 'package:monark_app/Screens/TrackOrder.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var orderQuantity = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        bgColor: Colors.transparent,
        menuIcon: true,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: Center(
        child: Container(
          width: dynamicWidth(context, .9),
          height: dynamicHeight(context, 1),
          child: Column(
            children: [
              SizedBox(
                height: dynamicHeight(context, .02),
              ),
              rowText("Order History", context),
              SizedBox(
                height: dynamicHeight(context, .01),
              ),
              SizedBox(
                height: dynamicHeight(context, .05),
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
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackOrder(
                orderNumber: snapshot[index]["node"]["orderNumber"].toString(),
              ),
            ),
          );
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (index + 1).toString() +
                      ". Order #MNK" +
                      snapshot[index]["node"]["orderNumber"].toString(),
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontSize: dynamicWidth(context, .04),
                  ),
                ),
                (snapshot[index]["node"]["cancelReason"] == "CUSTOMER" ||
                        snapshot[index]["node"]["cancelReason"] == "DECLINED" ||
                        snapshot[index]["node"]["cancelReason"] == "FRAUD" ||
                        snapshot[index]["node"]["cancelReason"] ==
                            "INVENTORY" ||
                        snapshot[index]["node"]["cancelReason"] == "OTHER")
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Cancelled",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, .04),
                            ),
                          ),
                          Text(
                            snapshot[index]["node"]["processedAt"]
                                .toString()
                                .substring(
                                  0,
                                  snapshot[index]["node"]["processedAt"]
                                          .toString()
                                          .length -
                                      10,
                                ),
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, .036),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            snapshot[index]["node"]["fulfillmentStatus"]
                                .toString(),
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, .036),
                            ),
                          ),
                          Text(
                            snapshot[index]["node"]["processedAt"]
                                .toString()
                                .substring(
                                  0,
                                  snapshot[index]["node"]["processedAt"]
                                          .toString()
                                          .length -
                                      10,
                                ),
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, .036),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            heightBox(context, 0.01),
            Divider(
              color: darkTheme == true ? myWhite : myBlack,
            ),
            heightBox(context, 0.01),
          ],
        ),
      );
    },
  );
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
            return Text(
              "Token Expired",
              style: TextStyle(
                color: darkTheme == true ? myWhite : myBlack,
                fontSize: dynamicWidth(context, .046),
              ),
            );
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
