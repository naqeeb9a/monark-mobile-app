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
              children: [rowText("Address", context)],
            ),
          ),
          bottomButton2(context),
          bottomButton1(context, "Continue to Payment", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Payment()));
          })
        ],
      ),
    );
  }
}

Widget bottomButton2(context) {
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
                Icons.home_outlined,
                color: Colors.lightBlue,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Add Address",
                style: TextStyle(color: Colors.lightBlue),
              )
            ],
          )),
    ),
  );
}
