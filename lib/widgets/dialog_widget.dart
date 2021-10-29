import 'package:flutter/material.dart';

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
            color: Colors.red,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                color: Colors.green,
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
            color: Colors.green,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                color: Colors.green,
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
            color: Colors.red,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
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
            color: Colors.green,
          ),
        ),
        elevation: 2.0,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      );
    },
  );
}
