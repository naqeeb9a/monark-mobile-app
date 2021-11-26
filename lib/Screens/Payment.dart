import 'package:flutter/material.dart';
import 'package:monark_app/Screens/CheckOut.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

import '../utils/config.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subtotal = 0;
    for (var u in cartItems) {
      subtotal += int.parse(u["total"].toString());
    }
    return Scaffold(
      appBar: bar(context),
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
                  (subtotal < 2000)
                      ? totalRow(context, "Shipping", "Rs. 200")
                      : totalRow(context, "Shipping", "Rs. 0"),
                  Divider(
                    thickness: 2,
                  ),
                  (subtotal < 2000)
                      ? totalRow(
                          context,
                          "Total",
                          "Rs. " + (subtotal + 200).toString(),
                        )
                      : totalRow(
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
          bottomButton1(context, "CheckOut", () async {
            var response = await createDraftOrders(subtotal);
            if (response == null || response == "Server Error") {
              var snackBar = SnackBar(
                content: Text('Server Error check your internet'),
                duration: const Duration(milliseconds: 1000),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckOut(
                    orderId: response,
                  ),
                ),
              );
            }
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
