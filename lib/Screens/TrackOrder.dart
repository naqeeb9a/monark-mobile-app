import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/api/api.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class TrackOrder extends StatefulWidget {
  final String orderNumber, fulfilmentStatus, trackingNumber;

  const TrackOrder({
    Key? key,
    required this.orderNumber,
    required this.fulfilmentStatus,
    required this.trackingNumber,
  }) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  dynamic apiData;

  @override
  void initState() {
    super.initState();
    apiData = ApiData().trackingOrder(widget.trackingNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        bgColor: noColor,
        menuIcon: true,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawerScrimColor: darkTheme == true ? Colors.black54 : Colors.white54,
      endDrawer: drawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dynamicWidth(context, .05),
        ),
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
              padding: EdgeInsets.all(
                dynamicWidth(context, 0.03),
              ),
              child: Text(
                "Order #MNK" + widget.orderNumber,
                style: TextStyle(
                  color: myWhite,
                  fontSize: dynamicWidth(context, .032),
                ),
              ),
            ),
            widget.fulfilmentStatus == "UNFULFILLED"
                ? Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: dynamicHeight(context, .24),
                        ),
                        child: Text(
                          "Tracking not Available!!",
                          style: TextStyle(
                            color: myWhite,
                            fontSize: dynamicWidth(context, .032),
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: apiData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == false) {
                            return Center(
                              child: retryFunction(context),
                            );
                          } else {
                            return Column(
                              children: [
                                heightBox(context, .04),
                                trackingRow(
                                  context,
                                  "1. Booking Date",
                                  (snapshot.data as List)[0]['tracking_Details']
                                          [0]['BookingDate']
                                      .toString()
                                      .split('-')
                                      .join('/'),
                                ),
                                trackingRow(
                                  context,
                                  "2. Status",
                                  (snapshot.data as List)[0]['tracking_Details']
                                          [0]['Details'][0]["Status"]
                                      .toString(),
                                ),
                                trackingRow(
                                  context,
                                  "3. Detail",
                                  (snapshot.data as List)[0]['tracking_Details']
                                          [0]['Details'][0]["Detail"]
                                      .toString(),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Center(
                            child: jumpingDots(context),
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget trackingRow(context, text, text2) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: dynamicHeight(context, .01)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: darkTheme == true ? myWhite : myBlack,
                fontSize: dynamicWidth(context, .03),
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                color: darkTheme == true ? myWhite : myBlack,
                fontSize: dynamicWidth(context, .03),
              ),
            ),
          ],
        ),
      ),
      // heightBox(context, 0.005),
      Divider(
        color: darkTheme == true ? myWhite : myBlack.withOpacity(.3),
      ),
    ],
  );
}
