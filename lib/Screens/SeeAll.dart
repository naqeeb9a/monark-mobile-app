import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Home.dart';

class SeeAll extends StatelessWidget {
  final bool check;
  final String text;
  final dynamic array;
  SeeAll({Key? key, required this.text, this.array, required this.check})
      : super(key: key);

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
              detailGrid(array, context, check)
            ],
          ),
        ));
  }
}

Widget detailGrid(array, context, check) {
  return Expanded(
    child: GridView.builder(
        itemCount: array.length,
        gridDelegate: (check == true)
            ? SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: 2 / 1.5,
              )
            : SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 5 / 6.5,
              ),
        itemBuilder: (context, index) {
          return (check == true)
              ? categoryCards(
                  context, array[index]["title"], array[index]["imageUrl"])
              : basicCards(context, array[index]["imageUrl"],
                  array[index]["price"], array[index]["title"]);
        }),
  );
}
