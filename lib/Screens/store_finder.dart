import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../config.dart';

class StoreFinder extends StatefulWidget {
  const StoreFinder({Key? key}) : super(key: key);

  @override
  _StoreFinderState createState() => _StoreFinderState();
}

class _StoreFinderState extends State<StoreFinder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Container(
        width: dynamicWidth(context, 1),
        height: dynamicHeight(context, 1),
        color: Colors.yellow,
        child: Column(
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
                    "Store Locator",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: dynamicWidth(context, .07),
                      color: myRed,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
