import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Confirmation.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';

import 'Payment.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                rowText("CheckOut", context),
                SizedBox(
                  height: 30,
                ),
                Flexible(child: Obx(() {
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
                (addressList.length == 0)
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No Address Added Yet!",
                          style: TextStyle(color: myRed),
                        ),
                      )
                    : Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addressList[group][1],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[group][0],
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[group][6],
                              )
                            ],
                          ),
                        ),
                      ),
                Divider(
                  thickness: 2,
                ),
                totalRow("Subtotal", r"$ " + subtotal.toString()),
                totalRow("Discount", r"0%"),
                totalRow("Shipping", r"$ 0"),
                Divider(
                  thickness: 2,
                ),
                totalRow("Total", r"$ " + subtotal.toString()),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                )
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
