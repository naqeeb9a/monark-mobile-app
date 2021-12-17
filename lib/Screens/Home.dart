import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Categories.dart';
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
  bool sLoading = true;

  dynamic sliderImage = "";

  sliderImageApi() async {
    setState(() {
      sLoading = true;
    });
    sliderImage = await ApiData().getInfo("banners");

    setState(() {
      sLoading = false;
    });
  }

  getHomeData() async {
    setState(() {
      loading = true;
    });
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
      appBar: bar(context,
          menuIcon: true,
          bgColor: darkTheme == true ? darkThemeBlack : myWhite,
          title: true, function: () {
        _scaffoldKey.currentState!.openEndDrawer();
      }, refreshFucnction: () {
        setState(() {});
      }),
      drawerScrimColor: Colors.white54,
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
                sLoading == true
                    ? homeSlider(
                        context,
                        dynamicHeight(context, .35),
                        3,
                        1.0,
                        "loading",
                        true,
                      )
                    : (sliderImage == false)
                        ? InkWell(
                            onTap: () {
                              sliderImageApi();
                            },
                            child: homeSlider(
                              context,
                              dynamicHeight(context, .35),
                              3,
                              .84,
                              sliderImage,
                              true,
                            ),
                          )
                        : homeSlider(
                            context,
                            dynamicHeight(context, .35),
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
                              child: retryFunction(
                                context,
                                function: () {
                                  getHomeData();
                                },
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
