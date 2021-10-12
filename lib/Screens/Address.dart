import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Cart.dart';

import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Home.dart';

import 'Payment.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                rowText("Address", context),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/noAddress.png",
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("No Addresses Found!")
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomButton2(context, "Add Address", Icons.home_outlined),
          bottomButton1(context, "Continue to Payment", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Payment()));
          })
        ],
      ),
    );
  }
}

Widget bottomButton2(context, text, icon) {
  return Positioned(
    bottom: 80,
    child: DottedBorder(
      color: Colors.lightBlue,
      strokeWidth: 1,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width / 1.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.lightBlue,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.lightBlue),
              )
            ],
          )),
    ),
  );
}
