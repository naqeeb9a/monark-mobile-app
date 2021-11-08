import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

Widget coloredButton(context, text, color, textColor, push,
    {page, function = ""}) {
  return InkWell(
    onTap: function == ""
        ? () {
            push == false
                ? Navigator.pop(context)
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => page,
                    ),
                  );
          }
        : function,
    child: Container(
      width: dynamicWidth(context, .8),
      height: dynamicHeight(context, .06),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .024),
        ),
        boxShadow: [
          BoxShadow(
            color: color == noColor
                ? color.withOpacity(0.0)
                : color.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: dynamicWidth(context, .056),
          ),
        ),
      ),
    ),
  );
}

Widget bottomButton1(context, text, page) {
  return Positioned(
    bottom: 20,
    child: InkWell(
      onTap: page,
      child: Container(
        height: dynamicHeight(context, .06),
        width: dynamicWidth(context, .8),
        decoration: BoxDecoration(
          color: myRed,
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .02),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: myWhite,
              fontSize: dynamicWidth(context, .046),
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
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: myRed,
        radius: Radius.circular(
          dynamicWidth(context, 0.02),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, 0.02),
          ),
          child: Container(
            height: dynamicHeight(context, .058),
            width: dynamicWidth(context, .78),
            decoration: BoxDecoration(
              color: noColor,
              borderRadius: BorderRadius.circular(
                dynamicWidth(context, 0.02),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: myRed,
                  size: dynamicWidth(context, 0.07),
                ),
                SizedBox(
                  width: dynamicWidth(context, 0.02),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: myRed,
                    fontSize: dynamicWidth(context, 0.05),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
