import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

import '../utils/config.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({Key? key}) : super(key: key);

  @override
  _PoliciesPageState createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: dynamicWidth(context, .04),
                ),
                child: rowText("Policies", context),
              ),
              heightBox(context, .02),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .04),
                  horizontal: dynamicWidth(context, .04),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "USE OF THIS APP",
                      style: TextStyle(
                        fontFamily: "Aeonik",
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: dynamicWidth(context, .044),
                      ),
                    ),
                    Text(
                      "\nAll billing and registration information provided must be truthful and accurate. Providing any untruthful or inaccurate information "
                      "constitutes a breach of these Terms. By confirming your purchase at the end of the checkout process, you agree to accept and pay for "
                      "the item(s) requested."
                      "\n\nYou may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service,"
                      " violate any laws in your jurisdiction (including but not limited to copyright laws)."
                      "\n\nWe reserve the right to refuse service to anyone for any reason at any time."
                      "\n\nYou understand that your content (not including credit card information), may be transferred unencrypted and involve (a) "
                      "transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. "
                      "Credit card information is always encrypted during transfer over networks."
                      "\n\nYou agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the "
                      "Service or any contact on the website through which the service is provided, without express written permission by us.\n",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: dynamicWidth(context, .032),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Text(
                        "PRODUCTS OR SERVICES",
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Text(
                      "Certain products or services may be available exclusively online through the website. These products or services "
                      "may have limited quantities and are subject to exchange only according to our Exchange Policy."
                      "\n\nWe have made every effort to display as accurately as possible the colors and images of our products that appear at the store. "
                      "We cannot guarantee that your computer monitor's display of any color will be accurate."
                      "\n\nWe reserve the right, but are not obligated, to limit the sales of our products or services to any person, geographic "
                      "region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of "
                      "any products or services that we offer. All descriptions of products or product pricing are subject to change at any time"
                      " without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for "
                      "any product or service made on this site is void where prohibited."
                      "\n\nWe do not warrant that the quality of any products, services, information, or other material purchased or obtained by you "
                      "will meet your expectations, or that any errors in the Service will be corrected.\n",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: dynamicWidth(context, .032),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Text(
                        "ACCURACY OF BILLING AND ACCOUNT INFORMATION",
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Text(
                      "We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities "
                      "purchased per person, per household or per order. These restrictions may include orders placed by or under the same "
                      "customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event "
                      "that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing "
                      "address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, "
                      "in our sole judgment, appear to be placed by dealers, resellers or distributors."
                      "\n\nYou agree to provide current, complete and accurate purchase and account information for all purchases made at our store. "
                      "You agree to promptly update your account and other information, including your email address and credit card numbers and "
                      "expiration dates, so that we can complete your transactions and contact you as needed."
                      "\n\nFor more detail, please review our Exchange Policy\n",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: dynamicWidth(context, .032),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Text(
                        "USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS",
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Text(
                      "If, at our request, you send certain specific submissions (for example contest entries) or without a request "
                      "from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, "
                      "by postal mail, or otherwise (collectively, 'comments'), you agree that we may, at any time, without restriction, "
                      "edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. "
                      "We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for "
                      "any comments; or (3) to respond to any comments."
                      "\n\nWe may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion "
                      "are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or "
                      "violates any party’s intellectual property or these Terms of Use."
                      "\n\nYou agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, "
                      "personality or other personal or proprietary right. You further agree that your comments will not contain libelous or "
                      "otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way "
                      "affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone "
                      "other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible "
                      "for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by "
                      "you or any third-party.\n",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: dynamicWidth(context, .032),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Text(
                        "CHANGES TO TERMS OF SERVICE",
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Text(
                      "You can review the most current version of the Terms of Use at any time at this page."
                      "\n\nWe reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Use "
                      "by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. "
                      "Your continued use of or access to our website or the Service following the posting of any changes to these Terms of "
                      "Use constitutes acceptance of those changes.\n",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: dynamicWidth(context, .032),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Text(
                        "What we collect",
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Text(
                      "We may collect the following information:",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: dynamicWidth(context, .032),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "Name",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "Contact information including email address",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "Demographic information such as postcode, preferences and interests",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "Other information relevant to customer surveys and/or offers",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Text(
                        "What we do with the information we gather",
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "Internal record keeping.",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "We may use the information to improve our products and services.",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "We may periodically send promotional emails about new products, special offers or other information which we think you "
                        "may find interesting using the email address which you have provided.",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: bulletText(
                        context,
                        "From time to time, we may also use your information to contact you for market research purposes. We may contact you by email, "
                        "phone, fax or mail. We may use the information to customise the website according to your interests.",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .02),
                      ),
                      child: Text(
                        "Security",
                        style: TextStyle(
                          fontFamily: "Aeonik",
                          color: darkTheme == true ? myWhite : myBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Text(
                      "We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure, we have "
                      "put in place suitable physical, electronic and managerial procedures to safeguard and secure the information we collect online.",
                      style: TextStyle(
                        color: darkTheme == true ? myWhite : myBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: dynamicWidth(context, .032),
                      ),
                      textAlign: TextAlign.justify,
                    )
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

Widget bulletText(context, text, {bold}) {
  return Container(
    width: dynamicWidth(context, 1),
    child: Text(
      "\• " + text,
      style: TextStyle(
        color: darkTheme == true ? myWhite : myBlack,
        fontWeight: bold == true ? FontWeight.bold : FontWeight.w400,
        fontSize: dynamicWidth(context, .032),
      ),
      maxLines: 5,
      textAlign: TextAlign.justify,
    ),
  );
}
