import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context, cartCheck: true),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: dynamicWidth(context, .9),
              child: Column(
                children: [
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  rowText("Cart", context),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  Obx(() {
                    return Text("Total items : " + cartItems.length.toString());
                  }),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  Obx(() {
                    return Flexible(
                        child: (cartItems.length == 0)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/emptyCart.png"),
                                  SizedBox(
                                    height: dynamicHeight(context, .02),
                                  ),
                                  Text("No Items in Cart")
                                ],
                              )
                            : cartList());
                  }),
                  SizedBox(
                    height: dynamicHeight(context, .1),
                  ),
                ],
              ),
            ),
          ),
          bottomButton1(context, "Continue", () {
            if (cartItems.length == 0) {
              var snackBar = SnackBar(
                content: Text('Cart is empty'),
                duration: const Duration(milliseconds: 1000),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (globalAccessToken == "") {
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
          })
        ],
      ),
    );
  }
}

Widget cartList() {
  return ListView.builder(
    itemCount: cartItems.length,
    itemBuilder: (context, index) {
      return cartCard(
        index,
        context,
      );
    },
  );
}

Widget cartCard(
  index,
  context,
) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, 0.01),
    ),
    child: Container(
      padding: EdgeInsets.all(
        dynamicHeight(context, .014),
      ),
      decoration: BoxDecoration(
        color: myWhite,
        boxShadow: [
          BoxShadow(
            color: myBlack.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: cartItems[index]["imageUrl"],
              height: dynamicHeight(context, .13),
              width: dynamicWidth(context, .24),
              fit: BoxFit.cover,
            ),
            Container(
              width: dynamicWidth(context, .4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      cartItems[index]["title"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Price : ",
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .038),
                            color: myBlack,
                          ),
                        ),
                        TextSpan(
                          text: cartItems[index]["price"].toString() +
                              " x " +
                              cartItems[index]["quantity"].toString(),
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .042),
                            color: myRed,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Total : Rs.",
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .038),
                            color: myBlack,
                          ),
                        ),
                        TextSpan(
                          text: cartItems[index]["total"].toString(),
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .042),
                            color: myRed,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  cartItems.remove(cartItems[index]);
                },
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
