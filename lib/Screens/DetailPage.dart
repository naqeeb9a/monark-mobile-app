import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String image;
  final String price;
  final String text;
  const DetailPage(
      {Key? key, required this.image, required this.price, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_sharp)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 3,
                      // width: MediaQuery.of(context).size.width / 1.2,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    price,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    thickness: 2,
                    endIndent: 50,
                    indent: 50,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select Size",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Select Color",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffeeeeee),
                        child: Text(
                          "S",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        child: Text(
                          "M",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xffeeeeee),
                        child: Text(
                          "L",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xffeeeeee),
                        child: Text(
                          "XXL",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: MaterialButton(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height / 14,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
