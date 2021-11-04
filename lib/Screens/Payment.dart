import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/CheckOut.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';

import '../config.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(cartItems);
    var subtotal = 0;
    for (var u in cartItems) {
      subtotal += int.parse(u["price"]);
    }
    return Scaffold(
      appBar: bar2(context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                rowText("Payment", context),
                Image.asset(
                  "assets/delivery.png",
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                SizedBox(
                  height: 30,
                ),
                totalRow("Subtotal", r"$ " + subtotal.toString()),
                totalRow("Discount", r"0%"),
                totalRow("Shipping", r"$ 0"),
                Divider(
                  thickness: 2,
                ),
                totalRow("Total", r"$ " + subtotal.toString())
              ],
            ),
          ),
          bottomButton2(
              context, "Cash On Delivery", Icons.delivery_dining_outlined),
          bottomButton1(context, "CheckOut", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CheckOut()));
          })
        ],
      ),
    );
  }
}

Widget totalRow(text, price) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text), Text(price)],
    ),
  );
}
