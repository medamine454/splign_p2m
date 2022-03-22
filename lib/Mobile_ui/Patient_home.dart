import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:splign_p2m/Backend/mqtt/state/MQTTAppState.dart';
import 'package:provider/provider.dart';
import '../Backend/mqtt/state/mqttviews.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Homepatient extends StatefulWidget {
  const Homepatient({Key? key}) : super(key: key);

  @override
  _HomepatientState createState() => _HomepatientState();
}

class _HomepatientState extends State<Homepatient> {
  int selectedDelay = 5;
  void changedelay(int type) {
    selectedDelay = type;
    setState(() {});
  }

  var buttonText = 'Start tracking my posture';
  int _counter = 10;
  Timer _timer =
      Timer(const Duration(seconds: 1), () => print('Timer finished'));

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  int x = 1;
  String anim = 'anim';
  int time_delay = 12;
  int time_goal = 60;
  Color progre_color = Color(0xff67bd42);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Tracking',
            style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xff67bd42),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Good morning Ahmed !',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Center(
              child: RichText(
            text: TextSpan(children: [
              WidgetSpan(child: Icon(Icons.timelapse_sharp, size: 21)),
              TextSpan(
                  text: '  37',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              TextSpan(
                text: '/$time_goal min',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 20,
                  color: Color(0xff67bd42),
                  fontWeight: FontWeight.w700,
                ),
              )
            ]),
          )),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/$anim.gif',
                  height: 200,
                ),
              ),
              Center(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12,
                  percent: 0.8,
                  progressColor: progre_color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        anim = 'anim';
                        progre_color = Color(0xff67bd42);
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.bullseye,
                      size: 30,
                      color: Color(0xff67bd42),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ToggleSwitch(
                    minWidth: 55.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Color(0xff67bd42)],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 1,
                    totalSwitches: 2,
                    labels: ['On', 'Off'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                  child: Text("Choose your delay response")),
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              actionsOverflowButtonSpacing: 20,
                              actions: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text("Cancel")),
                                ElevatedButton(
                                    onPressed: () {}, child: Text("Save")),
                              ],
                              content: Container(
                                height: 200,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        changedelay(5);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffdfdeff)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "5 sec",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffededed),
                                            ),
                                            child: (selectedDelay == 15)
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Colors.red,
                                                    size: 30,
                                                  )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        changedelay(30);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                              color: Color(0xffdfdeff),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "30 sec",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffededed),
                                            ),
                                            child: (selectedDelay == 30)
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Colors.red,
                                                    size: 30,
                                                  )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        changedelay(60);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                              color: Color(0xffdfdeff),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "1 min",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffededed),
                                            ),
                                            child: (selectedDelay == 60)
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Colors.red,
                                                    size: 30,
                                                  )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.stopwatch,
                      size: 30,
                      color: Color(0xff67bd42),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Goal',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Notifications',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Delay',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$time_goal min',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '                         ',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '15 sec ',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (_counter > 0)
                    ? Text("")
                    : Text(
                        "Congratulations !",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                Text(
                  '$_counter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                _submitButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        setState(() {
          buttonText = 'Cancel tracking';
        });
        _startTimer();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromARGB(255, 58, 53, 48).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Color(0xff67bd42)),
        child: Text(buttonText,
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}


//  home: ChangeNotifierProvider<MQTTAppState>(
        //  create: (_) => MQTTAppState(),
      //    child: MQTTView(),
     //   )
