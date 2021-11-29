import 'package:flutter/material.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/drawer_items.dart';
import 'package:monark_app/widgets/media_query.dart';

class Profile extends StatelessWidget {
  final Future<String> accessToken;

  Profile({Key? key, required this.accessToken}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context, bgColor: Colors.transparent, menuIcon: true),
      body: SafeArea(
        child: Center(
          child: Container(
            width: dynamicWidth(context, .9),
            height: dynamicHeight(context, .8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                profilePicture(
                  context,
                ),
                profileText(context, "Sara Tahir"),
                profileText(context, "My Wishlist"),
                profileText(context, "My Bag"),
                profileText(context, "Order History"),
                profileText(context, "Track Order"),
                SizedBox(
                  height: dynamicHeight(context, 0.03),
                ),
                coloredButton(context, "logout"),
                SizedBox(
                  height: dynamicHeight(context, 0.03),
                ),
                // profileText(
                //   context,
                //   "Email",
                //   'customerInfo["email"]',
                // ),
                // profileText(context, "Phone Number", ""
                //     // customerInfo["phone"] == null
                //     //     ? "Not Provided"
                //     //     : customerInfo["phone"].toString(),
                //     ),
                // profileText(
                //   context,
                //   "Address",
                //   'customerInfo["defaultAddress"]["address1"]',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget profileText(context, text1) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text1),
      SizedBox(
        height: dynamicHeight(context, 0.01),
      ),
      Divider()
    ],
  );
}
// Widget profileText(context, text1, text2) {
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           text1,
//           style: TextStyle(
//             fontSize: dynamicWidth(context, .046),
//             color: myBlack,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(
//           height: dynamicHeight(context, .012),
//         ),
//         Text(
//           text2,
//           style: TextStyle(
//             fontSize: dynamicWidth(context, .04),
//             color: myBlack,
//           ),
//         ),
//       ],
//     ),
//   );
// }
