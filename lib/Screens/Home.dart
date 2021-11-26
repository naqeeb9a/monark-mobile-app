import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  var accessToken;

  Home({Key? key, this.accessToken = ""}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _loading = false;

  List sliderImage = [
    'https://images.unsplash.com/photo-1577538928305-3807c3993047?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c2FsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://images.unsplash.com/photo-1607082350899-7e105aa886ae?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2FsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://media.istockphoto.com/photos/neon-flash-sale-banner-discount-product-advertising-marketing-banner-picture-id1204428300?k=20&m=1204428300&s=612x612&w=0&h=gmBsK52vSWsOR5qj_lXr9R43RAhP5k1WIn8igeua4BA=',
    'https://www.sanasafinaz.com/media/catalog/category/Sale-inner-Banner_1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    setState(() {
      _loading = true;
    });
  }

  checkLoginStatus() async {
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    if (saveUser.getString("loginInfo") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Welcome()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        widget.accessToken = saveUser.getString("loginInfo");
        globalAccessToken = widget.accessToken;

        _loading = false;
      });
    }
  }

  var customerInfo;

  @override
  Widget build(BuildContext context) {
    return (_loading == true)
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                numberOfDots: 5,
                fontSize: dynamicWidth(context, .08),
              ),
            ),
          )
        : Scaffold(
            appBar: bar(
              context,
              menuIcon: true,
              bgColor: myWhite,
              title: true,
            ),
            backgroundColor: myWhite,
            body: SafeArea(
              child: Center(
                child: Container(
                  width: dynamicWidth(context, 1),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: dynamicHeight(context, .01),
                        ),
                        homeSlider(
                          context,
                          dynamicHeight(context, .34),
                          sliderImage.length,
                          .84,
                          sliderImage,
                          true,
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .03),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dynamicWidth(context, .05),
                          ),
                          child: rowText(
                            "Best Sellers",
                            context,
                            check: true,
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        cardList(
                          context,
                          function: getShopifyCollection("suits"),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
