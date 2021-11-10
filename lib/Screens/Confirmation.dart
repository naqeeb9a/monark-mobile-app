import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/media_query.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: dynamicWidth(context, .26),
                      backgroundColor: myWhite,
                      child: Image.asset(
                        "assets/thumb.png",
                        width: dynamicWidth(context, .4),
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .04),
                    ),
                    Text(
                      "Confirmation",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: dynamicWidth(context, .08),
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .02),
                    ),
                    Text(
                      "Your Order has been placed\n\nSuccessfully",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                bottomButton1(context, "Back to Home", () {
                  cartItems.clear();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
