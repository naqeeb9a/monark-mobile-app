import 'package:flutter/material.dart';
import 'package:monark_app/Screens/AboutUs.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/Screens/Orders.dart';
import 'package:monark_app/Screens/Profile.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../config.dart';

Widget drawerItems(context) {
  List drawerItemList = [
    {
      "icon": Icons.person_outline,
      "text": "Profile",
      "screen": Profile(),
    },
    {
      "icon": Icons.shopping_cart_outlined,
      "text": "Orders",
      "screen": Orders(),
    },
    {
      "icon": Icons.location_on_outlined,
      "text": "Addresses",
      "screen": AddressPage(
        check: true,
      ),
    },
    {
      "icon": Icons.help_outline,
      "text": "Help",
      "screen": Orders(),
    },
    {
      "icon": Icons.star_outline,
      "text": "Rate Us",
      "screen": Orders(),
    },
    {
      "icon": Icons.info_outline,
      "text": "About Us",
      "screen": AboutUs(),
    }
  ];
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .03),
        ),
        child: profilePicture(context),
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
                      builder: (context) => drawerItemList[index]["screen"],
                    ),
                  );
                },
                leading: Icon(drawerItemList[index]["icon"]),
                title: Text(
                  drawerItemList[index]["text"].toString(),
                ),
              );
            }),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .03),
          horizontal: dynamicWidth(context, .1),
        ),
        child: MaterialButton(
          height: dynamicHeight(context, 0.07),
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
                size: dynamicWidth(context, .07),
              ),
              Text(
                "  Logout",
                style: TextStyle(
                  color: myWhite,
                  fontSize: dynamicWidth(context, .05),
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget profilePicture(context) {
  return Column(
    children: [
      CircleAvatar(
        minRadius: dynamicWidth(context, .16),
        backgroundColor: titleRed,
        backgroundImage: NetworkImage(
          "https://www.pngarts.com/files/11/Avatar-Transparent-Background-PNG.png?width=800",
        ),
      ),
      SizedBox(
        height: dynamicHeight(context, .03),
      ),
      Text(
        "Adam Balina",
        style: TextStyle(
          fontSize: dynamicWidth(context, .07),
          color: myBlack,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}
