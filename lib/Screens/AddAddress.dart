import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Payment.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

class AddAddress extends StatefulWidget {
  final bool guestCheck;

  const AddAddress({Key? key, this.guestCheck = false}) : super(key: key);

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
  void initState() {
    super.initState();
    guestAddressList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      body: (isloading == true)
          ? jumpingDots(context)
          : Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    height: dynamicHeight(context, 1),
                    width: dynamicWidth(context, .9),
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
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                addressInput(
                                    context, "Name", TextInputType.name,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                                heightBox(context, .012),
                                addressInput(
                                    context, "Last Name", TextInputType.name,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                                widget.guestCheck == true
                                    ? heightBox(context, .012)
                                    : heightBox(context, 0),
                                Visibility(
                                  visible:
                                      widget.guestCheck == true ? true : false,
                                  child: addressInput(context, "Email",
                                      TextInputType.emailAddress,
                                      localAddressList:
                                          widget.guestCheck == true
                                              ? guestAddressList
                                              : localAddressList,
                                      function: (value) {
                                    if (value!.isEmpty) {
                                      return "Please complete this field";
                                    }
                                  }),
                                ),
                                heightBox(context, .012),
                                addressInput(
                                    context, "Phone", TextInputType.phone,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                                heightBox(context, .012),
                                addressInput(context, "Address",
                                    TextInputType.streetAddress,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                                heightBox(context, .012),
                                addressInput(
                                    context, "City", TextInputType.text,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                                heightBox(context, .012),
                                addressInput(
                                    context, "Province", TextInputType.text,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                                heightBox(context, .012),
                                addressInput(
                                    context, "Country", TextInputType.text,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                                heightBox(context, .012),
                                addressInput(
                                    context, "Postal Code", TextInputType.phone,
                                    localAddressList: widget.guestCheck == true
                                        ? guestAddressList
                                        : localAddressList, function: (value) {
                                  if (value!.isEmpty) {
                                    return "Please complete this field";
                                  }
                                }),
                              ],
                            ),
                          )),
                          SizedBox(
                            height: dynamicHeight(context, .12),
                          )
                        ],
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
                    if (widget.guestCheck == true) {
                      push(
                          context,
                          Payment(
                            guestCheck: true,
                          ));
                    } else {
                      setState(() {
                        isloading = true;
                      });
                      var response = await saveAddress();
                      if (response == "Server Error") {
                        setState(() {
                          isloading = false;
                        });
                        var snackBar = SnackBar(
                          content: Text('Error!! check your internet'),
                          duration: const Duration(seconds: 2),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    }
                  },
                )
              ],
            ),
    );
  }
}
