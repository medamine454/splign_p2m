import 'package:flutter/material.dart';
import 'package:splign_p2m/profile/components/Logout.dart';
import 'package:splign_p2m/profile/components/myaccount.dart';

import 'Settings.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  static const name="Mohsen weld mohsna";
  static const phone = "90441530"; // not real number :)
  static const location = "Ariana,Tunisia";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),

      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          Center(

            child: Text(
              name,
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
            MaterialPageRoute(builder: (context) => MyAccount()),
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
    );
  }
}