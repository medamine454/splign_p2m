
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:splign_p2m/notif/notification.dart';

import '../app/constans/enum.dart';


import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notif extends StatefulWidget {
  static String routeName = "/profile";

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  void initState(){
     super.initState();
     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
       if (!isAllowed) {
         showDialog(
           context: context,
           builder: (context) =>
               AlertDialog(
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
                     onPressed: () =>
                         AwesomeNotifications()
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
     }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
     


}