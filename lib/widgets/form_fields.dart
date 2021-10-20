import 'package:flutter/material.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../config.dart';

Widget inputTextField(context, obscureText, label, myController, {function}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (function == "") ? () {} : function,
    controller: myController,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    obscureText: obscureText,
    cursorColor: myBlack,
    cursorWidth: 2.0,
    cursorHeight: dynamicHeight(context, .034),
    decoration: InputDecoration(
      suffixIcon: obscureText == false
          ? null
          : InkWell(
              onTap: () {},
              child: Icon(
                Icons.remove_red_eye_rounded,
                color: myRed,
              ),
            ),
      contentPadding: EdgeInsets.symmetric(
        vertical: dynamicHeight(context, .02),
        horizontal: dynamicWidth(context, .03),
      ),
      labelText: label,
      labelStyle: TextStyle(
        color: myBlack,
        fontSize: dynamicWidth(context, .04),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: myBlack),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: myBlack),
      ),
    ),
  );
}
