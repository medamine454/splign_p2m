import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splign_p2m/Signup_login/welcomePage.dart';
import 'package:flutter/material.dart';
import 'Signup_login/welcomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'channel name',
      channelName: 'channel name',
      importance: NotificationImportance.High,
      channelDescription: 'heyy',
      channelShowBadge: true,
<<<<<<< HEAD
      playSound: true,
      soundSource: 'android/app/src/main/res/raw/res_well_done.m4a'
=======
      //playSound: true,
>>>>>>> 79a7db9c9ca79591993f0c42258692d62bfc42a2
    )
    // soundSource: 'resource://raw/res_well_done'
  ]).then((_) => print('okey'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
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

        home: WelcomePage(),
        );

  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
