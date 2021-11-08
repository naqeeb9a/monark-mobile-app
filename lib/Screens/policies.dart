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
                                Text(r"""
• We will gladly accept any unworn, unwashed merchandise with original tags that has been purchased from our online store. The article has to be sent back within 15 days of purchase for a refund or an exchange.

• Please return goods with a copy of the invoice and mention the reason for returning the items.

• Customer needs to return the merchandise via traceable delivery i.e. courier or registered post on his own expense to our address. 

• Delivery Charges will not be refunded.

• Incase of an Exchange, once products are received by our representative. A coupon code will be shared with the consignee of the amount that the product returned is being retailed at the time.

The coupon code could be used to order the required article in exchange. Please Note the coupon code can only be redeemed at the website.  

• Refund requests will be processed within 7 working days after receiving the return products.

• Refunds will be made via Jazz cash, online banking or in the form of a coupon code.

• All returns should be sent to 81 Babar block, Garden town Lahore.

• If the article was purchased from our most recent collection it can be exchanged from any of our outlet as well. Make sure the tags are attached to the article and the invoice is presented at the time of exchange.

• Incase the article has been further discounted from the time of purchase. The exchange will be made at mark down pricing.

• Articles purchased via “Buy 2 Get 1 Free” promo cannot be refunded, however an exchange could only be requested of paid articles from the online department.  Furthermore the article must be unused and the request should be made within 15 days of purchase.

For further assistance about exchanges and returns, please contact us at customercare@monark.com.pk.

Follow these simple steps to return or exchange your item purchased from the online store:

1. Complete Return Form

If you wish to return or exchange any portion of your online order, please complete the Exchange Form and include it with your return shipment.

Don't have a Return Form?"""),
                                Text("Please click here to download one."),
                                Text(r"""
If you wish to return or exchange any product of your order, please complete this form and include it with your return shipment.

1. Repack Merchandise
Please make sure that the item(s) you wish to return, along with the Return Form are included with your return shipment.

2. Ship to
Customer needs to return the merchandise via traceable delivery i.e. courier or registered post on his own expense to the following address:

Consumer Returns Department

81 Babar block, Garden town Lahore.

Pakistan

Telephone Support : 042 32500451  ( 10:00 AM to 7:00 PM  Monday - Saturday )

 

Returns & Exchanges Policy for a Store Purchased Item

An exchange could be requested of any unworn, unwashed merchandise with original tags within 15 days of purchase.
The invoice or proof of purchase in form of a text message (incase the payment was made via credit/debit card) has to be presented at the time of exchange.
An article purchased from the outlet cannot be returned
Altered article cannot be exchanged or returned.
Accessories cannot be exchanged after purchase from the outlet due to hygienic reasons.
                                """)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: dynamicHeight(context, .04),
                              horizontal: dynamicWidth(context, .04),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    "Returns & Exchanges Policy For An Online Purchase",
                                    style: TextStyle(
                                      fontSize: dynamicWidth(context, .05),
                                      color: myBlack,
                                    ),
                                    textAlign: TextAlign.justify,
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

Widget bulletText(context, text, bold) {
  return Expanded(
    child: Column(
      children: [
        Text(
          "\• " + text,
          style: TextStyle(
            fontSize: dynamicWidth(context, .044),
            fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
