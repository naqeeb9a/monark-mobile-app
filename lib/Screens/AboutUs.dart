import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monark_app/Screens/store_finder.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: myGrey,
        // appBar: bar2(context,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              bar2(context),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  dynamicWidth(context, .03),
                ),
                child: Image.asset(
                  "assets/aboutUs.jpg",
                  fit: BoxFit.cover,
                  width: dynamicWidth(context, 0.9),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: dynamicHeight(context, .04),
                  bottom: dynamicHeight(context, .04),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: dynamicWidth(context, .07),
                        color: myRed,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: dynamicWidth(context, .06),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        "MONARK - A smart casual fashion retail brand for men is an abstract of our rich fashion retailing experience for more than two decades. Our continuing journey of creating success stories in men's wear business with years of expertise in fashion retailing and foreseeing the demand of value added products in the targeted market convinced us to established the new apparel retail brand.The balancing act between the smart-casual divide is what can make us particular mode of attire and an uphill battle. Monark has emerged with trick to nailing smart or business casual to take its customer’s lead from the first word of this dress code. In terms of the finished products, we are ultimately leaning slightly to the smarter side of the spectrum, so tuck in that shirt, revamp your wardrobe and let’s begin this journey with us.",
                        style: TextStyle(
                          fontSize: dynamicWidth(context, .046),
                          color: myBlack,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .04),
                  horizontal: dynamicWidth(context, .06),
                ),
                child: Container(
                  width: dynamicWidth(context, 1),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "HERE TO HELP",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: dynamicWidth(context, .056),
                              color: myRed,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: dynamicHeight(context, .04),
                          bottom: dynamicHeight(context, .01),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: myRed,
                              size: dynamicWidth(context, .06),
                            ),
                            SizedBox(
                              width: dynamicWidth(context, .04),
                            ),
                            Flexible(
                              child: Text(
                                "81 Babar block, Garden Town Lahore,Pakistan.",
                                style: TextStyle(
                                  color: myBlack,
                                  fontSize: dynamicWidth(context, .04),
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch("mailto:customercare@monark.com.pk");
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dynamicHeight(context, .01),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.mail_rounded,
                                color: myRed,
                                size: dynamicWidth(context, .06),
                              ),
                              SizedBox(
                                width: dynamicWidth(context, .04),
                              ),
                              Text(
                                "customercare@monark.com.pk",
                                style: TextStyle(
                                  color: myBlack,
                                  fontSize: dynamicWidth(context, .04),
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch("tel:0423500451");
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: dynamicHeight(context, .01),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.call,
                                color: myRed,
                                size: dynamicWidth(context, .06),
                              ),
                              SizedBox(
                                width: dynamicWidth(context, .04),
                              ),
                              Text(
                                "042 3500451",
                                style: TextStyle(
                                  color: myBlack,
                                  fontSize: dynamicWidth(context, .04),
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: dynamicHeight(context, .02),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                print("object");
                                launch(
                                  "https://www.facebook.com/monark.com.pk",
                                  forceSafariVC: false,
                                  forceWebView: false,
                                );
                              },
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: myRed,
                                size: dynamicWidth(context, .07),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("object");
                                launch(
                                    "https://www.instagram.com/monarkpakistan/");
                              },
                              child: FaIcon(
                                FontAwesomeIcons.instagram,
                                color: myRed,
                                size: dynamicWidth(context, .07),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("object");
                                launch(
                                    "https://www.youtube.com/channel/UCo-RW5EuPY0iGOWWYJEkuFw");
                              },
                              child: FaIcon(
                                FontAwesomeIcons.youtube,
                                color: myRed,
                                size: dynamicWidth(context, .07),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: dynamicHeight(context, .02),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "Powered and Managed By CMC M-Tech Sol",
                      style: TextStyle(
                        fontSize: dynamicWidth(context, .03),
                        color: myBlack,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
