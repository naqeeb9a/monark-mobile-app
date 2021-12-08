import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

import '../utils/config.dart';
import 'Confirmation.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isLoading = false;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                    width: dynamicWidth(context, 1),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, 0.04)),
                          child: rowText("Payment", context),
                        ),
                        heightBox(context, 0.07),
                        FutureBuilder(
                          future: getUserData(globalAccessToken),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                width: dynamicWidth(context, 0.9),
                                padding: EdgeInsets.all(
                                  dynamicWidth(context, 0.05),
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
                                  children: [
                                    Text(
                                      "Information",
                                      style: TextStyle(
                                        color: darkTheme == true
                                            ? myWhite
                                            : myBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: dynamicWidth(context, .034),
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
                                        fontSize: dynamicWidth(context, .034),
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
                                        fontSize: dynamicWidth(context, .034),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data["email"],
                                      style: TextStyle(
                                        color: darkTheme == true
                                            ? myWhite
                                            : myBlack,
                                        fontSize: dynamicWidth(context, .034),
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, 0.04)),
                          child: rowText("Shipping Address", context),
                        ),
                        heightBox(context, .01),
                        radioOptions(context,
                            addressList[group.value]["node"]["address1"]),
                        heightBox(context, 0.06),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, 0.04)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .034),
                                    ),
                                  ),
                                  Text(
                                    "Shipping",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .034),
                                    ),
                                  ),
                                  heightBox(context, 0.03),
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .034),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PKR. " + subtotal.toString(),
                                    style: TextStyle(
                                      fontFamily: "Aeonik",
                                      fontWeight: FontWeight.w600,
                                      color:
                                          darkTheme == true ? myWhite : myRed,
                                      fontSize: dynamicWidth(context, .034),
                                    ),
                                  ),
                                  (subtotal < 2000)
                                      ? Text(
                                          "PKR. 200",
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w600,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .034),
                                          ),
                                        )
                                      : Text(
                                          "PKR. 0",
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w600,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .034),
                                          ),
                                        ),
                                  heightBox(context, 0.03),
                                  (subtotal < 2000)
                                      ? Text(
                                          "PKR. " + (subtotal + 200).toString(),
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w600,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .04),
                                          ),
                                        )
                                      : Text(
                                          "PKR. " + subtotal.toString(),
                                          style: TextStyle(
                                            fontFamily: "Aeonik",
                                            fontWeight: FontWeight.w600,
                                            color: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            fontSize:
                                                dynamicWidth(context, .04),
                                          ),
                                        ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottomButton1(context, "CheckOut", () async {
                  setState(() {
                    isLoading = true;
                  });
                  var response = await createDraftOrders(subtotal);
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
    children: [
      Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: darkTheme == true ? myWhite : myBlack,
        ),
        child: Radio(
          value: true,
          groupValue: true,
          onChanged: (value) {},
          activeColor: myRed,
        ),
      ),
      Text(
        text,
        style: TextStyle(
          color: darkTheme == true ? myWhite : myBlack,
          fontSize: dynamicWidth(context, .034),
        ),
      )
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
            fontSize: dynamicWidth(context, .034),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: darkTheme == true ? myWhite : myBlack,
            fontSize: dynamicWidth(context, .034),
          ),
        ),
      ],
    ),
  );
}
