import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

import 'SeeAll.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List sliderImage = [
    'https://www.crushpixel.com/big-static20/preview4/modern-black-friday-sale-splash-3971985.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7igM_cOrelNFSjvci4DzT8HMo6xHbNnSjkTg8gkgD5_psi5hE0NVncBEAFLGn15uCaRk&usqp=CAU',
    'https://img.paisawapas.com/ovz3vew9pw/2021/07/20170241/04.jpg',
    'https://www.shopickr.com/wp-content/uploads/2016/06/landmark-shops-india-online-lifestyle-fashion-sale.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: bar(
        context,
        menuIcon: true,
        bgColor: darkTheme == true ? darkThemeBlack : myWhite,
        title: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
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
                    dynamicHeight(context, .33),
                    sliderImage.length,
                    .84,
                    sliderImage,
                    true,
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: dynamicWidth(context, .04),
                    ),
                    child: rowText(
                      "Best Sellers",
                      context,
                      check: false,
                    ),
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .7),
                    child: detailGrid(
                        getShopifyProductsBestSelling(), context, false,
                        expandedCheck: false),
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
