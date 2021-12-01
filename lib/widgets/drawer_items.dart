import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:monark_app/Screens/AboutUs.dart';
import 'package:monark_app/Screens/contactUs.dart';
import 'package:monark_app/Screens/policies.dart';
import 'package:monark_app/Screens/store_finder.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

Widget drawerItems(context) {
  List drawerItemList = [
    {
      "text": "About Monark",
      "function": () {
        pop(context);
        push(context, AboutUs());
      },
    },
    {
      "text": "Policies",
      "function": () {
        pop(context);
        push(context, PoliciesPage());
      },
    },
    {
      "text": "Store Locator",
      "function": () {
        pop(context);
        push(context, StoreFinder());
      },
    },
    {
      "text": "Contact Us",
      "function": () {
        pop(context);
        push(context, ContactPage());
      },
    },
    {
      "text": darkTheme == true ? "Light Mode" : "Dark Mode",
      "function": () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        darkTheme = !darkTheme;

        await pref.setBool("darkThemeCheck", darkTheme);

        var snackBar = SnackBar(
          content: Text('Theme Changed'),
          duration: const Duration(milliseconds: 1000),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Phoenix.rebirth(context);
      },
    },
  ];
  return SafeArea(
    child: ColoredBox(
      color: darkTheme == true ? darkThemeBlack : myWhite,
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
                    color: darkTheme == true ? myWhite : myRed,
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
                        color: darkTheme == true ? myWhite : myBlack,
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
    ),
  );
}

Widget profilePicture(context) {
  return Column(
    children: [
      CircleAvatar(
        radius: dynamicWidth(context, .22),
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
