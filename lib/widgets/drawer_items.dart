import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:monark_app/Screens/AboutUs.dart';
import 'package:monark_app/Screens/contactUs.dart';
import 'package:monark_app/Screens/policies.dart';
import 'package:monark_app/Screens/store_finder.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';

import '../utils/config.dart';

Widget drawerItems(context) {
  List drawerItemList = [
    {
      "text": "About Monark",
      "function": () {
        popUntil(context);
        push(context, AboutUs());
      },
    },
    {
      "text": "Policies",
      "function": () {
        popUntil(context);
        push(context, PoliciesPage());
      },
    },
    {
      "text": "Store Locator",
      "function": () {
        popUntil(context);
        push(context, StoreFinder());
      },
    },
    {
      "text": "Contact Us",
      "function": () {
        popUntil(context);
        push(context, ContactPage());
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
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .06),
              left: dynamicWidth(context, .08),
            ),
            child: Container(
              height: dynamicHeight(context, .23),
              child: ListView.builder(
                itemCount: drawerItemList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: dynamicHeight(context, .056),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0.0,
                        vertical: 0.0,
                      ),
                      minVerticalPadding: 0,
                      onTap: drawerItemList[index]["function"],
                      title: Text(
                        drawerItemList[index]["text"].toString(),
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .016),
              left: dynamicWidth(context, .08),
              right: dynamicWidth(context, .08),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontFamily: "Aeonik",
                    color: darkTheme == true ? myWhite : myBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: dynamicWidth(context, .04),
                  ),
                ),
                SwitcherButton(
                  value: darkTheme,
                  onColor: myWhite,
                  offColor: myBlack,
                  size: dynamicWidth(context, .1),
                  onChange: (value) async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    darkTheme = !darkTheme;

                    await pref.setBool("darkThemeCheck", darkTheme);

                    var snackBar = SnackBar(
                      content: Text('Theme Changed'),
                      duration: const Duration(milliseconds: 1000),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Phoenix.rebirth(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget profilePicture(context) {
  return Column(
    children: [
      CircleAvatar(
        radius: dynamicWidth(context, .18),
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
