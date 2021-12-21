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
    cursorWidth: 1.0,
    style: TextStyle(
      color: myBlack,
      fontSize: dynamicWidth(context, .04),
    ),
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: dynamicHeight(context, 0.01),
        horizontal: dynamicWidth(context, .05),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
        borderSide: BorderSide(
          color: darkTheme == true ? myWhite : myBlack.withOpacity(.1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
        borderSide: BorderSide(
          color: darkTheme == true ? myWhite : myBlack.withOpacity(.1),
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
        width: .2,
      ),
    ),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            setStateFunction();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: dynamicWidth(context, .04),
            ),
            child: Icon(
              Icons.search_sharp,
              size: dynamicWidth(context, .044),
              color: darkTheme == true ? myWhite : myBlack.withOpacity(.1),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: TextStyle(
              color: darkTheme == true ? myWhite : myBlack,
              fontSize: dynamicWidth(context, .03),
            ),
            cursorWidth: 1,
            cursorColor: darkTheme == true ? myWhite : myBlack,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Search Your Product",
              hintStyle: TextStyle(
                color: darkTheme == true ? myWhite : myBlack.withOpacity(.1),
              ),
              contentPadding: EdgeInsets.only(
                left: dynamicWidth(context, .014),
              ),
            ),
            onSubmitted: (value) {
              controller.text = value;
              setStateFunction();
            },
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
    child: Container(
      height: dynamicHeight(context, .052),
      decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .4),
        ),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        keyboardType: type,
        cursorWidth: 2.0,
        cursorHeight: dynamicHeight(context, .03),
        style: TextStyle(
          color: myBlack,
          fontSize: dynamicWidth(context, .04),
        ),
        decoration: InputDecoration(
          label: Text(
            text,
            style: TextStyle(
              color: myBlack,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
            horizontal: dynamicWidth(context, .03),
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
