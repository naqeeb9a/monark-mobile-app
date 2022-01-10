import 'package:flutter/material.dart';
import 'package:monark_app/api/api.dart';
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
  dynamic apiData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiData = ApiData().getInfo("trackorder/${widget.orderNumber}");
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
            FutureBuilder(
              future: apiData,
              builder: (context, snapshot) {
                print("object = ${(snapshot.data as List)[0]}");
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      heightBox(context, 0.05),
                      radioRow(
                        context,
                        "1. Confirmed",
                        (snapshot.data as List)[0]["confirmed"],
                      ),
                      radioRow(
                        context,
                        "2. Dispatched",
                        (snapshot.data as List)[0]["dispached"],
                      ),
                      radioRow(
                        context,
                        "3. Delivered",
                        (snapshot.data as List)[0]["delivered"],
                      ),
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
                            (snapshot.data as List)[0]["delivery_date"]
                                .toString(),
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, .032),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.data == false) {
                  return Text(
                    "Something Went Wrong!!",
                    style: TextStyle(
                      color: darkTheme == true ? myWhite : myBlack,
                      fontSize: dynamicWidth(context, .028),
                    ),
                  );
                }
                return Center(
                  child: jumpingDots(context),
                );
              },
            ),
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
