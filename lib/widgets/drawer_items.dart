import 'package:flutter/material.dart';
import 'package:monark_app/Screens/AboutUs.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/Screens/Orders.dart';
import 'package:monark_app/Screens/Profile.dart';
import 'package:monark_app/Screens/Welcome.dart';

import '../config.dart';

Widget drawerItems(context) {
  List drawerItemList = [
    {"icon": Icons.person_outline, "text": "Profile", "screen": Profile()},
    {
      "icon": Icons.shopping_cart_outlined,
      "text": "Orders",
      "screen": Orders()
    },
    {
      "icon": Icons.streetview_sharp,
      "text": "Addresses",
      "screen": AddressPage(
        check: true,
      )
    },
    {"icon": Icons.help_outline, "text": "Help", "screen": Orders()},
    {"icon": Icons.star_outline, "text": "Rate Us", "screen": Orders()},
    {"icon": Icons.info_outline, "text": "About Us", "screen": AboutUs()}
  ];
  return Column(
    children: [
      SizedBox(
        height: 20,
      ),
      profilePicture(),
      SizedBox(
        height: 10,
      ),
      Flexible(
        child: ListView.builder(
            itemCount: drawerItemList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          drawerItemList[index]["screen"]));
                },
                leading: Icon(drawerItemList[index]["icon"]),
                title: Text(drawerItemList[index]["text"].toString()),
              );
            }),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
        child: MaterialButton(
          height: MediaQuery.of(context).size.height * 0.07,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: myRed,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Welcome(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_outlined,
                color: myWhite,
              ),
              Text(
                "  Logout",
                style: TextStyle(color: myWhite),
              ),
            ],
          ),
        ),
      )
    ],
  );
}