import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class SeeFullImage extends StatefulWidget {
  final dynamic image;

  const SeeFullImage({Key? key, this.image}) : super(key: key);

  @override
  State<SeeFullImage> createState() => _SeeFullImageState();
}

class _SeeFullImageState extends State<SeeFullImage> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: SafeArea(
        child: SizedBox(
          width: dynamicWidth(context, 1),
          height: dynamicHeight(context, 1),
          child: Stack(
            children: [
              homeSlider(
                context,
                dynamicHeight(context, 1),
                widget.image.length,
                1.0,
                widget.image,
                false,
                function: (value) {
                  setState(() {
                    currentPos = value;
                  });
                },
              ),
              SizedBox(
                width: dynamicWidth(context, 1),
                height: dynamicHeight(context, .06),
                child: bar(
                  context,
                  leadingIcon: true,
                  bgColor: noColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: dynamicHeight(context, .02),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: DotsIndicator(
                    decorator: DotsDecorator(
                      color: myWhite,
                      activeColor: myWhite,
                      size: const Size.square(5),
                      activeSize: const Size.square(10),
                    ),
                    dotsCount: widget.image.length,
                    position: currentPos.toDouble(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
