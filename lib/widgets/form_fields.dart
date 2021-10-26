import 'package:flutter/material.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../config.dart';

Widget inputTextField(context, label, myController,
    {function, function2, password = false}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (function == "") ? () {} : function,
    controller: myController,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    obscureText: password == true ? obscureText : false,
    cursorColor: myBlack,
    cursorWidth: 2.0,
    cursorHeight: dynamicHeight(context, .034),
    decoration: InputDecoration(
      suffixIcon: password == false
          ? null
          : InkWell(
              onTap: function2 == "" ? () {} : function2,
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

Widget searchbar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: myGrey,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(2, 2))
        ]),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(Icons.search_sharp),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20),
                hintText: "Search Your Product"),
          ),
        )
      ],
    ),
  );
}
