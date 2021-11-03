import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import '../config.dart';
import 'Cart.dart';

// ignore: must_be_immutable
class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  getUserOrders() async {
    var createUserAccessToken = '''
{
    customer (customerAccessToken: "$globalAccessToken")
    {
         orders(first:5){
             edges{
                 node{
                     lineItems{
                         edges{
                             node{
                                 title
                             }
                         }
                     }
                 }
             }
         }
    }
}
 ''';
    final HttpLink httpLink = HttpLink(
        "https://monark-clothings.myshopify.com/api/2021-10/graphql.json",
        defaultHeaders: {
          "X-Shopify-Storefront-Access-Token":
              "fce9486a511f6a4f45939c2c6829cdaa"
        });
    GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
    final QueryOptions options = QueryOptions(
      document: gql(createUserAccessToken),
    );
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.hasException);
      return "Server Error";
    } else {
      print(result.data!["customer"]["orders"]["edges"]);
      return result.data!["customer"]["orders"]["edges"];
    }
  }

  @override
  void initState() {
    super.initState();
    getUserOrders();
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
