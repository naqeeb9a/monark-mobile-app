import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../utils/config.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool isloading = false;
  var localAddressList = [];
  final _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  saveAddress() async {
    var addressQuery = r'''
    mutation customerAddressCreate($customerAccessToken: String!, $address: MailingAddressInput!) {
  customerAddressCreate(
    customerAccessToken: $customerAccessToken
    address: $address
  ) {
    customerAddress {
      id
    }
    customerUserErrors {
      code
      field
      message
    }
  }
}
    ''';
    var variable = {
      "customerAccessToken": "$globalAccessToken",
      "address": {
        "firstName": localAddressList[0].toString(),
        "lastName": localAddressList[1].toString(),
        "address1": localAddressList[2].toString(),
        "address2": localAddressList[3].toString(),
        "city": localAddressList[4].toString(),
        "province": localAddressList[5].toString(),
        "country": localAddressList[6].toString(),
        "zip": localAddressList[7].toString(),
        "phone": localAddressList[8].toString()
      }
    };
    final HttpLink httpLink = HttpLink(
        "https://monark-clothings.myshopify.com/api/2021-10/graphql.json",
        defaultHeaders: {
          "X-Shopify-Storefront-Access-Token":
              "fce9486a511f6a4f45939c2c6829cdaa"
        });
    GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
    final QueryOptions options =
        QueryOptions(document: gql(addressQuery), variables: variable);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      return "Server Error";
    } else {
      return result.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: myWhite,
      appBar: bar(
        context,
        leadingIcon: true,
        menuIcon: true,
        bgColor: noColor,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: (isloading == true)
          ? Center(
              child: JumpingDotsProgressIndicator(
                color: darkTheme == true ? myWhite : myBlack,
                numberOfDots: 5,
                fontSize: dynamicWidth(context, .08),
              ),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    height: dynamicHeight(context, 1),
                    width: dynamicWidth(context, .9),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: dynamicHeight(context, .03),
                            ),
                            rowText("Create Address", context),
                            SizedBox(
                              height: dynamicHeight(context, .014),
                            ),
                            addressInput(context, "First name",
                                "Enter Your Name", TextInputType.name,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            addressInput(context, "Last name",
                                "Enter Your Name", TextInputType.name,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            addressInput(context, "Address 1",
                                "Add Your Address", TextInputType.streetAddress,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            addressInput(
                              context,
                              "Address 2",
                              "Add Your Address",
                              TextInputType.streetAddress,
                              localAddressList: localAddressList,
                            ),
                            addressInput(context, "City",
                                "Enter your city name", TextInputType.text,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            addressInput(context, "Province",
                                "Enter the Province Name", TextInputType.text,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            addressInput(context, "Country",
                                "Enter the Province Name", TextInputType.text,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            addressInput(context, "Postal Code",
                                "Enter your Postal Code", TextInputType.phone,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            addressInput(context, "Phone Number",
                                "Enter your Phone Number", TextInputType.phone,
                                localAddressList: localAddressList,
                                function: (value) {
                              if (value!.isEmpty) {
                                return "Please complete this field";
                              }
                            }),
                            SizedBox(
                              height: dynamicHeight(context, .1),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottomButton1(
                  context,
                  "Add Address",
                  () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    setState(() {
                      isloading = true;
                    });
                    var response = await saveAddress();
                    if (response == "Server Error") {
                    } else if (response["customerAddressCreate"]
                            ["customerAddress"] ==
                        null) {
                      setState(() {
                        isloading = false;
                      });
                      var snackBar = SnackBar(
                        content: Text(
                            'Error!! Check your Details, make sure they are accurate'),
                        duration: const Duration(seconds: 2),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.pop(context, () {
                        setState(() {});
                      });
                    }
                  },
                )
              ],
            ),
    );
  }
}
