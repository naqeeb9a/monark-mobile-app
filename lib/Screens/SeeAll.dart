import 'package:flutter/material.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/Home.dart';

class SeeAll extends StatelessWidget {
  final String text;
  SeeAll({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context, check: true),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            rowText(text, context),
            SizedBox(
              height: 20,
            ),
            detailGrid(featuredArray)
          ],
        ),
      ),
    );
  }
}

Widget detailGrid(image) {
  return Expanded(
    child: Container(
      child: GridView.builder(
          itemCount: image.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 5 / 6.5,
          ),
          itemBuilder: (context, index) {
            return basicCards(context, image[index]["imageUrl"],
                image[index]["price"], image[index]["title"]);
          }),
    ),
  );
}
