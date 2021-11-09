
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("USE OF THIS APP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(r"""
All billing and registration information provided must be truthful and accurate. Providing any untruthful or inaccurate information constitutes a breach of these Terms. By confirming your purchase at the end of the checkout process, you agree to accept and pay for the item(s) requested.

You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).

We reserve the right to refuse service to anyone for any reason at any time.

You understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.

You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us.
                          """),
                          Text("PRODUCTS OR SERVICES",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(
                            r'''
Certain products or services may be available exclusively online through the website. These products or services may have limited quantities and are subject to exchange only according to our Exchange Policy.

We have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor's display of any color will be accurate.

We reserve the right, but are not obligated, to limit the sales of our products or services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at any time without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited.

We do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.
                            '''
                          ),
                          Text("ACCURACY OF BILLING AND ACCOUNT INFORMATION",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(r'''
We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.

You agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.

For more detail, please review our Exchange Policy
                          '''),
                          Text("USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(
                            r'''
If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, 'comments'), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments.

We may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms of Use.

You agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.
                            '''
                          ),
                          Text("CHANGES TO TERMS OF SERVICE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(
                            r'''
You can review the most current version of the Terms of Use at any time at this page.

We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Use by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. Your continued use of or access to our website or the Service following the posting of any changes to these Terms of Use constitutes acceptance of those changes.

                            '''
                          ),
                          Text("What we collect",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          Text("We may collect the following information:"),
                          bulletText(context, "Name"),
                          bulletText(context, "Contact information including email address"),
                          bulletText(context, "Demographic information such as postcode, preferences and interests"),
                          bulletText(context, "Other information relevant to customer surveys and/or offers"),
                          Text("What we do with the information we gather",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          bulletText(context, "Internal record keeping."),
                          bulletText(context, "We may use the information to improve our products and services."),
                          bulletText(context, "We may periodically send promotional emails about new products, special offers or other information which we think you may find interesting using the email address which you have provided."),
                          bulletText(context, "From time to time, we may also use your information to contact you for market research purposes. We may contact you by email, phone, fax or mail. We may use the information to customise the website according to your interests."),
                          Text("Security",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(r'''
We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure, we have put in place suitable physical, electronic and managerial procedures to safeguard and secure the information we collect online.

                          ''')
                        ],
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
                                    "Customer needs to return the merchandise via traceable delivery i.e. courier or registered post on his own expense to our address.",
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
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: Text(
                                      "The coupon code could be used to order the required article in exchange. Please Note the coupon code can only be redeemed at the website."),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Refund requests will be processed within 7 working days after receiving the return products.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Refunds will be made via Jazz cash, online banking or in the form of a coupon code.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "All returns should be sent to 81 Babar block, Garden town Lahore.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "If the article was purchased from our most recent collection it can be exchanged from any of our outlet as well. Make sure the tags are attached to the article and the invoice is presented at the time of exchange.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Incase the article has been further discounted from the time of purchase. The exchange will be made at mark down pricing.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Articles purchased via “Buy 2 Get 1 Free” promo cannot be refunded, however an exchange could only be requested of paid articles from the online department.  Furthermore the article must be unused and the request should be made within 15 days of purchase.",
                                    bold: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: Text(
                                      "For further assistance about exchanges and returns, please contact us at customercare@monark.com.pk."),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: Text(
                                    "Follow these simple steps to return or exchange your item purchased from the online store:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text("Complete Return Form"),
                                Text("If you wish to return or exchange any portion of your online order, please complete the Exchange Form and include it with your return shipment."),
                                Text("Don't have a Return Form?"),
                                InkWell(
                                  child: Text(
                                    "Please click here to download one.",
                                  ),
                                  onTap: () {
                                    //for downloading the form
                                  },
                                ),
                                Text(
                                    "If you wish to return or exchange any product of your order, please complete this form and include it with your return shipment."),
                                Text("1. Repack Merchandise"),
                                Text(
                                    "Please make sure that the item(s) you wish to return, along with the Return Form are included with your return shipment."),
                                Text("2. Ship to"),
                                Text(
                                    "Customer needs to return the merchandise via traceable delivery i.e. courier or registered post on his own expense to the following address:"),
                                Text("Consumer Returns Department"),
                                Text("81 Babar block, Garden town Lahore."),
                                Text("Pakistan"),
                                Text(
                                    "Telephone Support : 042 32500451  ( 10:00 AM to 7:00 PM  Monday - Saturday )"),
                                Text(
                                    "Returns & Exchanges Policy for a Store Purchased Item"),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "An exchange could be requested of any unworn, unwashed merchandise with original tags within 15 days of purchase.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "The invoice or proof of purchase in form of a text message (incase the payment was made via credit/debit card) has to be presented at the time of exchange.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "An article purchased from the outlet cannot be returned",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Altered article cannot be exchanged or returned.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: dynamicHeight(context, .01),
                                  ),
                                  child: bulletText(
                                    context,
                                    "Accessories cannot be exchanged after purchase from the outlet due to hygienic reasons.",
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
