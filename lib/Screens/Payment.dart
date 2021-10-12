import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/CheckOut.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Home.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

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
                rowText("Payment", context),
                Image.asset(
                  "assets/delivery.png",
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                SizedBox(
                  height: 30,
                ),
                totalRow("Subtotal", r"$160"),
                totalRow("Discount", r"5%"),
                totalRow("Shipping", r"$10"),
                Divider(
                  thickness: 2,
                ),
                totalRow("Total", r"$162")
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
