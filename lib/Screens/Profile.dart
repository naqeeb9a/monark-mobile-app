import 'package:flutter/material.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/Screens/Welcome.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            children: [
              rowText("Profile", context),
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                minRadius: 50,
                backgroundColor: Colors.red,
                backgroundImage: NetworkImage(
                    "https://cdn.allthings.how/wp-content/uploads/2020/11/allthings.how-how-to-change-your-picture-on-zoom-profile-picture-759x427.png?width=800"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Adam Balina',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 50,
              ),
             profileText("Email", "Yes@no.com"),
              SizedBox(
                height: 20,
              ),
              profileText("Phone Number", "0000000"),
              SizedBox(
                height: 20,
              ),
              profileText("Address", "CMC-MTech"),
              SizedBox(
                height: 20,
              ),
              profileText("Postal Code", "i don't know"),
              SizedBox(
                height: MediaQuery.of(context).size.height *0.15,
              ),
              coloredButton(context, "Logout",function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              },),
            ],
          ),
        ),
      ),
    );
  }
}
Widget profileText(text1,text2){

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text2,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );

}
