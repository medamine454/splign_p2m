import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:splign_p2m/Home/home.dart';
import 'package:splign_p2m/Signup_login/gender.dart';
import 'package:splign_p2m/Signup_login/signup.dart';
import 'package:splign_p2m/Signup_login/welcomePage.dart';
import 'package:splign_p2m/notif/notif.dart';
import 'package:splign_p2m/support/good_posture.dart';
import 'package:splign_p2m/support/support.dart';
import 'Mobile_ui/Patient_home.dart';
import 'Mobile_ui/Widgets/Personal_info_widget.dart';
import 'app/config/routes/app_pages.dart';
import 'app/config/themes/app_theme.dart';

import 'Backend/mqtt/state/MQTTAppState.dart';
import 'Backend/mqtt/state/mqttviews.dart';
import 'Mobile_ui/Patient_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile/profile_screen.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null,
      [NotificationChannel(channelKey: 'channel name', channelName: 'channel name',
        importance: NotificationImportance.High,
        channelDescription: 'heyy',
        channelShowBadge: true,
        playSound: true,
      )]).then((_) => print ('okey'));
  runApp(MyApp());
}
//Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //runApp(const MyApp());
//}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'Splign Posture',
      //themeMode: ThemeMode.dark,
      //theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
        theme :ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Home());



  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
