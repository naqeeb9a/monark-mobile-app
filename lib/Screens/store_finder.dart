import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:recase/recase.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/config.dart';

class StoreFinder extends StatefulWidget {
  const StoreFinder({Key? key}) : super(key: key);

  @override
  _StoreFinderState createState() => _StoreFinderState();
}

class _StoreFinderState extends State<StoreFinder> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List locationData = [
    {
      'name': "Amanah Mall, Lahore",
      'address': "2nd Floor, Amanah Mall, Model Town Link Road, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-35131653",
      'email': "customercare@monark.com.pk",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Fortress Square Mall, Lahore",
      'address': "Fortress Stadium, Mian Mir Bridge, Lahore, 54000",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-37341401",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "12:00 pm - 10:00 pm",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Gold Crest Mall, Lahore",
      'address': "Sector DD, Dha Phase 4, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-332171186",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Emporium Mall, Lahore",
      'address': "1st Floor, Emporium Mall, Johar Town, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-32592390",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "10:00 am - 10:00 pm",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "MM Alam, Lahore",
      'address': "Mall 96, M.M.Alam Road, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-32084751",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Packages Mall, Lahore",
      'address': "2nd Floor, Packages Mall, Walton Road, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-38915254",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "10:00 am - 10:00 pm",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Mall of Multan, Multan",
      'address': "Ground Floor, Mall of Multan",
      'state': "Punjab",
      'city': "Multan , 66000",
      'phone': "061-6521614",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "FRIDAY OFF",
    },
    {
      'name': "Satellite Town, Gujranwala",
      'address': "Satellite Town, Gujranwala",
      'state': "Punjab",
      'city': "Gujranwala , 52250",
      'phone': "055-2061732",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "FRIDAY OFF",
    },
    {
      'name': "Kings mall, Gujranwala",
      'address':
          "1st Floor, Kings Mall, GT Road By-Pass, Opposite to Wapda Town, Gujranwala",
      'state': "Punjab",
      'city': "Gujranwala , 52250",
      'phone': "055-4283088",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "FRIDAY OFF",
    },
    {
      'name': "Chenone Road, Faisalabad",
      'address': "Chenone Road, Faisalabad",
      'state': "Punjab",
      'city': "Faisalabad , 38000",
      'phone': "041-5225986",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "FRIDAY OFF",
    },
    {
      'name': "Giga Mall, Islamabad",
      'address': "Ground Floor, Giga Mall, WTC, DHA Phase 2 Islamabad",
      'state': "Islamabad Capital Territory",
      'city': "Islamabad , 45710",
      'phone': "051-2725550",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "10:00 am - 10:00 pm",
      'holiday': "THURSDAY OFF",
    },
    {
      'name': "V-mall, Sialkot",
      'address': "V-mall Sialkot",
      'state': "Punjab",
      'city': "Sialkot , 51310",
      'phone': "052-4291180",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 am - 10:00 pm",
      'holiday': "FRIDAY OFF",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      appBar: bar(
        context,
        menuIcon: true,
        bgColor: noColor,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawerScrimColor: darkTheme == true ? Colors.black54 : Colors.white54,
      endDrawer: drawer(context),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, .05),
            ),
            child: rowText("Store Locator", context),
          ),
          SizedBox(
            height: dynamicHeight(context, .04),
          ),
          Expanded(
            child: SizedBox(
              width: dynamicWidth(context, 1),
              child: ListView.builder(
                itemCount: locationData.length,
                itemBuilder: (context, i) {
                  return storeCard(
                    context,
                    locationData[i]["name"],
                    locationData[i]["address"],
                    locationData[i]["phone"],
                    locationData[i]["workTime"],
                    locationData[i]["holiday"],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget storeCard(context, name, address, phone, workTime, holiday) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .05),
      vertical: dynamicHeight(context, .024),
    ),
    child: Container(
      width: dynamicWidth(context, 1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: dynamicHeight(context, .01),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: "Aeonik",
                    fontWeight: FontWeight.w700,
                    fontSize: dynamicWidth(context, .04),
                    color: darkTheme == true ? myWhite : myBlack,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Address: ",
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: dynamicWidth(context, .026),
                  ),
                  maxLines: 1,
                ),
              ),
              FittedBox(
                child: Container(
                  width: dynamicWidth(context, .78),
                  child: Text(
                    address,
                    style: TextStyle(
                      color: darkTheme == true ? myWhite : myBlack,
                      fontSize: dynamicWidth(context, .026),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              launch("tel:$phone");
            },
            child: Row(
              children: [
                Text(
                  "Phone: ",
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: dynamicWidth(context, .026),
                  ),
                  maxLines: 1,
                ),
                Text(
                  phone,
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontSize: dynamicWidth(context, .026),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          heightBox(context, 0.015),
          Row(
            children: [
              Text(
                "Time: ",
                style: TextStyle(
                  color: darkTheme == true ? myWhite : myBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: dynamicWidth(context, .026),
                ),
                maxLines: 1,
              ),
              Text(
                workTime,
                style: TextStyle(
                  color: darkTheme == true ? myWhite : myBlack,
                  fontSize: dynamicWidth(context, .026),
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              holiday.toString().titleCase,
              style: TextStyle(
                color: darkTheme == true ? myWhite : myRed,
                fontSize: dynamicWidth(context, .024),
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
