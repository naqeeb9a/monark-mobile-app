import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../utils/config.dart';
import 'Confirmation.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isloading = false;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var subtotal = 0;
    for (var u in cartItems) {
      subtotal += int.parse(u["total"].toString());
    }
    return (isloading == true)
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                color: darkTheme == true ? myWhite : myBlack,
                numberOfDots: 5,
                fontSize: dynamicWidth(context, .08),
              ),
            ),
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
                        Container(
                          width: dynamicWidth(context, 0.9),
                          padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: myGrey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Information",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Sarah Tahir"),
                              Text("03070406873"),
                              Text("sarah@gmail.com"),
                            ],
                          ),
                        ),
                        heightBox(context, 0.02),
                        radioOptions("COD"),
                        SizedBox(
                          height: dynamicHeight(context, .01),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, 0.04)),
                          child: rowText("Shipping Address", context),
                        ),
                        heightBox(context, .01),
                        radioOptions(
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
                                        fontSize: dynamicWidth(context, 0.03)),
                                  ),
                                  Text(
                                    "Shipping",
                                    style: TextStyle(
                                        fontSize: dynamicWidth(context, 0.03)),
                                  ),
                                  heightBox(context, 0.03),
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: dynamicWidth(context, 0.05)),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PKR. " + subtotal.toString(),
                                    style: TextStyle(
                                        color: myRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: dynamicWidth(context, 0.03)),
                                  ),
                                  (subtotal < 2000)
                                      ? Text(
                                          "PKR. 200",
                                          style: TextStyle(
                                              color: myRed,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  dynamicWidth(context, 0.03)),
                                        )
                                      : Text(
                                          "PKR. 0",
                                          style: TextStyle(
                                              color: myRed,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  dynamicWidth(context, 0.03)),
                                        ),
                                  heightBox(context, 0.03),
                                  (subtotal < 2000)
                                      ? Text(
                                          "PKR. " + (subtotal + 200).toString(),
                                          style: TextStyle(
                                              color: myRed,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  dynamicWidth(context, 0.04)),
                                        )
                                      : Text(
                                          "PKR. " + subtotal.toString(),
                                          style: TextStyle(
                                              color: myRed,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  dynamicWidth(context, 0.04)),
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
                    isloading = true;
                  });
                  var response = await createDraftOrders(subtotal);
                  if (response == null || response == "Server Error") {
                    setState(() {
                      isloading = false;
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
                        isloading = false;
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

Widget radioOptions(text) {
  return Row(
    children: [
      Radio(value: true, groupValue: true, onChanged: (value) {}),
      Text(text)
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
        Text(text),
        Text(price),
      ],
    ),
  );
}
