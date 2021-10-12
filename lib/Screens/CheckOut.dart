import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Confirmation.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Home.dart';

import 'Payment.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

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
                rowText("CheckOut", context),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Obx(() {
                      return (cartItems.length == 0)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/emptyCart.png"),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("No Items in Cart")
                              ],
                            )
                          : cartList();
                    })),
                Divider(
                  thickness: 2,
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
          bottomButton1(context, "Buy", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfirmationPage()));
          })
        ],
      ),
    );
  }
}
