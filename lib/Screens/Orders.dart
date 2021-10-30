import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'Cart.dart';

// ignore: must_be_immutable
class Orders extends StatefulWidget {
  var customerInfo;
  Orders({Key? key, this.customerInfo}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  getUserOrders(customerInfo) async {
    print(customerInfo);
    print(customerInfo["id"]);
    var covert = Base64Codec().decode(widget.customerInfo["id"]);
    var utfC = utf8.decode(covert);
    var aStr = utfC.replaceAll(RegExp(r'[^0-9]'), '');
    var aInt = int.parse(aStr);
    print(aInt);
    var response = await http.get(Uri.parse(
        "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-10/customers/$aInt/orders.json"));
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    return jsonData;
  }

  @override
  void initState() {
    super.initState();
    getUserOrders(widget.customerInfo);
  }

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
