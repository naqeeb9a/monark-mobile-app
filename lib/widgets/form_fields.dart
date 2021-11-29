import 'package:flutter/material.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

Widget inputTextField(context, label, myController,
    {function, function2, password = false}) {
  return Container(
    decoration: BoxDecoration(
      color: myWhite,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .4),
      ),
    ),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (function == "") ? () {} : function,
      controller: myController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      obscureText: password == true ? obscureText : false,
      cursorColor: myBlack,
      cursorWidth: 2.0,
      cursorHeight: dynamicHeight(context, .03),
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
          vertical: dynamicHeight(context, .012),
          horizontal: dynamicWidth(context, .05),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .4),
          ),
          borderSide: BorderSide(
            color: myRed,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .4),
          ),
          borderSide: BorderSide(
            color: myBlack,
          ),
        ),
      ),
    ),
  );
}

Widget searchbar(context, {enabled = true, controller, setStateFunction}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .014),
    ),
    decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(
          dynamicWidth(context, .08),
        ),
        border: Border.all(color: myBlack.withOpacity(.3), width: 1.4)),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            autofocus: enabled,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: dynamicWidth(context, .05),
              ),
              hintText: "Search Your Product",
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
            child: Icon(Icons.search_sharp),
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
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      keyboardType: type,
      cursorWidth: 2.0,
      cursorHeight: dynamicHeight(context, .032),
      decoration: InputDecoration(
        label: Text(
          text,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .02),
          horizontal: dynamicWidth(context, .03),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .026),
          ),
        ),
        hintText: hintText,
      ),
      validator: function == "" ? () {} : function,
      onSaved: (value) {
        localAddressList.add(value);
      },
    ),
  );
}
