import 'package:flutter/material.dart';
import 'package:monark_app/Screens/AboutUs.dart';
import 'package:monark_app/Screens/contactUs.dart';
import 'package:monark_app/Screens/policies.dart';
import 'package:monark_app/Screens/store_finder.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

Widget drawerItems(context) {
  List drawerItemList = [
    {
      "text": "About Monark",
      "function": () {
        push(context, AboutUs());
      },
    },
    {
      "text": "Policies",
      "function": () {
        push(context, PoliciesPage());
      },
    },
    {
      "text": "Store Locator",
      "function": () {
        push(context, StoreFinder());
      },
    },
    {
      "text": "Contact Us",
      "function": () {
        push(context, ContactPage());
      },
    },
    {
      "text": "Dark Mode",
      "function": () {
        darkTheme = !darkTheme;
      },
    },
  ];
  return SafeArea(
    child: Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                pop(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .02),
                  horizontal: dynamicWidth(context, .03),
                ),
                child: Image.asset(
                  "assets/icons/crossIcon.png",
                  color: myRed,
                  height: dynamicHeight(context, .03),
                ),
              ),
            ),
          ],
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .12),
              left: dynamicWidth(context, .06),
            ),
            child: ListView.builder(
              itemCount: drawerItemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: drawerItemList[index]["function"],
                  title: Text(
                    drawerItemList[index]["text"].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: dynamicWidth(context, .044),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget profilePicture(context) {
  return Column(
    children: [
      CircleAvatar(
        radius: dynamicWidth(context, .16),
        backgroundColor: myRed,
        child: ClipOval(
          child: Image.asset(
            "assets/profile.png",
          ),
        ),
      ),
      SizedBox(
        height: dynamicHeight(context, .03),
      ),
    ],
  );
}
