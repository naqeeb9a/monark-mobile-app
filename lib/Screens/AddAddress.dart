import 'package:flutter/material.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Home.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  var localAddressList = [];
  final _formKey = GlobalKey<FormState>();

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
                    inputData("Name", "Enter Your Name", TextInputType.name,
                        localAddressList: localAddressList),
                    inputData("Address 1", "Add Your Address",
                        TextInputType.streetAddress,
                        localAddressList: localAddressList),
                    inputData("Address 2", "Add Your Address",
                        TextInputType.streetAddress,
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
