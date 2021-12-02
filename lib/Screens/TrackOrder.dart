import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class TrackOrder extends StatelessWidget {
  final String orderNumber;
  const TrackOrder({Key? key, required this.orderNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context,
          leadingIcon: true, menuIcon: true, bgColor: Colors.transparent),
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
                "order #MNK" + orderNumber,
                style: TextStyle(color: myWhite),
              ),
            ),
            heightBox(context, 0.05),
            radioRow(context, "1. Confirmed", true),
            radioRow(context, "2. Dispatched", true),
            radioRow(context, "3. Delivered", false),
            heightBox(context, 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Estimated Delivery Date"), Text("12-Dec-2021")],
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
          Text(text),
          Radio(
            value: true,
            groupValue: radioState,
            onChanged: (value) {},
            activeColor: Colors.green,
          )
        ],
      ),
      heightBox(context, 0.005),
      Divider()
    ],
  );
}
