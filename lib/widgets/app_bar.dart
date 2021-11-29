import 'package:flutter/material.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../utils/config.dart';
import 'media_query.dart';

PreferredSizeWidget bar(context,
    {menuIcon = false,
    leadingIcon = false,
    bgColor,
    title = false,
    titleText = "",
    function = ""}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(
      dynamicHeight(context, .06),
    ),
    child: AppBar(
      centerTitle: false,
      titleSpacing: 0.0,
      title: title == true
          ? Transform(
              transform: Matrix4.translationValues(
                  -dynamicWidth(context, .1), 0.0, 0.0),
              child: (globalAccessToken == "guest")
                  ? Text(
                      "Hi, Guest",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontSize: dynamicWidth(context, .05),
                      ),
                    )
                  : FutureBuilder(
                      future: getUserData(globalAccessToken),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            snapshot.data["firstName"] +
                                " " +
                                snapshot.data["lastName"],
                            style: TextStyle(
                              color: myBlack,
                              fontSize: dynamicWidth(context, .05),
                            ),
                          );
                        } else {
                          return Transform(
                            transform: Matrix4.translationValues(
                                -dynamicWidth(context, .2),
                                -dynamicWidth(context, 0.03),
                                0.0),
                            child: JumpingDotsProgressIndicator(
                              numberOfDots: 5,
                              fontSize: dynamicWidth(context, .08),
                            ),
                          );
                        }
                      }),
            )
          : Container(),
      backgroundColor: bgColor,
      elevation: 0.0,
      leading: leadingIcon == true
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/icons/backIcon.png",
                color: darkTheme == false ? myBlack : myWhite,
                scale: .8,
              ),
            )
          : Container(),
      actions: [
        menuIcon == true
            ? IconButton(
                onPressed: function == "" ? () {} : function,
                icon: Image.asset(
                  "assets/icons/menuIcon.png",
                  color: darkTheme == false ? myBlack : myWhite,
                ),
              )
            : Container(),
      ],
    ),
  );
}
