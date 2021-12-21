import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class Cart extends StatefulWidget {
  final PageController controller;

  const Cart({Key? key, required this.controller}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final promoCode = TextEditingController();

  totalAmountCalculate(total) {
    for (int i = 0; i < cartItems.length; i++) {
      total = total + int.parse(cartItems[i]["total"].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    globalContextMyBag = context;
    dynamic total = 0.obs;
    totalAmountCalculate(total);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        leadingIcon: true,
        menuIcon: true,
        bgColor: noColor,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        functionIcon: () {
          widget.controller.animateTo(0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut);
        },
      ),
      drawerScrimColor: Colors.white54,
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
                                Image.asset(
                                  "assets/icons/cartIcon.png",
                                  color: darkTheme == true ? myRed : myBlack,
                                  scale: 2.6,
                                ),
                                SizedBox(
                                  height: dynamicHeight(context, .02),
                                ),
                                Text(
                                  "Empty Bag",
                                  style: TextStyle(
                                    color: darkTheme == true ? myWhite : myRed,
                                    fontSize: dynamicWidth(context, .04),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                heightBox(context, .014),
                                Text(
                                  "Looks like you haven't made\nyour choice yet",
                                  style: TextStyle(
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontSize: dynamicWidth(context, .03),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                heightBox(context, .06),
                                coloredButton(
                                  context,
                                  "Continue Shopping",
                                  width: dynamicWidth(context, .6),
                                  function: () {
                                    Phoenix.rebirth(context);
                                  },
                                ),
                              ],
                            )
                          : cartList(setState: () {
                              setState(() {});
                            }),
                    );
                  }),
                  SizedBox(
                    height: dynamicHeight(context, .28),
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
          Obx(
            () {
              return cartItems.length == 0
                  ? Container()
                  : Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: dynamicHeight(context, .15),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dynamicWidth(context, .05),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Promo Code",
                                  style: TextStyle(
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontSize: dynamicWidth(context, .035),
                                  ),
                                ),
                                SizedBox(
                                  width: dynamicWidth(context, .4),
                                  child: inputTextField(
                                    context,
                                    "Promo Code",
                                    promoCode,
                                  ),
                                ),
                              ],
                            ),
                            heightBox(context, .014),
                            Divider(
                              color: darkTheme == true
                                  ? myWhite
                                  : myBlack.withOpacity(.3),
                              thickness: .3,
                            ),
                            heightBox(context, .014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontSize: dynamicWidth(context, .035),
                                  ),
                                ),
                                Text(
                                  "PKR. " + numberFormat(total),
                                  style: TextStyle(
                                    fontFamily: "Aeonik",
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: dynamicWidth(context, .035),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}

Widget cartList({check, setState}) {
  return ListView.builder(
    itemCount: cartItems.length,
    itemBuilder: (context, index) {
      return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          extentRatio: .25,
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                cartItems.remove(cartItems[index]);
                setState();
              },
              backgroundColor: myRed,
              foregroundColor: myWhite,
              icon: Icons.delete,
            ),
          ],
        ),
        child: cartCard(index, context, check: check, setState: setState),
      );
    },
  );
}

Widget cartCard(index, context, {check, setState}) {
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, 0.04),
    ),
    decoration: BoxDecoration(
      color: noColor,
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: myGrey,
        ),
      ),
    ),
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
              height: dynamicHeight(context, .14),
              width: dynamicWidth(context, .22),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItems[index]["title"],
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontSize: dynamicWidth(context, 0.034),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      "PKR. " +
                          numberFormat(
                            cartItems[index]["total"].toString(),
                          ),
                      style: TextStyle(
                        fontFamily: "Aeonik",
                        fontSize: dynamicWidth(context, .032),
                        color: darkTheme == true ? myWhite : myRed,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Size: " + cartItems[index]["size"].toString(),
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .032),
                            color: darkTheme == true ? myWhite : myBlack,
                          ),
                        ),
                        widthBox(context, 0.014),
                        Text(
                          "|",
                          style: TextStyle(color: myGrey),
                        ),
                        widthBox(context, 0.014),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Qty: ",
                                style: TextStyle(
                                  fontSize: dynamicWidth(context, .032),
                                  color: darkTheme == true ? myWhite : myBlack,
                                ),
                              ),
                              TextSpan(
                                text: cartItems[index]["quantity"].toString(),
                                style: TextStyle(
                                  fontSize: dynamicWidth(context, .032),
                                  color: darkTheme == true ? myWhite : myBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        dynamicWidth(context, .02),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/bin.png",
                            height: dynamicHeight(context, .03),
                            color: myBlack.withOpacity(.2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
