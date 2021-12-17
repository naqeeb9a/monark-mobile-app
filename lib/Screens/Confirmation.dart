import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/media_query.dart';

class ConfirmationPage extends StatefulWidget {
  final String orderNumber;

  const ConfirmationPage({Key? key, this.orderNumber = ""}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  bool emailCheck = false;
  bool textCheck = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
        body: SafeArea(
          child: Container(
            height: dynamicHeight(context, 1),
            width: dynamicWidth(context, 1),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: dynamicHeight(context, 0.3),
                      width: dynamicWidth(context, 1),
                      color: myRed,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Thank you\n",
                                  style: TextStyle(
                                      fontFamily: "Aeonik",
                                      fontSize: dynamicWidth(context, 0.04),
                                      fontWeight: FontWeight.bold,
                                      color: myWhite),
                                ),
                                TextSpan(
                                  text: "for your purchase from Monark",
                                  style: TextStyle(
                                    color: myWhite,
                                    fontSize: dynamicWidth(context, 0.032),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: myWhite,
                              borderRadius: BorderRadius.circular(
                                dynamicWidth(context, 0.1),
                              ),
                            ),
                            padding: EdgeInsets.all(
                              dynamicWidth(context, 0.03),
                            ),
                            child: Text(
                              "Order " + widget.orderNumber,
                              style: TextStyle(
                                fontFamily: "Aeonik",
                                color: myRed,
                                fontSize: dynamicWidth(context, 0.032),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightBox(context, 0.05),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, 0.04),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your order is confirmed",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: dynamicWidth(context, 0.032),
                            ),
                          ),
                          heightBox(context, 0.01),
                          Text(
                            "You'll receive a confirmation email with your order number shortly.",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, 0.032),
                            ),
                          ),
                          heightBox(context, 0.05),
                          Text(
                            "Order Updates",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: dynamicWidth(context, 0.032),
                            ),
                          ),
                          heightBox(context, 0.01),
                          Text(
                            "You'll get shipping and delivery updates",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, 0.032),
                            ),
                          ),
                          heightBox(context, 0.007),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: emailCheck,
                            activeColor: darkTheme == true ? myWhite : myRed,
                            checkColor: darkTheme == true ? myBlack : myWhite,
                            onChanged: (value) {
                              setState(() {
                                emailCheck = value!;
                              });
                            }),
                        Text(
                          "via email",
                          style: TextStyle(
                            color: darkTheme == true ? myWhite : myBlack,
                            fontSize: dynamicWidth(context, 0.032),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: textCheck,
                            activeColor: darkTheme == true ? myWhite : myRed,
                            checkColor: darkTheme == true ? myBlack : myWhite,
                            onChanged: (value1) {
                              setState(() {
                                textCheck = value1!;
                              });
                            }),
                        Text(
                          "via text",
                          style: TextStyle(
                            color: darkTheme == true ? myWhite : myBlack,
                            fontSize: dynamicWidth(context, 0.032),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                bottomButton1(
                  context,
                  "Continue Shopping",
                  () {
                    cartItems.clear();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
