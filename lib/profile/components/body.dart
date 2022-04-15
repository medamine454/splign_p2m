import 'package:flutter/material.dart';
import 'package:splign_p2m/profile/components/Logout.dart';
import 'package:splign_p2m/profile/edit/build_stream_foredit.dart';


import '../edit/build_stream_foredit.dart';

import 'Settings.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';


class Body extends StatefulWidget {
  Body(

      {Key ?key,
        required this.age,
        required this.emailadress,
        required this.weight,
        required this.height,
        required this.fullName,})

      : super(key: key);
  String age;
  String weight;
  String height;
  String emailadress;
  String fullName;


  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff67bd42),
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),

      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          Center(

            child: Text(
              widget.fullName,
              style: TextStyle(
                fontFamily: 'Arial',
                color: Color.fromRGBO(26, 31, 56, 1),
                backgroundColor: Color(0xFFF5F6F9),
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
            SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => EditProfilePgg()),

            )
            },
          ),

          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
            },
          ),

          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogOut()),
            );},
          ),
        ],
      ),
    )
    );
  }
}