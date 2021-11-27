import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: myWhite,
      appBar: bar(
        context,
        bgColor: myWhite,
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
                                    color: myBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: dynamicWidth(context, .04),
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
                                      color: myBlack,
                                      fontSize: dynamicWidth(context, .04),
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
                                      color: myBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: dynamicWidth(context, .04),
                                    ),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "customercare@monark.com.pk",
                                    style: TextStyle(
                                      color: myBlack,
                                      fontSize: dynamicWidth(context, .04),
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
                                Text(
                                  "Address: ",
                                  style: TextStyle(
                                    color: myBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: dynamicWidth(context, .04),
                                  ),
                                  maxLines: 1,
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: dynamicHeight(context, .06),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    launch(
                                      "https://monark.com.pk/",
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.globe,
                                    color: myRed,
                                    size: dynamicWidth(context, .07),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
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
                                    launch(
                                      "https://www.instagram.com/monarkpakistan/",
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: myRed,
                                    size: dynamicWidth(context, .07),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launch(
                                      "https://www.youtube.com/channel/UCo-RW5EuPY0iGOWWYJEkuFw",
                                      forceSafariVC: false,
                                      forceWebView: false,
                                    );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
