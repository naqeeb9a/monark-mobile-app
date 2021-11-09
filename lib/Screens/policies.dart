import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../utils/config.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({Key? key}) : super(key: key);

  @override
  _PoliciesPageState createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: bar2(context),
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
                    "Policies",
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
              height: dynamicHeight(context, .06),
              child: AppBar(
                backgroundColor: noColor,
                elevation: 0.0,
                bottom: TabBar(
                  labelColor: myRed,
                  unselectedLabelColor: myBlack,
                  tabs: [
                    Tab(
                      text: "General Policy",
                    ),
                    Tab(
                      text: "Returns Policy",
                    ),
                  ],
                  indicator: DotIndicator(
                    color: myRed,
                    distanceFromCenter: dynamicHeight(context, .02),
                    radius: 4,
                    paintingStyle: PaintingStyle.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    color: myWhite,
                    child: Center(
                      child: Text(
                        'General',
                      ),
                    ),
                  ),
                  Container(
                    color: myWhite,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: dynamicHeight(context, .04),
                              horizontal: dynamicWidth(context, .04),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        "Returns & Exchanges Policy For An Online Purchase",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: dynamicWidth(context, .05),
                                          color: myBlack,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "We will gladly accept any unworn, unwashed merchandise with original tags that has been purchased from our online store. The article has to be sent back within 15 days of purchase for a refund or an exchange.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Please return goods with a copy of the invoice and mention the reason for returning the items.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Delivery Charges will not be refunded.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Incase of an Exchange, once products are received by our representative. A coupon code will be shared with the consignee of the amount that the product returned is being retailed at the time.",
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
          ],
        ),
      ),
    );
  }
}

Widget bulletText(context, text, {bold}) {
  return Container(
    width: dynamicWidth(context, 1),
    child: Text(
      "\• " + text,
      style: TextStyle(
        fontSize: dynamicWidth(context, .044),
        fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
      ),
      maxLines: 5,
      textAlign: TextAlign.justify,
    ),
  );
}
