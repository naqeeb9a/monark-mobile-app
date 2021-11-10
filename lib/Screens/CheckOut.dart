import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Confirmation.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

import 'Payment.dart';

class CheckOut extends StatelessWidget {
  final String orderId;

  const CheckOut({Key? key, required this.orderId}) : super(key: key);

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
          Center(
            child: Container(
              width: dynamicWidth(context, .9),
              child: Column(
                children: [
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  rowText("CheckOut", context),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  Flexible(
                    child: Obx(() {
                      return (cartItems.length == 0)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/emptyCart.png"),
                                SizedBox(
                                  height: dynamicHeight(context, .02),
                                ),
                                Text("No Items in Cart")
                              ],
                            )
                          : cartList(check: true);
                    }),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  (addressList.length == 0)
                      ? Container(
                          padding: EdgeInsets.all(
                            dynamicWidth(context, .02),
                          ),
                          child: Text(
                            "No Address Added Yet!",
                            style: TextStyle(color: myRed),
                          ),
                        )
                      : Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(
                              dynamicWidth(context, .02),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addressList[group.value]["node"]["address1"],
                                  style: TextStyle(
                                      fontSize: dynamicWidth(context, .04),
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: dynamicHeight(context, .01),
                                ),
                                Text(
                                  addressList[group.value]["node"]["city"],
                                  style: TextStyle(
                                    fontSize: dynamicWidth(context, .04),
                                  ),
                                ),
                                SizedBox(
                                  height: dynamicHeight(context, .01),
                                ),
                                Text(
                                  addressList[group.value]["node"]
                                          ["firstName"] +
                                      " " +
                                      addressList[group.value]["node"]
                                          ["lastName"],
                                )
                              ],
                            ),
                          ),
                        ),
                  Divider(
                    thickness: 2,
                  ),
                  totalRow(
                    context,
                    "Subtotal",
                    "Rs " + subtotal.toString(),
                  ),
                  totalRow(context, "Discount", "0%"),
                  totalRow(context, "Shipping", "RS 0"),
                  Divider(
                    thickness: 2,
                  ),
                  totalRow(
                    context,
                    "Total",
                    r"Rs " + subtotal.toString(),
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .1),
                  )
                ],
              ),
            ),
          ),
          bottomButton1(context, "Buy", () async {
            var response = await orderItems(orderId);
            if (response == null) {
              var snackBar = SnackBar(
                content: Text("Try again Order not placed"),
                duration: const Duration(milliseconds: 1000),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmationPage(),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}

orderItems(orderId) async {
  var createUserAccessToken = r'''
mutation draftOrderComplete($id: ID!, $paymentPending: Boolean) {
  draftOrderComplete(id: $id, paymentPending: $paymentPending) {
    draftOrder {
      id
      order {
        id
      }
    }
  }
}
 ''';
  var orderVariables = {"id": "$orderId", "paymentPending": true};
  final HttpLink httpLink = HttpLink(
    "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-10/graphql.json",
  );
  GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  final QueryOptions options = QueryOptions(
      document: gql(createUserAccessToken), variables: orderVariables);
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    print(result.hasException);
    return "Server Error";
  } else {
    print(result.data!["draftOrderComplete"]["draftOrder"]["id"]);
    return result.data!["draftOrderComplete"]["draftOrder"]["id"];
  }
}
