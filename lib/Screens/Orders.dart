import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';

import '../config.dart';
import 'Cart.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            rowText("Orders", context),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Text("Total Orders : " + cartItems.length.toString());
            }),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Flexible(
                  child: (cartItems.length == 0)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/emptyCart.png"),
                            SizedBox(
                              height: 20,
                            ),
                            Text("No Orders Yet !")
                          ],
                        )
                      : cartList(ordersPage: true));
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
            )
          ],
        ),
      ),
    );
  }
}
