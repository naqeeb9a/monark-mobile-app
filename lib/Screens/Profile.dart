import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/drawer_items.dart';
import 'package:monark_app/widgets/media_query.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: SafeArea(
        child: Center(
          child: Container(
            width: dynamicWidth(context, .9),
            height: dynamicHeight(context, .8),
            child: Column(
              children: [
                rowText("Profile", context),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      profilePicture(context),
                      profileText(context, "Email", "Yes@no.com"),
                      profileText(context, "Phone Number", "0000000"),
                      profileText(context, "Address", "CMC-MTech"),
                      profileText(context, "Postal Code", "i don't know"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget profileText(context, text1, text2) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: dynamicWidth(context, .046),
            color: myBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: dynamicHeight(context, .012),
        ),
        Text(
          text2,
          style: TextStyle(
            fontSize: dynamicWidth(context, .04),
            color: myBlack,
          ),
        ),
      ],
    ),
  );
}
