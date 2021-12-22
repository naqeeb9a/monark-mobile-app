import 'package:flutter/material.dart';
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

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    globalContextHome = context;
    super.build(context);
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
        refreshFucnction: () {
          setState(() {});
        },
      ),
      resizeToAvoidBottomInset: false,
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      body: Container(
        height: dynamicHeight(context, 1),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .01),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: sLoading == true
                  ? homeSlider(
                      context,
                      dynamicHeight(context, .9),
                      3,
                      1.0,
                      "loading",
                      true,
                    )
                  : sliderImage == false
                      ? InkWell(
                          onTap: () {
                            sliderImageApi();
                          },
                          child: homeSlider(
                            context,
                            dynamicHeight(context, .8),
                            3,
                            .96,
                            sliderImage,
                            true,
                          ),
                        )
                      : homeSlider(
                          context,
                          dynamicHeight(context, .8),
                          sliderImage.length,
                          .96,
                          sliderImage,
                          true,
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
