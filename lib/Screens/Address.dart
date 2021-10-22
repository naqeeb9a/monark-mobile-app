import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/AddAddress.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';

import 'Payment.dart';

class AddressPage extends StatefulWidget {
  final bool check;

  const AddressPage({Key? key, this.check = false}) : super(key: key);

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
                  height: (widget.check == true)
                      ? MediaQuery.of(context).size.height / 7
                      : MediaQuery.of(context).size.height / 5,
                )
              ],
            ),
          ),
          (widget.check == true)
              ? bottomButton2(context, "Add Address", Icons.home_outlined,
                  function: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAddress()));
                }, bottom: 20)
              : bottomButton2(context, "Add Address", Icons.home_outlined,
                  function: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAddress()));
                }),
          (widget.check == true)
              ? Container()
              : bottomButton1(context, "Continue to Payment", () {
                  if (cartItems.isNotEmpty && addressList.isNotEmpty) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Payment()));
                  } else {
                    var snackBar = SnackBar(
                      content: (cartItems.isEmpty)
                          ? Text('Cart is empty')
                          : Text("No Address selected"),
                      duration: const Duration(milliseconds: 1000),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
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
                              setState(() {
                                group = value as int;
                              });
                            }),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: dynamicWidth(context, 0.75),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(25)),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addressList[index][1],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[index][0],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                addressList[index][6],
                                overflow: TextOverflow.ellipsis,
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

Widget bottomButton2(context, text, icon, {function, double bottom = 80}) {
  return Positioned(
    bottom: bottom,
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
                  style: TextStyle(color: myRed),
                )
              ],
            )),
      ),
    ),
  );
}
