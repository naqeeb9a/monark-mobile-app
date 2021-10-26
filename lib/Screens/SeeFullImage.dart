import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';

class SeeFullImage extends StatelessWidget {
  final dynamic imageUrl;

  const SeeFullImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .03),
          ),
          child: Hero(
            tag: 1,
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: dynamicWidth(context, .9),
                height: dynamicHeight(context, .8),
                placeholder: (context, string) {
                  return Image.asset(
                    "assets/loader.gif",
                    scale: 4,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
