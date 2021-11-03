import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';

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
        "country": localAddressList[4].toString(),
        "province": localAddressList[5].toString(),
        "city": localAddressList[6].toString(),
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
                    rowText("Create Address", context),
                    SizedBox(height: 20),
                    inputData(
                        "First name", "Enter Your Name", TextInputType.name,
                        localAddressList: localAddressList),
                    inputData(
                        "Last name", "Enter Your Name", TextInputType.name,
                        localAddressList: localAddressList),
                    inputData("Address 1", "Add Your Address",
                        TextInputType.streetAddress,
                        localAddressList: localAddressList),
                    inputData("Address 2", "Add Your Address",
                        TextInputType.streetAddress,
                        localAddressList: localAddressList),
                    inputData("Country", "Enter the Province Name",
                        TextInputType.text,
                        localAddressList: localAddressList),
                    inputData("Province", "Enter the Province Name",
                        TextInputType.text,
                        localAddressList: localAddressList),
                    inputData(
                        "City", "Enter your city name", TextInputType.text,
                        localAddressList: localAddressList),
                    inputData("Postal Code", "Enter your Postal Code",
                        TextInputType.phone,
                        localAddressList: localAddressList),
                    inputData("Phone Number", "Enter your Phone Number",
                        TextInputType.phone,
                        localAddressList: localAddressList),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 9,
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomButton1(
            context,
            "Add Address",
            () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              addressList.add(localAddressList);
              var response = saveAddress();
              if (response == "Server Error") {
                print(response);
              } else {
                print("success");
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

Widget inputData(text, hinttext, type, {localAddressList}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(
          text,
          style: TextStyle(color: Colors.grey),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hinttext,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please complete this field";
        }
      },
      onSaved: (value) {
        localAddressList.add(value);
      },
    ),
  );
}
