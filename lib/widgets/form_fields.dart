import 'package:flutter/material.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

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
    cursorHeight: dynamicHeight(context, .03),
    style: TextStyle(
      color: myBlack,
      fontSize: dynamicWidth(context, .04),
    ),
    decoration: InputDecoration(
      suffixIcon: password == false
          ? null
          : InkWell(
              onTap: function2 == "" ? () {} : function2,
              child: Icon(
                Icons.remove_red_eye_rounded,
                color: myRed,
                size: dynamicWidth(context, .06),
              ),
            ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: dynamicWidth(context, .05),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
        borderSide: BorderSide(
          color: darkTheme == true ? myWhite : myBlack.withOpacity(.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
        borderSide: BorderSide(
          color: darkTheme == true ? myWhite : myBlack.withOpacity(.3),
        ),
      ),
    ),
  );
}

Widget searchbar(context, {enabled = true, controller, setStateFunction}) {
  return Container(
    height: dynamicHeight(context, .05),
    margin: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .014),
    ),
    decoration: BoxDecoration(
      color: noColor,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .08),
      ),
      border: Border.all(
        color: darkTheme == true ? myWhite : myBlack.withOpacity(.3),
        width: 1.4,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            autofocus: enabled,
            style: TextStyle(
              color: darkTheme == true ? myWhite : myBlack,
              fontSize: dynamicWidth(context, .04),
            ),
            cursorColor: darkTheme == true ? myWhite : myBlack,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Search Your Product",
              hintStyle: TextStyle(
                color: darkTheme == true ? myWhite : myBlack,
              ),
              contentPadding: EdgeInsets.only(
                bottom: dynamicHeight(context, .014),
                left: dynamicWidth(context, .05),
              ),
            ),
            onSubmitted: (value) {
              controller.text = value;
              setStateFunction();
            },
          ),
        ),
        InkWell(
          onTap: () {
            setStateFunction();
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: dynamicWidth(context, .02),
            ),
            child: Icon(
              Icons.search_sharp,
              color: darkTheme == true ? myWhite : myBlack,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget addressInput(context, text, hintText, type,
    {localAddressList, function}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: dynamicHeight(context, .01),
    ),
    child: SizedBox(
      height: dynamicHeight(context, .052),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        keyboardType: type,
        cursorWidth: 2.0,
        cursorHeight: dynamicHeight(context, .03),
        style: TextStyle(
          color: darkTheme == true ? myBlack : myWhite,
          fontSize: dynamicWidth(context, .04),
        ),
        decoration: InputDecoration(
          label: Text(
            text,
            style: TextStyle(
              color: darkTheme == true ? myWhite : myBlack,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
            horizontal: dynamicWidth(context, .03),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              dynamicWidth(context, .08),
            ),
          ),
          hintText: hintText,
        ),
        validator: function == "" ? () {} : function,
        onSaved: (value) {
          localAddressList.add(value);
        },
      ),
    ),
  );
}
