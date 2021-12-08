import 'package:flutter/material.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/api/api.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  dynamic futureHomeData = "";
  bool loading = true;

  List sliderImage = [];

  sliderImageApi() async {
    await ApiData().getInfo("banners").then(
      (value) {
        for (int i = 0; i < value.length; i++) {
          setState(() {
            sliderImage.add(value[i]["image_url"]);
          });
        }
      },
    );
  }

  // List sliderImage = [
  //   'https://www.crushpixel.com/big-static20/preview4/modern-black-friday-sale-splash-3971985.jpg',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7igM_cOrelNFSjvci4DzT8HMo6xHbNnSjkTg8gkgD5_psi5hE0NVncBEAFLGn15uCaRk&usqp=CAU',
  //   'https://img.paisawapas.com/ovz3vew9pw/2021/07/20170241/04.jpg',
  //   'https://www.shopickr.com/wp-content/uploads/2016/06/landmark-shops-india-online-lifestyle-fashion-sale.jpg',
  // ];

  getHomeData() async {
    futureHomeData = await getShopifyProductsBestSelling();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    sliderImageApi();
    getHomeData();
  }

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
      body: Container(
        height: dynamicHeight(context, 1),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                loading == true
                    ? SizedBox(
                        height: dynamicHeight(context, 0.4),
                        child: Image.asset(
                          "assets/loader.gif",
                          scale: 4,
                        ),
                      )
                    : (futureHomeData == "Server Error")
                        ? SizedBox(
                            height: dynamicHeight(context, 0.4),
                            child: Center(
                              child: SizedBox(
                                height: dynamicHeight(context, .25),
                                child: Image.asset("assets/network_error.png"),
                              ),
                            ),
                          )
                        : (futureHomeData.length == 0)
                            ? SizedBox(
                                height: dynamicHeight(context, 0.4),
                                child: Center(
                                  child: Text(
                                    "No Products Found",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .05),
                                    ),
                                  ),
                                ),
                              )
                            : customGrid(context, false, false, futureHomeData),
                SizedBox(
                  height: dynamicHeight(context, .02),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
