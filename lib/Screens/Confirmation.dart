import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Cart.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      radius: MediaQuery.of(context).size.width / 4,
                      backgroundColor: Color(0xFFeeeeee),
                      child: Image.asset(
                        "assets/thumb.png",
                        width: MediaQuery.of(context).size.width / 2.3,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Confirmation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your Order has been placed\n\nSuccessfully",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                bottomButton1(context, "Back to Home", () {
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
