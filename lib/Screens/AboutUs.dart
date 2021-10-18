import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Detailpage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: Theme(
        data: ThemeData.light(),
        child: WebView(
          initialUrl: 'https://monark.com.pk/pages/about-us',
        ),
      ),
    );
  }
}
