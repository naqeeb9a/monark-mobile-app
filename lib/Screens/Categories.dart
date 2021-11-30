import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'SeeAll.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var isSelected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
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
                            isSelected.add(false);
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: dynamicWidth(context, 0.01)),
                              child: ChoiceChip(
                                label: Text(
                                  snapshot.data[index]["node"]["title"],
                                  style: TextStyle(
                                      color: isSelected[index] == true
                                          ? myWhite
                                          : myBlack),
                                ),
                                selected: isSelected[index],
                                selectedColor: myRed,
                                backgroundColor: myWhite,
                                side: BorderSide(
                                  color: myBlack.withOpacity(.3),
                                  width: .1,
                                ),
                                labelStyle: TextStyle(),
                                onSelected: (value) {
                                  if (isSelected[index] == true) {
                                    setState(() {
                                      isSelected[index] = false;
                                    });
                                  } else if (isSelected.contains(true)) {
                                    for (var i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = false;
                                    }
                                    setState(() {
                                      isSelected[index] = value;
                                    });
                                  } else {
                                    setState(() {
                                      isSelected[index] = value;
                                    });
                                  }
                                },
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
