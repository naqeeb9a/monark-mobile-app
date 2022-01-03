import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

import 'AddAddress.dart';

class Cart extends StatefulWidget {
  final PageController controller;

  const Cart({Key? key, required this.controller}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final promoCode = TextEditingController();

  totalAmountCalculate(total) {
    for (int i = 0; i < cartItems.length; i++) {
      total = total + int.parse(cartItems[i]["total"].toString());
    }
  }

  var offset = [];

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
                                    widget.controller.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.easeInOut);
                                  },
                                ),
                              ],
                            )
                          : cartList(
                              setState: () {
                                setState(() {});
                              },
                            ),
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
                      push(
                          context,
                          AddAddress(
                            guestCheck: true,
                          ));
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
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                  width: dynamicWidth(context, .32),
                                  height: dynamicHeight(context, .038),
                                  child: inputTextField(
                                    context,
                                    "Promo Code",
                                    promoCode,
                                  ),
                                ),
                              ],
                            ),
                            heightBox(context, .02),
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

  Widget cartList({check, setState}) {
    var controller = [];

    dynamic offset = [];

    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        controller.add(AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)));
        offset.add(Tween<Offset>(begin: Offset.zero, end: Offset(-0.25, 0.0))
            .animate(controller[index]));
        return Container(
          height: dynamicHeight(context, 0.212),
          width: dynamicWidth(context, 1),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              InkWell(
                onTap: () {
                  cartItems.remove(cartItems[index]);
                  controller[index].dispose();
                  print(controller[index]);
                  controller.remove(controller[index]);
                  print(controller);

                  setState();
                },
                child: Container(
                  color: myRed,
                  alignment: Alignment.center,
                  height: dynamicHeight(context, 0.212),
                  width: dynamicWidth(context, 0.22),
                  child: Image.asset(
                    "assets/icons/bin.png",
                    height: dynamicHeight(context, 0.024),
                    color: myWhite,
                  ),
                ),
              ),
              GestureDetector(
                onHorizontalDragStart: (value) {
                  if (controller[index].status == AnimationStatus.dismissed)
                    controller[index].forward();
                },
                onHorizontalDragEnd: (value) {
                  if (controller[index].status == AnimationStatus.completed)
                    controller[index].reverse();
                },
                child: cartCard(context, index,
                    check: check,
                    setState: setState,
                    slidable: offset,
                    controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget cartCard(context, index,
      {check, setState, required slidable, required controller}) {
    return SlideTransition(
      position: slidable[index],
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, 0.036),
        ),
        decoration: BoxDecoration(
          color: myWhite,
          border: Border(
            bottom: BorderSide(
              width: .3,
              color: darkTheme == true ? myWhite : myBlack.withOpacity(.3),
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
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        cartItems[index]["quantity"].toString(),
                                    style: TextStyle(
                                      fontSize: dynamicWidth(context, .032),
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            print(controller);
                            switch (controller[index].status) {
                              case AnimationStatus.completed:
                                controller[index].reverse();
                                break;
                              case AnimationStatus.dismissed:
                                controller[index].forward();
                                break;
                              default:
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: dynamicWidth(context, .024),
                            ),
                            child: Image.asset(
                              "assets/icons/bin.png",
                              height: dynamicHeight(context, .03),
                              color: darkTheme == true
                                  ? myWhite.withOpacity(.6)
                                  : myBlack.withOpacity(.2),
                            ),
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
      ),
    );
  }
}
