import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';

dynamic errorDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Error",
          style: TextStyle(
            fontSize: 22.0,
            color: myRed,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: myBlack,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                color: stockGreen,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

dynamic successDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Success",
          style: TextStyle(
            fontSize: 22.0,
            color: stockGreen,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: myBlack,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                color: stockGreen,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

dynamic errorDialogOnly(BuildContext context, String text) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Error",
          style: TextStyle(
            fontSize: 22.0,
            color: myRed,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: myBlack,
          ),
        ),
      );
    },
  );
}

dynamic successDialogOnly(BuildContext context, String text) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Success",
          style: TextStyle(
            fontSize: 22.0,
            color: stockGreen,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: myBlack,
          ),
        ),
      );
    },
  );
}
