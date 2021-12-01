import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      appBar: bar(
        context,
        bgColor: noColor,
        menuIcon: true,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: dynamicWidth(context, .9),
              child: Column(
                children: [
                  rowText("Contact Us", context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .04),
                    ),
                    child: Container(
                      width: dynamicWidth(context, 1),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              launch("tel:0423500451");
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Phone: ",
                                  style: TextStyle(
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontWeight: FontWeight.w500,
                                    fontSize: dynamicWidth(context, .036),
                                  ),
                                  maxLines: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: Text(
                                    "042 3500451",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontWeight: FontWeight.w300,
                                      fontSize: dynamicWidth(context, .036),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              launch(
                                "mailto:customercare@monark.com.pk",
                                forceSafariVC: false,
                                forceWebView: false,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: dynamicHeight(context, .01),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Email: ",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: dynamicWidth(context, .036),
                                    ),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "customercare@monark.com.pk",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontWeight: FontWeight.w300,
                                      fontSize: dynamicWidth(context, .036),
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
                              children: [
                                Container(
                                  height: dynamicHeight(context, .06),
                                  child: Text(
                                    "Address: ",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: dynamicWidth(context, .036),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  width: dynamicWidth(context, .7),
                                  height: dynamicHeight(context, .06),
                                  child: Text(
                                    "81 Babar block, Garden Town Lahore,Pakistan.",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontWeight: FontWeight.w300,
                                      fontSize: dynamicWidth(context, .036),
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: dynamicHeight(context, .06),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    launch(
                                      "https://www.facebook.com/monark.com.pk",
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xff4267B2),
                                    radius: dynamicWidth(context, .04),
                                    child: Image.asset(
                                      "assets/icons/fbIcon.png",
                                      width: dynamicWidth(context, .032),
                                      color: myWhite,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: dynamicWidth(context, .08),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      launch(
                                        "https://www.instagram.com/monarkpakistan/",
                                        forceSafariVC: false,
                                        forceWebView: false,
                                      );
                                    },
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/icons/instaIcon.png",
                                        width: dynamicWidth(context, .086),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launch(
                                      "https://monark.com.pk/",
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: myRed,
                                    radius: dynamicWidth(context, .04),
                                    child: Image.asset(
                                      "assets/icons/webIcon.png",
                                      width: dynamicWidth(context, .056),
                                      color: myWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
