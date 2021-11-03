import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';
import 'media_query.dart';

ValueNotifier<bool> isDialOpen = ValueNotifier(false);

Widget categoryList(context) {
  return Container(
    height: dynamicHeight(context, .12),
    child: FutureBuilder(
      future: getShopifyCategory(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data == "Server Error") {
            return SizedBox(
              height: dynamicHeight(context, .2),
              child: Image.asset("assets/network_error.png"),
            );
          } else {
            return ListView.builder(
              itemCount: (snapshot.data as List).length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: dynamicWidth(context, .02),
                  ),
                  child: categoryCards(
                    context,
                    snapshot.data[index]["node"]["title"],
                    snapshot.data[index]["node"]["handle"],
                    snapshot.data[index]["node"]["image"]["src"],
                  ),
                );
              },
            );
          }
        } else {
          return Image.asset(
            "assets/loader.gif",
            scale: 6,
          );
        }
      },
    ),
  );
}

Widget categoryCards(context, cardText, handle, image, {check = false}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeAll(
            text: cardText,
            function: getShopifyCollection(handle),
            check: false,
          ),
        ),
      );
    },
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .03),
          ),
          child: Container(
            width: check == true
                ? dynamicWidth(context, 1)
                : dynamicWidth(context, .3),
            height: (check == true) ? null : dynamicHeight(context, .12),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (context, string) {
                return Image.asset(
                  "assets/loader.gif",
                  scale: 8,
                );
              },
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .03),
          ),
          child: Container(
            color: myBlack.withOpacity(.4),
            padding: EdgeInsets.all(
              dynamicWidth(context, .02),
            ),
            width: check == true ? null : dynamicWidth(context, .3),
            height: (check == true) ? null : dynamicHeight(context, .12),
            alignment: Alignment.center,
            child: AutoSizeText(
              cardText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: myWhite,
                fontSize: dynamicWidth(context, .046),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget cardList(context, {function}) {
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data != null) {
        if (snapshot.data == "Server Error") {
          return SizedBox(
            height: dynamicHeight(context, .25),
            child: Image.asset("assets/network_error.png"),
          );
        } else {
          return SizedBox(
            height: dynamicHeight(context, .35),
            child: ListView.builder(
              itemCount: (snapshot.data as List).length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: dynamicWidth(context, 0.018),
                  ),
                  child: basicCards(
                    context,
                    snapshot.data[index]["node"]["images"]["edges"],
                    snapshot.data[index]["node"]["title"],
                    price: snapshot.data[index]["node"]["variants"]["edges"],
                    sizeOption: snapshot.data[index]["node"]["options"][0]
                        ["values"],
                    description: snapshot.data[index]["node"]["description"],
                    sku: snapshot.data[index]["node"]["variants"]["edges"],
                  ),
                );
              },
            ),
          );
        }
      } else {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          child: Image.asset(
            "assets/loader.gif",
            scale: 6,
          ),
        );
      }
    },
  );
}

Widget basicCards(context, imageUrl, text,
    {price = "fetching ...",
    sizeOption = "",
    description = "No Description",
    sku = ""}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            image: imageUrl,
            price: price,
            text: text,
            array: sizeOption,
            description: description,
            sku: sku,
          ),
        ),
      );
    },
    child: Container(
      width: dynamicWidth(context, .3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              dynamicWidth(context, .03),
            ),
            child: Container(
              height: dynamicHeight(context, .26),
              width: dynamicWidth(context, .5),
              color: myWhite,
              child: CachedNetworkImage(
                imageUrl: imageUrl[0]["node"]["src"],
                fit: BoxFit.cover,
                placeholder: (context, string) {
                  return Image.asset(
                    "assets/loader.gif",
                    scale: 6,
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                fontSize: dynamicWidth(context, .03),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Rs. " +
                  double.parse(price[0]["node"]["price"]).toInt().toString(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: dynamicWidth(context, .034),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget floatingButton(context) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    openCloseDial: isDialOpen,
    backgroundColor: myRed,
    overlayColor: myGrey,
    overlayOpacity: 0.5,
    spacing: dynamicHeight(context, .01),
    spaceBetweenChildren: dynamicHeight(context, .01),
    closeManually: true,
    children: [
      SpeedDialChild(
        onTap: () {
          launch(
              "whatsapp://send?phone=+923036663017&text=https://monark.com.pk/ I'm interested in this product and I have a few questions. Can you help?");
        },
        elevation: 2.0,
        child: CircleAvatar(
          backgroundColor: myWhite,
          radius: dynamicWidth(context, .1),
          backgroundImage: AssetImage(
            "assets/whatsapp.png",
          ),
        ),
      ),
      SpeedDialChild(
        onTap: () {
          launch("https://web.facebook.com/v3.3/plugins/customer_chat/bubble");
        },
        elevation: 2.0,
        child: CircleAvatar(
          backgroundColor: myWhite,
          radius: dynamicWidth(context, .1),
          backgroundImage: AssetImage(
            "assets/messenger.png",
          ),
        ),
      ),
    ],
  );
}

Widget rowText(text, context,
    {function, text2 = "", bool check = false, bool categoryCheck = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: dynamicWidth(context, .066),
          fontWeight: FontWeight.w600,
        ),
      ),
      check == true
          ? InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAll(
                      check: categoryCheck,
                      text: text,
                      function: function,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .01),
                  horizontal: dynamicWidth(context, .02),
                ),
                child: Text(
                  text2,
                ),
              ),
            )
          : Container()
    ],
  );
}

dynamic imageAlert(context, image, assetImage) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            dynamicWidth(
              context,
              dynamicWidth(context, .03),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .03),
          ),
          child: Stack(
            children: [
              Hero(
                tag: 1,
                child: InteractiveViewer(
                  child: assetImage == false
                      ? CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.fitWidth,
                          width: dynamicWidth(context, .96),
                          height: dynamicHeight(context, .8),
                          placeholder: (context, string) {
                            return Image.asset(
                              "assets/loader.gif",
                              scale: 4,
                            );
                          },
                        )
                      : Image.asset(
                          image,
                          width: dynamicWidth(context, .96),
                          fit: BoxFit.fitHeight,
                        ),
                ),
              ),
              Container(
                width: dynamicWidth(context, 1),
                height: dynamicHeight(context, .05),
                color: noColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: dynamicWidth(context, .02),
                      ),
                      child: ColoredBox(
                        color: myWhite,
                        child: Icon(
                          Icons.clear,
                          color: myRed,
                          size: dynamicWidth(context, .08),
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
    },
  );
}
