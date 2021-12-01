import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  dynamic total = 0.obs;

  totalAmountCalculate() {
    for (int i = 0; i < cartItems.length; i++) {
      setState(() {
        total = total + int.parse(cartItems[i]["total"].toString()).obs;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    print("length\n\n\n");

    print(cartItems.length);
    totalAmountCalculate();
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: dynamicWidth(context, .9),
              child: Column(
                children: [
                  rowText("My Bag", context),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  Obx(() {
                    return Flexible(
                      child: cartItems.length == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/emptyCart.png"),
                                SizedBox(
                                  height: dynamicHeight(context, .02),
                                ),
                                Text(
                                  "No Items in Cart",
                                  style: TextStyle(
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontSize: dynamicWidth(context, .05),
                                  ),
                                )
                              ],
                            )
                          : cartList(),
                    );
                  }),
                  SizedBox(
                    height: dynamicHeight(context, .15),
                  ),
                ],
              ),
            ),
          ),
          cartItems.length == 0
              ? Container()
              : bottomButton1(
                  context,
                  "Checkout",
                  () {
                    if (globalAccessToken == "guest") {
                      var snackBar = SnackBar(
                        content: Text('Please Sign In to Continue'),
                        duration: const Duration(milliseconds: 1000),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressPage(),
                        ),
                      );
                    }
                  },
                ),
          Obx(() {
            return cartItems.length == 0
                ? Container()
                : Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: dynamicHeight(context, .1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .05),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, .05),
                            ),
                          ),
                          Text(
                            "PKR. $total",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: dynamicWidth(context, .044),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}

Widget cartList({check}) {
  return ListView.builder(
    itemCount: cartItems.length,
    itemBuilder: (context, index) {
      return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                cartItems.remove(cartItems[index]);
              },
              backgroundColor: myRed,
              foregroundColor: myWhite,
              icon: Icons.delete,
            ),
          ],
        ),
        child: cartCard(index, context, check: check),
      );
    },
  );
}

Widget cartCard(index, context, {check}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, 0.01),
    ),
    child: Container(
      color: noColor,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                dynamicWidth(context, .03),
              ),
              child: CachedNetworkImage(
                imageUrl: cartItems[index]["imageUrl"],
                height: dynamicHeight(context, .16),
                width: dynamicWidth(context, .26),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: dynamicWidth(context, .04),
            ),
            Container(
              width: (check == true)
                  ? dynamicWidth(context, 0.5)
                  : dynamicWidth(context, .6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      cartItems[index]["title"],
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Text(
                    "PKR. " + cartItems[index]["total"].toString(),
                    style: TextStyle(
                      fontSize: dynamicWidth(context, .04),
                      color: darkTheme == true ? myWhite : myRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Qty: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: dynamicWidth(context, .04),
                            color: darkTheme == true ? myWhite : myBlack,
                          ),
                        ),
                        TextSpan(
                          text: cartItems[index]["quantity"].toString(),
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .04),
                            color: darkTheme == true ? myWhite : myBlack,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Size: " + cartItems[index]["size"].toString(),
                    style: TextStyle(
                      fontSize: dynamicWidth(context, .04),
                      color: darkTheme == true ? myWhite : myBlack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
