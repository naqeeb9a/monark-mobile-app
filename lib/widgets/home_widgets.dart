import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../config.dart';
import 'media_query.dart';

Widget categoryList(context) {
  return Container(
    height: dynamicHeight(context, .12),
    child: FutureBuilder(
      future: getShopifyCategory(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
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
                    snapshot.data[index]["title"],
                    snapshot.data[index]["id"],
                  ),
                );
              });
        } else {
          return Image.asset(
            "assets/loader.gif",
            scale: 7,
          );
        }
      },
    ),
  );
}

Widget categoryCards(context, cardText, id, {check = false}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeAll(
            text: cardText,
            function: getShopifyCollection(id),
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
            width: check == true ? null : dynamicWidth(context, .3),
            height: (check == true) ? null : dynamicHeight(context, .12),
            decoration: BoxDecoration(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .03),
          ),
          child: Container(
            color: Colors.transparent,
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
                fontSize: dynamicWidth(context, .04),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget cardList(context, {function, products}) {
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data != null) {
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
                child: (products == true)
                    ? basicCards(
                        context,
                        snapshot.data[index]["image"]["src"],
                        snapshot.data[index]["title"],
                        price: double.parse(
                                snapshot.data[index]["variants"][0]["price"])
                            .toInt()
                            .toString(),
                        sizeOption: snapshot.data[index]["options"][0]
                            ["values"],
                        description:
                            snapshot.data[index]["body_html"].toString(),
                      )
                    : basicCards(
                        context,
                        snapshot.data[index]["image"]["src"],
                        snapshot.data[index]["title"],
                        id: snapshot.data[index]["id"],
                        description:
                            snapshot.data[index]["body_html"].toString(),
                      ),
              );
            },
          ),
        );
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
    id = 0,
    description = "No Description"}) {
  return InkWell(
    onTap: () {
      if (price.contains("fetching")) {
        var snackBar = SnackBar(
          backgroundColor: myRed,
          content: Text("Price is still fetching ..."),
          duration: const Duration(milliseconds: 1000),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              image: imageUrl,
              price: price,
              text: text,
              array: sizeOption,
              description: description,
            ),
          ),
        );
      }
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
                imageUrl: imageUrl,
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
            child: (id != 0)
                ? FutureBuilder(
                    future: getPriceOfCollection(id),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        price = snapshot.data[0];
                        sizeOption = snapshot.data[1];
                        return Text(
                          "Rs. " + double.parse(price).toInt().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: dynamicWidth(context, .034),
                          ),
                        );
                      } else {
                        price = "fetching ...";
                        return JumpingDotsProgressIndicator(
                          fontSize: dynamicWidth(context, .034),
                        );
                      }
                    },
                  )
                : Text(
                    "Rs. " + price.toString(),
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
