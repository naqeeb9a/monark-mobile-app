import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class TrackOrder extends StatefulWidget {
  final String orderNumber;

  const TrackOrder({Key? key, required this.orderNumber}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        bgColor: Colors.transparent,
        menuIcon: true,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rowText("Track Order", context),
            heightBox(context, 0.05),
            Container(
              decoration: BoxDecoration(
                color: myRed,
                borderRadius: BorderRadius.circular(
                  dynamicWidth(context, 0.1),
                ),
              ),
              padding: EdgeInsets.all(dynamicWidth(context, 0.03)),
              child: Text(
                "Order #MNK" + widget.orderNumber,
                style: TextStyle(
                  color: myWhite,
                  fontSize: dynamicWidth(context, .032),
                ),
              ),
            ),
            heightBox(context, 0.05),
            radioRow(context, "1. Confirmed", true),
            radioRow(context, "2. Dispatched", true),
            radioRow(context, "3. Delivered", false),
            heightBox(context, 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Estimated Delivery Date",
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontSize: dynamicWidth(context, .032),
                  ),
                ),
                Text(
                  "12-Dec-2021",
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontSize: dynamicWidth(context, .032),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget radioRow(context, text, radioState) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: darkTheme == true ? myWhite : myBlack,
              fontSize: dynamicWidth(context, .03),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: darkTheme == true ? myWhite : myBlack,
            ),
            child: Radio(
              value: true,
              groupValue: radioState,
              onChanged: (value) {},
              activeColor: stockGreen,
            ),
          )
        ],
      ),
      heightBox(context, 0.005),
      Divider(
        color: darkTheme == true ? myWhite : myBlack,
      ),
    ],
  );
}
