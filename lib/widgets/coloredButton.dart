import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

Widget coloredButton(context, text, {function = "", width = "", heigth = ""}) {
  return Material(
    borderRadius: BorderRadius.circular(
      dynamicWidth(context, .4),
    ),
    child: GestureDetector(
      onTap: function == "" ? () {} : function,
      child: Container(
        width: width == "" ? dynamicWidth(context, .8) : width,
        height: heigth == "" ? dynamicHeight(context, .048) : heigth,
        decoration: BoxDecoration(
          color: myRed,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .4),
          ),
        ),
        child: Center(
          child: AutoSizeText(
            text,
            style: TextStyle(
              color: myWhite,
              fontSize: dynamicWidth(context, .035),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget bottomButton1(context, text, page) {
  return Positioned(
    bottom: dynamicHeight(context, .05),
    child: InkWell(
      onTap: page,
      child: Container(
        height: dynamicHeight(context, .048),
        width: dynamicWidth(context, .8),
        decoration: BoxDecoration(
          color: myRed,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .08),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: myWhite,
              fontWeight: FontWeight.bold,
              fontSize: dynamicWidth(context, .035),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget bottomButton2(context, text, icon, {function, double bottom = 80}) {
  return Positioned(
    bottom: bottom,
    child: InkWell(
      onTap: function,
      child: Container(
        height: dynamicHeight(context, .047),
        width: dynamicWidth(context, .78),
        decoration: BoxDecoration(
          color: noColor,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, 1),
          ),
          border: Border.all(
            color: darkTheme == true ? myWhite : myRed,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: darkTheme == true ? myWhite : myRed,
              fontWeight: FontWeight.bold,
              fontSize: dynamicWidth(context, 0.035),
            ),
          ),
        ),
      ),
    ),
  );
}
