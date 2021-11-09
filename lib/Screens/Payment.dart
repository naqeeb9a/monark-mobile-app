import 'package:flutter/material.dart';
import 'package:monark_app/Screens/CheckOut.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(cartItems);
    var subtotal = 0;
    for (var u in cartItems) {
      subtotal += int.parse(u["total"].toString());
    }
    return Scaffold(
      appBar: bar2(context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: dynamicWidth(context, .9),
              child: Column(
                children: [
                  rowText("Payment", context),
                  Image.asset(
                    "assets/delivery.png",
                    height: dynamicHeight(context, .3),
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .04),
                  ),
                  totalRow(
                    context,
                    "Subtotal",
                    "Rs. " + subtotal.toString(),
                  ),
                  totalRow(context, "Discount", "0%"),
                  totalRow(context, "Shipping", "Rs. 0"),
                  Divider(
                    thickness: 2,
                  ),
                  totalRow(
                    context,
                    "Total",
                    "Rs. " + subtotal.toString(),
                  )
                ],
              ),
            ),
          ),
          bottomButton2(
              context, "Cash On Delivery", Icons.delivery_dining_outlined),
          bottomButton1(context, "CheckOut", () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckOut(),
              ),
            );
          })
        ],
      ),
    );
  }
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
