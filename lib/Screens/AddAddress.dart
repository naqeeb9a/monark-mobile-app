import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../config.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  var localAddressList = [];
  final _formKey = GlobalKey<FormState>();

  saveAddress() async {
    print(globalAccessToken);
    print(localAddressList);
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
      print(result.hasException);
      return "Server Error";
    } else {
      print(result.data!);
      return result.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: dynamicHeight(context, .02),
                    ),
                    rowText("Create Address", context),
                    SizedBox(
                      height: dynamicHeight(context, .014),
                    ),
                    addressInput(
                      context,
                      "First name",
                      "Enter Your Name",
                      TextInputType.name,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "Last name",
                      "Enter Your Name",
                      TextInputType.name,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "Address 1",
                      "Add Your Address",
                      TextInputType.streetAddress,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "Address 2",
                      "Add Your Address",
                      TextInputType.streetAddress,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "City",
                      "Enter your city name",
                      TextInputType.text,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "Province",
                      "Enter the Province Name",
                      TextInputType.text,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "Country",
                      "Enter the Province Name",
                      TextInputType.text,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "Postal Code",
                      "Enter your Postal Code",
                      TextInputType.phone,
                      localAddressList: localAddressList,
                    ),
                    addressInput(
                      context,
                      "Phone Number",
                      "Enter your Phone Number",
                      TextInputType.phone,
                      localAddressList: localAddressList,
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .1),
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
              var response = await saveAddress();
              if (response == "Server Error") {
                print(response);
              } else {
                print(response);
                print("success");
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
