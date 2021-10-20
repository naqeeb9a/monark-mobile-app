import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../config.dart';

Widget coloredButton(context, text, page, color, textColor, push) {
  return InkWell(
    onTap: () {
      push == false
          ? Navigator.pop(context)
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
    },
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
