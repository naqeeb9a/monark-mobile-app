import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'SeeAll.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context, menuIcon: true, bgColor: Colors.transparent),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: dynamicWidth(context, 0.02),
                  vertical: dynamicHeight(context, 0.01)),
              child: searchbar(context, enabled: false),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: dynamicWidth(context, 0.04),
                  vertical: dynamicHeight(context, 0.01)),
              child: rowText("Categories", context, check: true),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: dynamicWidth(context, 0.02),
                  vertical: dynamicHeight(context, 0.01)),
              child: FutureBuilder(
                  future: getShopifyCategory(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        height: dynamicHeight(context, 0.05),
                        width: dynamicWidth(context, 1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: dynamicWidth(context, 0.02)),
                              padding:
                                  EdgeInsets.all(dynamicWidth(context, 0.02)),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: Text(
                                  snapshot.data[index]["node"]["title"],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                          child: JumpingDotsProgressIndicator(
                        numberOfDots: 3,
                        fontSize: dynamicWidth(context, 0.07),
                      ));
                    }
                  }),
            ),
            SizedBox(
              height: dynamicHeight(context, 0.01),
            ),
            detailGrid(getShopifyCategory(), context, true)
          ],
        ),
      ),
    );
  }
}
