import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/media_query.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

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
        backgroundColor: myGrey,
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
                                      fontSize: dynamicWidth(context, 0.06),
                                      fontWeight: FontWeight.bold,
                                      color: myWhite),
                                ),
                                TextSpan(
                                  text: "for your purchase from Monark",
                                  style: TextStyle(
                                    color: myWhite,
                                    fontSize: dynamicWidth(context, 0.04),
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
                              "Order #MNK55387",
                              style: TextStyle(
                                color: myRed,
                                fontSize: dynamicWidth(context, 0.038),
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
                              fontWeight: FontWeight.bold,
                              fontSize: dynamicWidth(context, 0.04),
                            ),
                          ),
                          heightBox(context, 0.01),
                          Text(
                            "You'll receive a confirmation email with your order number shortly.",
                            style: TextStyle(
                              fontSize: dynamicWidth(context, 0.036),
                            ),
                          ),
                          heightBox(context, 0.05),
                          Text(
                            "Order Updates",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: dynamicWidth(context, 0.04),
                            ),
                          ),
                          heightBox(context, 0.01),
                          Text(
                            "You'll get shipping and delivery updates",
                            style: TextStyle(
                              fontSize: dynamicWidth(context, 0.036),
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
                            onChanged: (value) {
                              setState(() {
                                emailCheck = value!;
                              });
                            }),
                        Text(
                          "via email",
                          style: TextStyle(
                            fontSize: dynamicWidth(context, 0.036),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: textCheck,
                            onChanged: (value1) {
                              setState(() {
                                textCheck = value1!;
                              });
                            }),
                        Text(
                          "via text",
                          style: TextStyle(
                            fontSize: dynamicWidth(context, 0.036),
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
