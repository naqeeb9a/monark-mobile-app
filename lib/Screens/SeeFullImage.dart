import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';

class SeeFullImage extends StatelessWidget {
  final dynamic imageUrl;
  const SeeFullImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Center(
        child: Hero(
            tag: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: MediaQuery.of(context).size.height / 4,
                  placeholder: (context, string) {
                    return Image.asset(
                      "assets/loader.gif",
                      scale: 7,
                    );
                  }),
            )),
      ),
    );
  }
}
