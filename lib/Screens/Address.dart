import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/AddAddress.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

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
         addresses(first:15){
             edges{
                 node{
                     address1
                     address2
                     city
                     country
                     firstName
                     lastName
                     zip
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
      return "Server Error";
    } else {
      return result.data!["customer"]["addresses"]["edges"];
    }
  }

  List addressListCheck = [], tempList = [];

  Future addr() async {
    return await getUserAddresses().then((value) {
      for (int i = 0; i < value.length; i++) {
        setState(() {
          addressListCheck.add(value[i]["node"]);
        });
      }

      // for(final i in tempList){
      //   if(!addressListCheck.contains(i["address1"])){
      //     addressListCheck.add(i);
      //   }
      // }
      // print(addressListCheck);

      // setState(() {
      //   addressListCheck = [
      //     ...{...tempList}
      //   ];
      // });

      // final jsonList = tempList.map((item) => jsonEncode(item)).toList();
      //
      // print(jsonList);
      //
      // final uniqueJsonList = jsonList.toSet().toList();
      // print(uniqueJsonList);
      //
      // setState(() {
      //   addressListCheck =
      //       uniqueJsonList.map((item) => jsonDecode(item)).toList();
      // });
      //
      // final jsonList = tempList.map((item) => jsonEncode(item)).toList();
      //
      // // using toSet - toList strategy
      // final uniqueJsonList = jsonList.toSet().toList();
      //
      // // convert each item back to the original form using JSON decoding
      // final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
      //
      // print(result);
      // setState(() {
      //   addressListCheck = tempList.toSet().toList();
      // });
      // print(addressListCheck.toSet().toList());
      // print(value);
      // setState(() {
      //   addressListCheck = value.toSet().toList();
      //   // addressListCheck.add(value);
      // });
      // for (int i = 0; i < value.length; i++) {
      //   addressListCheck.add(value[i]);
      // }
      // setState(() {
      //   addressListCheck = LinkedHashSet.from(addressListCheck).toList();
      //   // addressListCheck = addressListCheck.toSet().toList();
      // });

      //   for (int i = 0; i < value.length; i++) {
      //     for(int j = 0; j < value.length; j++){
      //       if (addressListCheck[i]["node"]["__typename"].toString() == addressListCheck[j]["node"]["__typename"].toString() &&
      //           addressListCheck[i]["node"]["address1"].toString() == addressListCheck[j]["node"]["address1"].toString() &&
      //           value[i]["node"]["address2"].toString() == addressListCheck[j]["node"]["address2"].toString() &&
      //           value[i]["node"]["city"].toString() == addressListCheck[j]["node"]["city"].toString() &&
      //           value[i]["node"]["country"].toString() == addressListCheck[j]["node"]["country"].toString() &&
      //           value[i]["node"]["firstName"].toString() == addressListCheck[j]["node"]["firstName"].toString() &&
      //           value[i]["node"]["lastName"].toString() == addressListCheck[j]["node"]["lastName"].toString() &&
      //           value[i]["node"]["zip"].toString() == addressListCheck[j]["node"]["zip"].toString()) {
      //         addressListCheck.removeAt(i);
      //       }
      //     }
      //   }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("address \n\n\n\n\n");
    print(globalAccessToken);
    addr();
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
                  (globalAccessToken == "")
                      ? SizedBox(
                          height: dynamicHeight(context, 0.6),
                          child: Center(child: Text("Sign in to continue")))
                      : addressListBuilder(context),
                  SizedBox(
                    height: widget.check == true
                        ? dynamicHeight(context, .1)
                        : dynamicHeight(context, .17),
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
                  if (globalAccessToken == "") {
                    var snackBar = SnackBar(
                      content: Text("Please Sign in to add Addresses"),
                      duration: const Duration(milliseconds: 1000),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAddress(),
                      ),
                    );
                  }
                }),
          widget.check == true
              ? Container()
              : bottomButton1(
                  context,
                  "Continue to Payment",
                  () {
                    if (globalAccessToken == "") {
                      var snackBar = SnackBar(
                        content: Text("Please sign in to continue"),
                        duration: const Duration(milliseconds: 1000),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (cartItems.isNotEmpty && addressList.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment(),
                        ),
                      );
                    } else {
                      var snackBar = SnackBar(
                        content: Text("No Address selected"),
                        duration: const Duration(milliseconds: 1000),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
        ],
      ),
    );
  }

  Widget addressListBuilder(context) {
    return Expanded(
      child: (addressListCheck == null)
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
              itemCount: addressListCheck.length,
              itemBuilder: (context, index) {
                addressList.add(addressListCheck[index]);
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, 0.01),
                  ),
                  child: Row(
                    children: [
                      Obx(() {
                        return Radio(
                            value: index,
                            groupValue: int.parse(group.toString()),
                            onChanged: (value) {
                              setState(() {
                                group.value = value as int;
                              });
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
                              addressListCheck[index]["address1"],
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
                              addressListCheck[index]["firstName"] +
                                  " " +
                                  addressListCheck[index]["lastName"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: dynamicWidth(context, 0.05),
                              ),
                            ),
                            SizedBox(
                              height: dynamicHeight(context, .01),
                            ),
                            Text(
                              addressListCheck[index]["city"],
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
                // if (addressListCheck.toString().isEmpty) {
                //
                // }
                // return Center(
                //   child: CircularProgressIndicator(
                //     color: myRed,
                //   ),
                // );
              },
            ),
    );
    // child: FutureBuilder(
    //   future: getUserAddresses(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.data == "Server Error") {
    //         return Center(
    //           child: SizedBox(
    //             height: dynamicHeight(context, .25),
    //             child: Image.asset("assets/network_error.png"),
    //           ),
    //         );
    //       } else {
    //         return (snapshot.data == null)
    //             ? Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Image.asset(
    //                     "assets/noAddress.png",
    //                     width: dynamicWidth(context, 0.5),
    //                   ),
    //                   SizedBox(
    //                     height: dynamicHeight(context, .03),
    //                   ),
    //                   Text("No Addresses Found!")
    //                 ],
    //               )
    //             : ListView.builder(
    //                 itemCount: (snapshot.data as List).length,
    //                 itemBuilder: (context, index) {
    //                   addressList.add(snapshot.data[index]);
    //                   if (snapshot.hasData) {
    //                     return Padding(
    //                       padding: EdgeInsets.symmetric(
    //                         vertical: dynamicHeight(context, 0.01),
    //                       ),
    //                       child: Row(
    //                         children: [
    //                           Obx(() {
    //                             return Radio(
    //                                 value: index,
    //                                 groupValue: int.parse(group.toString()),
    //                                 onChanged: (value) {
    //                                   setState(() {
    //                                     group.value = value as int;
    //                                   });
    //                                 });
    //                           }),
    //                           Container(
    //                             width: dynamicWidth(context, 0.75),
    //                             decoration: BoxDecoration(
    //                               border: Border.all(width: 1),
    //                               borderRadius: BorderRadius.circular(
    //                                 dynamicWidth(context, 0.04),
    //                               ),
    //                             ),
    //                             padding: EdgeInsets.symmetric(
    //                               horizontal: dynamicWidth(context, 0.04),
    //                               vertical: dynamicHeight(context, .01),
    //                             ),
    //                             child: Column(
    //                               crossAxisAlignment:
    //                                   CrossAxisAlignment.start,
    //                               children: [
    //                                 Text(
    //                                   snapshot.data[index]["node"]
    //                                       ["address1"],
    //                                   overflow: TextOverflow.ellipsis,
    //                                   style: TextStyle(
    //                                     fontSize: dynamicWidth(context, 0.06),
    //                                     fontWeight: FontWeight.w400,
    //                                   ),
    //                                   maxLines: 2,
    //                                 ),
    //                                 SizedBox(
    //                                   height: dynamicHeight(context, .01),
    //                                 ),
    //                                 Text(
    //                                   snapshot.data[index]["node"]
    //                                           ["firstName"] +
    //                                       " " +
    //                                       snapshot.data[index]["node"]
    //                                           ["lastName"],
    //                                   overflow: TextOverflow.ellipsis,
    //                                   style: TextStyle(
    //                                     fontSize: dynamicWidth(context, 0.05),
    //                                   ),
    //                                 ),
    //                                 SizedBox(
    //                                   height: dynamicHeight(context, .01),
    //                                 ),
    //                                 Text(
    //                                   snapshot.data[index]["node"]["city"],
    //                                   overflow: TextOverflow.ellipsis,
    //                                   style: TextStyle(
    //                                     color: myBlack,
    //                                     fontSize: dynamicWidth(context, 0.04),
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                   }
    //                   return Center(
    //                     child: CircularProgressIndicator(
    //                       color: myRed,
    //                     ),
    //                   );
    //                 },
    //               );
    //       }
    //     } else {
    //       return Center(
    //         child: JumpingDotsProgressIndicator(
    //           fontSize: dynamicWidth(context, .08),
    //           numberOfDots: 5,
    //         ),
    //       );
    //     }
    //   },
    // ),
  }
}
