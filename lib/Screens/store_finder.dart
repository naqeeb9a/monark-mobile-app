import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/config.dart';

class StoreFinder extends StatefulWidget {
  const StoreFinder({Key? key}) : super(key: key);

  @override
  _StoreFinderState createState() => _StoreFinderState();
}

class _StoreFinderState extends State<StoreFinder> {
  List locationData = [
    {
      'name': "Amanah Mall Lahore",
      'address': "Amanah Mall, Second Floor, Model Town Link Road, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-35131653",
      'email': "customercare@monark.com.pk",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 - 22:00",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Fortress Square Mall",
      'address': "Fortress Stadium، Mian Mir Bridge, Lahore, 54000",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-37341401",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "12:00 - 22:00",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Gold Crest Mall",
      'address': "Sector DD Dha Phase 4, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-332171186",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 - 22:00",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Emporium Mall",
      'address': "Emporium Mall, First Floor, Johar Town, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-32592390",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "10:00 - 22:00",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "MM Alam Outlet",
      'address': "Mall 96, M.M.Alam Road, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-32084751",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 - 22:00",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Packages Mall",
      'address': "Packages Mall, Second Floor, Walton Road, Lahore",
      'state': "Punjab",
      'city': "Lahore , 54000",
      'phone': "042-38915254",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "10:00 - 22:00",
      'holiday': "SUNDAY OFF",
    },
    {
      'name': "Mall of Multan",
      'address': "Mall of Multan, Ground Floor",
      'state': "Punjab",
      'city': "Multan , 66000",
      'phone': "061-6521614",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 - 22:00",
      'holiday': "FRIDAY OFF",
    },
    {
      'name': "Sattalite town Gujranwala",
      'address': "Sattalite Town , Gujranwala",
      'state': "Punjab",
      'city': "Gujranwala , 52250",
      'phone': "055-2061732",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 - 22:00",
      'holiday': "FRIDAY OFF",
    },
    {
      'name': "Kings mall",
      'address':
          "Kings Mall, First Floor, GT Road By-Pass , Opposite to WAPDA TOWN, Gujranwala",
      'state': "Punjab",
      'city': "Gujranwala , 52250",
      'phone': "055-4283088",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 - 22:00",
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
      'workTime': "11:00 - 22:00",
      'holiday': "FRIDAY OFF",
    },
    {
      'name': "Giga Mall Islamabad",
      'address': "Giga Mall, Ground Floor, WTC, DHA Phase 2 Islamabad",
      'state': "Islamabad Capital Territory",
      'city': "Islamabad , 45710",
      'phone': "051-2725550",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "10:00 - 22:00",
      'holiday': "THURSDAY OFF",
    },
    {
      'name': "V-mall Sialkot",
      'address': "V-mall Sialkot",
      'state': "Punjab",
      'city': "Sialkot , 51310",
      'phone': "052-4291180",
      'email': "",
      'url': "https://www.monark.com.pk",
      'workTime': "11:00 - 22:00",
      'holiday': "FRIDAY OFF",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context),
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
                  "Store Locator",
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
          SizedBox(
            width: dynamicWidth(context, 1),
            height: dynamicHeight(context, .74),
            child: ListView.builder(
              itemCount: locationData.length,
              itemBuilder: (context, i) {
                return storeCard(
                  context,
                  locationData[i]["name"],
                  locationData[i]["address"],
                  locationData[i]["state"],
                  locationData[i]["city"],
                  locationData[i]["phone"],
                  locationData[i]["email"].toString(),
                  locationData[i]["url"],
                  locationData[i]["workTime"],
                  locationData[i]["holiday"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget storeCard(
    context, name, address, state, city, phone, email, url, workTime, holiday) {
  return Container(
    width: dynamicWidth(context, .9),
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
    margin: EdgeInsets.all(
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
                  color: myRed,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(context, .01),
          ),
          child: SizedBox(
            width: dynamicWidth(context, 1),
            child: AutoSizeText(
              "Address : $address",
              style: TextStyle(
                fontSize: dynamicWidth(context, .04),
                color: myBlack,
              ),
              maxLines: 2,
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
            launch("tel:$phone");
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
                  launch(
                    "mailto:$email",
                    forceSafariVC: false,
                    forceWebView: false,
                  );
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
