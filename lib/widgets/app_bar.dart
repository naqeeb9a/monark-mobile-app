import 'package:flutter/material.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

import '../utils/config.dart';
import 'home_widgets.dart';
import 'media_query.dart';

PreferredSizeWidget bar(context,
    {menuIcon = false,
    leadingIcon = false,
    bgColor,
    title = false,
    titleText = "",
    function = "",
    refreshFucnction = "",
    iconColor = "",
    functionIcon = ""}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(
      dynamicHeight(context, .062),
    ),
    child: AppBar(
      centerTitle: false,
      titleSpacing: 0.0,
      title: title == true
          ? Transform(
              transform: Matrix4.translationValues(
                -dynamicWidth(context, .1),
                0.0,
                0.0,
              ),
              child: (globalAccessToken == "guest")
                  ? Text(
                      "Hi, Guest",
                      style: TextStyle(
                        fontFamily: "Aeonik",
                        color: darkTheme == true ? myWhite : myBlack,
                        fontSize: dynamicWidth(context, .04),
                      ),
                    )
                  : FutureBuilder(
                      future: getUserData(globalAccessToken),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == "Server Error") {
                            return InkWell(
                              onTap: refreshFucnction,
                              child: Icon(
                                Icons.refresh,
                                color: myBlack,
                              ),
                            );
                          } else {
                            return Text(
                              titleCase(snapshot.data["firstName"]) +
                                  " " +
                                  titleCase(snapshot.data["lastName"]),
                              style: TextStyle(
                                fontFamily: "Aeonik",
                                color: darkTheme == true ? myWhite : myBlack,
                                fontSize: dynamicWidth(context, .04),
                              ),
                            );
                          }
                        } else {
                          return Transform(
                            transform: Matrix4.translationValues(
                                -dynamicWidth(context, .2),
                                -dynamicWidth(context, 0.03),
                                0.0),
                            child: Center(
                              child: jumpingDots(context),
                            ),
                          );
                        }
                      },
                    ),
            )
          : Container(),
      backgroundColor: bgColor,
      elevation: 0.0,
      leading: leadingIcon == true
          ? IconButton(
              onPressed: () {
                (functionIcon == "") ? Navigator.pop(context) : functionIcon();
              },
              icon: Image.asset(
                "assets/icons/backIcon.png",
                color: iconColor == ""
                    ? darkTheme == false
                        ? myBlack
                        : myWhite
                    : iconColor,
                height: dynamicHeight(context, .025),
              ),
            )
          : Container(),
      actions: [
        menuIcon == true
            ? IconButton(
                onPressed: function == "" ? () {} : function,
                icon: Image.asset(
                  "assets/icons/menuIcon.png",
                  height: dynamicHeight(context, .025),
                  color: iconColor == ""
                      ? darkTheme == false
                          ? myBlack
                          : myWhite
                      : iconColor,
                ),
              )
            : Container(),
      ],
    ),
  );
}
