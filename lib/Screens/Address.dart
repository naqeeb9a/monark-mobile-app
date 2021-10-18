import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/AddAddress.dart';
import 'package:monark_app/Screens/Cart.dart';

import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/config.dart';

import 'Payment.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                rowText("Address", context),
                SizedBox(
                  height: 20,
                ),
                addressListBuilder(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                )
              ],
            ),
          ),
          bottomButton2(context, "Add Address", Icons.home_outlined,
              function: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddAddress()));
          }),
          bottomButton1(context, "Continue to Payment", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Payment()));
          })
        ],
      ),
    );
  }

  Widget addressListBuilder(context) {
    return Obx(() {
      return (addressList.length == 0)
          ? Column(
              children: [
                Image.asset(
                  "assets/noAddress.png",
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 30,
                ),
                Text("No Addresses Found!")
              ],
            )
          : Expanded(
              child: ListView.builder(
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Radio(
                            value: index,
                            groupValue: int.parse(group.toString()),
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                group = value as int;
                              });
                            }),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(25)),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addressList[index][1],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[index][0],
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[index][6],
                                style: TextStyle(color: myGrey),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }));
    });
  }
}

Widget bottomButton2(context, text, icon, {function}) {
  return Positioned(
    bottom: 80,
    child: InkWell(
      onTap: function,
      child: DottedBorder(
        color: myRed,
        strokeWidth: 1,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width / 1.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: myRed,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(color:myRed),
                )
              ],
            )),
      ),
    ),
  );
}
