import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      appBar: bar(
        context,
        bgColor: darkTheme == true ? darkThemeBlack : myWhite,
        menuIcon: true,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: dynamicWidth(context, .92),
            child: Column(
              children: [
                rowText("About Monark", context),
                SizedBox(
                  height: dynamicHeight(context, 0.04),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Monark - A smart casual fashion retail brand for men is an abstract of our rich "
                        "fashion retailing experience for more than two decades. Our continuing journey of "
                        "creating success stories in men's wear business with years of expertise in fashion "
                        "retailing and foreseeing the demand of value added products in the targeted market "
                        "convinced us to established the new apparel retail brand."
                        "\n\nThe balancing act between the smart-casual divide is what can make us particular "
                        "mode of attire and an uphill battle. Monark has emerged with trick to nailing smart or "
                        "business casual to take its customer’s lead from the first word of this dress code. "
                        "In terms of the finished products, we are ultimately leaning slightly to the smarter "
                        "side of the spectrum, so tuck in that shirt, revamp your wardrobe and let’s begin this "
                        "journey with us.",
                        style: TextStyle(
                          fontSize: dynamicWidth(context, 0.024),
                          color: darkTheme == true ? myWhite : myBlack,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
