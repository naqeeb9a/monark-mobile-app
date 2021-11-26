import 'package:flutter/material.dart';

import '../utils/config.dart';
import 'home_widgets.dart';
import 'media_query.dart';

PreferredSizeWidget bar(context,
    {menuIcon = false, leadingIcon = false, bgColor, title = false}) {
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
              child: Text(
                "Hi, UserName",
                style: TextStyle(
                  color: myBlack,
                  fontSize: dynamicWidth(context, .05),
                ),
              ),
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
              ),
            )
          : Container(),
      actions: [
        menuIcon == true
            ? IconButton(
                onPressed: () {
                  drawer(context);
                },
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
