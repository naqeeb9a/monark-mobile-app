import 'package:flutter/material.dart';
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
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(guestAddressList);
    var subtotal = 0;
    for (var u in cartItems) {
      subtotal += int.parse(u["total"].toString());
    }
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
            body: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    width: dynamicWidth(context, .9),
                    child: Column(
                      children: [
                        rowText("Payment", context),
                        heightBox(context, 0.07),
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
                                    color: darkTheme == true ? myWhite : myGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    dynamicWidth(context, .02),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      guestAddressList[9] == null ||
                                              guestAddressList[9] == ""
                                          ? "No phone Number Provided"
                                          : guestAddressList[9],
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
                                future: getUserData(globalAccessToken),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      width: dynamicWidth(context, 0.9),
                                      height: dynamicHeight(context, .16),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: dynamicWidth(context, 0.05),
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
                                                    snapshot.data["phone"] == ""
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
                        SizedBox(
                          height: dynamicHeight(context, .01),
                        ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    color: darkTheme == true ? myWhite : myRed,
                                    fontSize: dynamicWidth(context, .032),
                                  ),
                                ),
                              ],
                            ),
                            heightBox(context, 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          fontSize: dynamicWidth(context, .032),
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
                                          fontSize: dynamicWidth(context, .032),
                                        ),
                                      ),
                              ],
                            ),
                            heightBox(context, 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontFamily: "Aeonik",
                                    fontWeight: FontWeight.w700,
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontSize: dynamicWidth(context, .032),
                                  ),
                                ),
                                subtotal < 2000
                                    ? Text(
                                        "PKR. " +
                                            numberFormat(
                                                (subtotal + 200).toString()),
                                        style: TextStyle(
                                          fontFamily: "Aeonik",
                                          fontWeight: FontWeight.w700,
                                          color: darkTheme == true
                                              ? myWhite
                                              : myRed,
                                          fontSize: dynamicWidth(context, .032),
                                        ),
                                      )
                                    : Text(
                                        "PKR. " +
                                            numberFormat(subtotal.toString()),
                                        style: TextStyle(
                                          fontFamily: "Aeonik",
                                          fontWeight: FontWeight.w700,
                                          color: darkTheme == true
                                              ? myWhite
                                              : myRed,
                                          fontSize: dynamicWidth(context, .032),
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
                bottomButton1(context, "CheckOut", () async {
                  setState(() {
                    isLoading = true;
                  });
                  var response = await createDraftOrders(subtotal,
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
          width: dynamicWidth(context, 0.5),
          height: dynamicHeight(context, 0.02),
          alignment: Alignment.centerLeft,
          child: FittedBox(
            child: Text(
              text,
              style: TextStyle(
                color: darkTheme == true ? myWhite : myBlack,
                fontSize: dynamicWidth(context, .032),
              ),
              maxLines: 2,
            ),
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
