import 'package:flutter/material.dart';
import 'package:monark_app/api/api.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

import '../utils/config.dart';
import 'Confirmation.dart';

class Payment extends StatefulWidget {
  final bool guestCheck;

  const Payment({Key? key, this.guestCheck = false}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isLoading = false;

  dynamic discountPercentage = 0,
      discountStatus = 0,
      subtotal = 0,
      discountValue = 0,
      total = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    discount();
  }

  discount() {
    for (var u in cartItems) {
      subtotal += int.parse(u["total"].toString());
    }

    ApiData().getInfo("discounts").then((value) {
      discountStatus = value["status"];
      if (discountStatus == 1) {
        setState(() {
          discountPercentage = 0;
          discountPercentage = value["discount_percentage"];
          discountValue = ((subtotal / 100) * discountPercentage);
          total = subtotal - discountValue;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ? Scaffold(
            body: jumpingDots(context),
          )
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: myWhite,
            appBar: bar(
              context,
              leadingIcon: true,
              menuIcon: true,
              bgColor: noColor,
              function: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
            endDrawer: drawer(context),
            drawerScrimColor:
                darkTheme == true ? Colors.black54 : Colors.white54,
            body: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    width: dynamicWidth(context, 0.9),
                    height: dynamicHeight(context, 1),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          rowText("Payment", context),
                          heightBox(context, 0.03),
                          (widget.guestCheck == true)
                              ? Container(
                                  width: dynamicWidth(context, 0.9),
                                  height: dynamicHeight(context, .16),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: dynamicWidth(context, 0.05),
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color:
                                          darkTheme == true ? myWhite : myGrey,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      dynamicWidth(context, .02),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Information",
                                        style: TextStyle(
                                          color: darkTheme == true
                                              ? myWhite
                                              : myBlack,
                                          fontWeight: FontWeight.w600,
                                          fontSize: dynamicWidth(context, .032),
                                        ),
                                      ),
                                      Text(
                                        guestAddressList[0] +
                                            " " +
                                            guestAddressList[1],
                                        style: TextStyle(
                                          color: darkTheme == true
                                              ? myWhite
                                              : myBlack,
                                          fontSize: dynamicWidth(context, .032),
                                        ),
                                      ),
                                      Text(
                                        guestAddressList[8] == null ||
                                                guestAddressList[8] == ""
                                            ? "No phone Number Provided"
                                            : guestAddressList[8],
                                        style: TextStyle(
                                          color: darkTheme == true
                                              ? myWhite
                                              : myBlack,
                                          fontSize: dynamicWidth(context, .032),
                                        ),
                                      ),
                                      Text(
                                        guestAddressList[2],
                                        style: TextStyle(
                                          color: darkTheme == true
                                              ? myWhite
                                              : myBlack,
                                          fontSize: dynamicWidth(context, .032),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : FutureBuilder(
                                  future:
                                      getUserData(globalAccessToken, context),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Container(
                                        width: dynamicWidth(context, 0.9),
                                        height: dynamicHeight(context, .16),
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              dynamicWidth(context, 0.05),
                                          vertical: dynamicHeight(context, .01),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myGrey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            dynamicWidth(context, .02),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Information",
                                              style: TextStyle(
                                                color: darkTheme == true
                                                    ? myWhite
                                                    : myBlack,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    dynamicWidth(context, .032),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data["firstName"] +
                                                  " " +
                                                  snapshot.data["lastName"],
                                              style: TextStyle(
                                                color: darkTheme == true
                                                    ? myWhite
                                                    : myBlack,
                                                fontSize:
                                                    dynamicWidth(context, .032),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data["phone"] == null ||
                                                      snapshot.data["phone"] ==
                                                          ""
                                                  ? "No phone Number Provided"
                                                  : snapshot.data["phone"],
                                              style: TextStyle(
                                                color: darkTheme == true
                                                    ? myWhite
                                                    : myBlack,
                                                fontSize:
                                                    dynamicWidth(context, .032),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data["email"],
                                              style: TextStyle(
                                                color: darkTheme == true
                                                    ? myWhite
                                                    : myBlack,
                                                fontSize:
                                                    dynamicWidth(context, .032),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return jumpingDots(context);
                                    }
                                  },
                                ),
                          heightBox(context, 0.02),
                          radioOptions(context, "COD"),
                          heightBox(context, .016),
                          rowText("Shipping Address", context),
                          heightBox(context, .03),
                          radioOptions(
                            context,
                            widget.guestCheck == true
                                ? guestAddressList[2]
                                : addressList[group.value]["node"]["address1"],
                          ),
                          heightBox(context, 0.03),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .032),
                                    ),
                                  ),
                                  Text(
                                    "PKR. " + numberFormat(subtotal.toString()),
                                    style: TextStyle(
                                      fontFamily: "Aeonik",
                                      fontWeight: FontWeight.w700,
                                      color:
                                          darkTheme == true ? myWhite : myRed,
                                      fontSize: dynamicWidth(context, .032),
                                    ),
                                  ),
                                ],
                              ),
                              heightBox(context, 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .032),
                                    ),
                                  ),
                                  subtotal < 2000
                                      ? Text(
                                          "PKR . 200",
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w700,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .032),
                                          ),
                                        )
                                      : Text(
                                          "PKR . 0",
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w700,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .032),
                                          ),
                                        ),
                                ],
                              ),
                              heightBox(context, 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .032),
                                    ),
                                  ),
                                  discountStatus == 0
                                      ? Text(
                                          "PKR . 0",
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w700,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .032),
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "PKR . ${numberFormat(discountValue.toStringAsFixed(0))}",
                                              style: TextStyle(
                                                fontFamily: "Aeonik",
                                                fontWeight: FontWeight.w700,
                                                color: darkTheme == true
                                                    ? myWhite
                                                    : myRed,
                                                fontSize:
                                                    dynamicWidth(context, .032),
                                              ),
                                            ),
                                            Text(
                                              "Mobile App user Discount of $discountPercentage%",
                                              style: TextStyle(
                                                fontFamily: "Aeonik",
                                                fontWeight: FontWeight.w700,
                                                color: darkTheme == true
                                                    ? myWhite
                                                    : myRed,
                                                fontSize:
                                                    dynamicWidth(context, .024),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                              heightBox(context, 0.05),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontFamily: "Aeonik",
                                      fontWeight: FontWeight.w700,
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .04),
                                    ),
                                  ),
                                  subtotal < 2000
                                      ? Text(
                                          "PKR. " +
                                              numberFormat((total + 200)
                                                  .toStringAsFixed(0)),
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w700,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .04),
                                          ),
                                        )
                                      : Text(
                                          "PKR. " +
                                              numberFormat(
                                                  total.toStringAsFixed(0)),
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w700,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .04),
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomButton1(context, "CheckOut", () async {
                  setState(() {
                    isLoading = true;
                  });
                  var response = await createDraftOrders(
                      total, discountValue, discountPercentage,
                      guestCheck: widget.guestCheck == true ? true : false);
                  if (response == null || response == "Server Error") {
                    setState(() {
                      isLoading = false;
                    });
                    var snackBar = SnackBar(
                      content: Text('Server Error check your internet'),
                      duration: const Duration(milliseconds: 1000),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    var response2 = await orderItems(response);
                    if (response2 == null || response2 == "Server Error") {
                      setState(() {
                        isLoading = false;
                      });
                      var snackBar = SnackBar(
                        content: Text("Try again Order not placed"),
                        duration: const Duration(milliseconds: 1000),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                            orderNumber: response2,
                          ),
                        ),
                      );
                    }
                  }
                })
              ],
            ),
          );
  }
}

Widget radioOptions(context, text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: darkTheme == true ? myWhite : myBlack,
        ),
        child: Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: true,
          groupValue: true,
          onChanged: (value) {},
          activeColor: myRed,
          visualDensity: VisualDensity(horizontal: -4),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          left: dynamicWidth(context, .01),
        ),
        child: Container(
          width: dynamicWidth(context, .8),
          height: dynamicHeight(context, 0.02),
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              color: darkTheme == true ? myWhite : myBlack,
              fontSize: dynamicWidth(context, .032),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}

Widget totalRow(context, text, price) {
  return Container(
    margin: EdgeInsets.all(
      dynamicWidth(context, .01),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: darkTheme == true ? myWhite : myBlack,
            fontSize: dynamicWidth(context, .032),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: darkTheme == true ? myWhite : myBlack,
            fontSize: dynamicWidth(context, .032),
          ),
        ),
      ],
    ),
  );
}
