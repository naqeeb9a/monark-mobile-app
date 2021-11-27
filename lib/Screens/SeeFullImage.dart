import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';

class SeeFullImage extends StatelessWidget {
  final dynamic imageUrl;
  const SeeFullImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Hero(
            tag: 1,
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                placeholder: (context, string) {
                  return Image.asset(
                    "assets/loader.gif",
                    scale: 7,
                  );
                }),
          ),
        ),
      ),
    );
  }
}
