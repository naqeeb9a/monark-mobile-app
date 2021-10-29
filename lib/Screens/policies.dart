import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../config.dart';

class Policies extends StatefulWidget {
  const Policies({Key? key}) : super(key: key);

  @override
  _PoliciesState createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .04),
              bottom: dynamicHeight(context, .04),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Policies",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: dynamicWidth(context, .07),
                    color: myBlack,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
