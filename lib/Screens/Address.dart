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
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  bool loading = false;

  Future addressClean() async {
    setState(() {
      loading = true;
    });
    addressList = await getUserAddresses();

    for (int i = 0; i < addressList.length; i++) {
      print("i $i " + addressList[i]['node']["address1"]);
      for (int j = 0; j < addressList.length; j++) {
        print("j $j " + addressList[j]['node']["address1"]);
        if (i != j) {
          if (addressList[i]['node']["address1"] ==
              addressList[j]['node']["address1"]) {
            print("\n\n\n\ntrue\n\n");
            addressList.removeAt(j);
            break;
          }
        }
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    addressClean();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        menuIcon: true,
        leadingIcon: true,
        bgColor: noColor,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: (loading == true)
          ? jumpingDots(context)
          : Stack(
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
                                child: Center(
                                  child: Text(
                                    "Sign in to continue",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, 0.05),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
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
                            content: Text(
                              "Please Sign in to add Addresses",
                              style: TextStyle(
                                color: darkTheme == true ? myWhite : myBlack,
                                fontSize: dynamicWidth(context, 0.05),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (cartItems.isNotEmpty &&
                              addressList.isNotEmpty) {
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

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                      ),
              ],
            ),
    );
  }

  Widget addressListBuilder(context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: addressList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                EdgeInsets.symmetric(vertical: dynamicHeight(context, 0.01)),
            child: Row(
              children: [
                Obx(() {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          darkTheme == true ? myWhite : myBlack,
                    ),
                    child: Radio(
                        value: index,
                        activeColor: myRed,
                        groupValue: int.parse(group.toString()),
                        onChanged: (value) {
                          setState(() {
                            group.value = value as int;
                          });
                        }),
                  );
                }),
                Container(
                  width: dynamicWidth(context, 0.75),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: darkTheme == true ? myWhite : myBlack,
                    ),
                    borderRadius: BorderRadius.circular(
                      dynamicWidth(context, 0.1),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: dynamicWidth(context, 0.04),
                    vertical: dynamicHeight(context, .01),
                  ),
                  child: Text(
                    addressList[index]["node"]["address1"].toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: darkTheme == true ? myWhite : myBlack,
                      fontSize: dynamicWidth(context, 0.04),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
