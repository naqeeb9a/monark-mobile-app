import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Confirmation.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:http/http.dart' as http;
import 'Payment.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subtotal = 0;
    for (var u in cartItems) {
      subtotal += int.parse(u["total"].toString());
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
                                addressList[group]["node"]["address1"],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[group]["node"]["city"],
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[group]["node"]["firstName"] +
                                    " " +
                                    addressList[group]["node"]["lastName"],
                              )
                            ],
                          ),
                        ),
                      ),
                Divider(
                  thickness: 2,
                ),
                totalRow("Subtotal", r"Rs " + subtotal.toString()),
                totalRow("Discount", r"0%"),
                totalRow("Shipping", r"RS 0"),
                Divider(
                  thickness: 2,
                ),
                totalRow("Total", r"Rs " + subtotal.toString()),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                )
              ],
            ),
          ),
          bottomButton1(context, "Buy", () async {
            var response = await orderItems();
            if (response == 201) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ConfirmationPage()));
            } else {
              var snackBar = SnackBar(
                        content: Text("No Address selected"),
                        duration: const Duration(milliseconds: 1000),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          })
        ],
      ),
    );
  }
}

orderItems() async {
  for (var i = 0; i < cartItems.length; i++) {
    var iddddd = base64Decode(cartItems[i]["variantId"]);
    var a = utf8.decode(iddddd);
    var aStr = a.replaceAll(new RegExp(r'[^0-9]'), '');
    var aInt = int.parse(aStr);
    var response = await http.post(
        Uri.parse(
            "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-10/orders.json"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "order": {
            "financial_status": "pending",
            "processing_method": "manual",
            "shipping_lines": [
              {
                "price": "0",
                "title": "Cash on Delivery",
                "source": "Lahore_post"
              }
            ],
            "tags": "ordered via mobile application",
            "line_items": [
              {
                "sku": cartItems[i]["sku"],
                "title": cartItems[i]["title"],
                "price": cartItems[i]["price"],
                "varient_id": aInt,
                "quantity": cartItems[i]["quantity"]
              }
            ]
          }
        }));
    print(response.statusCode);
    print(response.body);
    return response.statusCode;
  }
}
