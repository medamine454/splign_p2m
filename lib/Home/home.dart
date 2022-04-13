import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splign_p2m/Backend/mqtt/state/mqttviews.dart';
import 'package:splign_p2m/profile/profile_screen.dart';

import '../Backend/mqtt/state/MQTTAppState.dart';
import '../support/support.dart';

class Home extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  int selectedPage = 0;
  final _pageOptions = [
    ChangeNotifierProvider<MQTTAppState>(
      create: (_) => MQTTAppState(),
      child: MQTTView(),
    ),
    ProfileScreen(),
    ProfileScreen(),
    Support(),
    ProfileScreen(),
  ];
  void onPageChanged(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        children: _pageOptions,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      /*_pageOptions[selectedPage],*/
      bottomNavigationBar: ConvexAppBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        activeColor: Color(0xff67bd42),
        //cornerRadius: 30,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.query_stats, title: 'Stats'),
          TabItem(icon: Icons.medical_services, title: 'My doctor'),
          TabItem(icon: Icons.help, title: 'Support'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: selectedPage, //optional, default as 0
        onTap: (int index) {
          setState(() {
            //selectedPage = index;
            pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
