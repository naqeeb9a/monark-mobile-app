import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:url_launcher/url_launcher.dart';

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
        // color: Colors.yellow,
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
            storeCard(
              context,
              "name",
              "address",
              "state",
              "city",
              "phone",
              "email",
              "url",
              "workTime",
              "holiday",
            ),
          ],
        ),
      ),
    );
  }
}

Widget storeCard(
    context, name, address, state, city, phone, email, url, workTime, holiday) {
  return Container(
    width: dynamicWidth(context, .9),
    height: dynamicHeight(context, .44),
    decoration: BoxDecoration(
      color: myWhite,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .04),
      ),
      boxShadow: [
        BoxShadow(
          color: myBlack.withOpacity(0.2),
          spreadRadius: 4,
          blurRadius: 8,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    padding: EdgeInsets.all(
      dynamicWidth(context, .04),
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: dynamicHeight(context, .02),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: dynamicWidth(context, .06),
                  color: myBlack,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                "Address : $address",
                style: TextStyle(
                  fontSize: dynamicWidth(context, .04),
                  color: myBlack,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                "State : $state",
                style: TextStyle(
                  fontSize: dynamicWidth(context, .04),
                  color: myBlack,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                city,
                style: TextStyle(
                  fontSize: dynamicWidth(context, .04),
                  color: myBlack,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            launch(phone.toString());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .01),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "Phone : $phone",
                  style: TextStyle(
                    fontSize: dynamicWidth(context, .04),
                    color: myBlack,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        email == ""
            ? SizedBox(
                height: 0,
              )
            : InkWell(
                onTap: () {
                  launch("mailto:$email");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, .01),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "E-mail : $email",
                        style: TextStyle(
                          fontSize: dynamicWidth(context, .04),
                          color: myBlack,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
        InkWell(
          onTap: () {
            launch(url);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .01),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "URL : $url",
                  style: TextStyle(
                    fontSize: dynamicWidth(context, .04),
                    color: myBlack,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                "Work Time Today : $workTime",
                style: TextStyle(
                  fontSize: dynamicWidth(context, .04),
                  color: myBlack,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                holiday,
                style: TextStyle(
                  fontSize: dynamicWidth(context, .04),
                  color: myBlack,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
