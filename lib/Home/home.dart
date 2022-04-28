import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splign_p2m/Backend/mqtt/state/mqttviews.dart';
import 'package:splign_p2m/support/support_stream.dart';
import '../Backend/mqtt/state/MQTTAppState.dart';
import '../Search_doctor/firestore_search.dart';
import '../profile/edit/build_stream_ptofil.dart';
import '../stats/Stream_builder.dart';
import '../stats/stats_page.dart';
import '../support/support.dart';
import 'package:splign_p2m/Backend//mqtt/state/mqtt_stream.dart';

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
      child: Profileg(),
    ),
    LineChartSample2(),
    SearchDoctor(),
    ProfilePgg(),
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
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
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
