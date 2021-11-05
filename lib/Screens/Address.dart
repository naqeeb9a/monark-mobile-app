import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/AddAddress.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'Payment.dart';

class AddressPage extends StatefulWidget {
  final bool check;

  const AddressPage({Key? key, this.check = false}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  dynamic shopifyAddress;

  getUserAddresses() async {
    var createUserAccessToken = '''
{
    customer (customerAccessToken: "$globalAccessToken")
    {
         addresses(first:5){
             edges{
                 node{
                     address1
                     address2
                     city
                     country
                     firstName
                     lastName
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
      return result.data!["customer"]["addresses"]["edges"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: dynamicWidth(context, .92),
              child: Column(
                children: [
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  rowText("Address", context),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  addressListBuilder(context),
                  SizedBox(
                    height: widget.check == true
                        ? dynamicHeight(context, .3)
                        : dynamicHeight(context, .16),
                  )
                ],
              ),
            ),
          ),
          widget.check == true
              ? bottomButton2(
                  context,
                  "Add Address",
                  Icons.home_outlined,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAddress(),
                      ),
                    );
                  },
                  bottom: dynamicHeight(context, .02),
                )
              : bottomButton2(context, "Add Address", Icons.home_outlined,
                  function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAddress(),
                    ),
                  );
                }),
          widget.check == true
              ? Container()
              : bottomButton1(
                  context,
                  "Continue to Payment",
                  () {
                    // if (cartItems.isNotEmpty && addressList.isNotEmpty) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Payment(),
                    //     ),
                    //   );
                    // } else {
                      // var snackBar = SnackBar(
                      //   content: Text("No Address selected"),
                      //   duration: const Duration(milliseconds: 1000),
                      // );

                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Payment(),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }

  Widget addressListBuilder(context) {
    return Expanded(
      child: FutureBuilder(
        future: getUserAddresses(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.done) {
            return (snapshot.data == null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/noAddress.png",
                        width: dynamicWidth(context, 0.5),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, .03),
                      ),
                      Text("No Addresses Found!")
                    ],
                  )
                : ListView.builder(
                    itemCount: (snapshot.data as List).length,
                    itemBuilder: (context, index) {
                      addressList.add(snapshot.data[index]);
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: dynamicHeight(context, 0.01),
                        ),
                        child: Row(
                          children: [
                            Radio(
                                value: index,
                                groupValue: int.parse(group.toString()),
                                onChanged: (value) {
                                  setState(() {
                                    group = value as int;
                                  });
                                }),
                            Container(
                              width: dynamicWidth(context, 0.75),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, 0.04),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: dynamicWidth(context, 0.04),
                                vertical: dynamicHeight(context, .01),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index]["node"]["address1"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: dynamicWidth(context, 0.06),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: dynamicHeight(context, .01),
                                  ),
                                  Text(
                                    snapshot.data[index]["node"]["firstName"] +
                                        " " +
                                        snapshot.data[index]["node"]
                                            ["lastName"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: dynamicWidth(context, 0.05),
                                    ),
                                  ),
                                  SizedBox(
                                    height: dynamicHeight(context, .01),
                                  ),
                                  Text(
                                    snapshot.data[index]["node"]["city"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: myBlack,
                                      fontSize: dynamicWidth(context, 0.04),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          } else {
            return Center(
              child: JumpingDotsProgressIndicator(
                fontSize: dynamicWidth(context, .08),
                numberOfDots: 5,
              ),
            );
          }
        },
      ),
    );
  }
}
