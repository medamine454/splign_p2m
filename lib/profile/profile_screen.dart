import 'package:flutter/material.dart';
import 'package:splign_p2m/app/shared_components/coustom_bottom_nav_bar.dart';
import 'package:splign_p2m/app/constans/enum.dart';

import '../Home/home.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff67bd42),
      ),
      body: Body(),

    );
  }
}