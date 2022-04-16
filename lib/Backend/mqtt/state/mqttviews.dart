import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:splign_p2m/Backend/mqtt/MQTTManager.dart';
import 'package:splign_p2m/Backend/mqtt/state/MQTTAppState.dart';
import 'package:splign_p2m/notif/notif.dart';
import 'package:splign_p2m/notif/notification.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:audioplayers/audioplayers.dart';


class MQTTView extends StatefulWidget {
  MQTTView(
      {Key ?key,
        required this.age,
        required this.emailadress,
        required this.weight,
        required this.height,
        required this.fullName,})

      : super(key: key);
  String age= '18';
  String weight;
  String height;
  String emailadress;
  String fullName;
  @override
  State<StatefulWidget> createState() {
    return _MQTTViewState();
  }
}

class _MQTTViewState extends State<MQTTView> with WidgetsBindingObserver{
  final TextEditingController _hostTextController = TextEditingController();
  final TextEditingController _messageTextController = TextEditingController();
  final TextEditingController _topicTextController = TextEditingController();
  late MQTTAppState currentAppState;
  late MQTTManager manager;
  late final Timer timer;
  int timesplayed = 0;
  int timesplayed_second = 0;
  @override
  String anim = 'anim';
  AssetImage img = AssetImage(
    'assets/anim.gif',
  );
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _hostTextController.dispose();
    _messageTextController.dispose();
    _topicTextController.dispose();
    super.dispose();
  }
  //bool isBackground = false ;
  //@override
  //void didChangeLifeAppCycleState(AppLifecycleState state) {

    //super.didChangeLifeAppCycleState(state);
    //if (state == AppLifecycleState.inactive||state == AppLifecycleState.detached) return;
     //isBackground = state == AppLifecycleState.paused;
     //print(isBackground);
  //}

  @override
  Widget build(BuildContext context) {
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    final Scaffold scaffold = Scaffold(
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
        body: _buildColumn());
    return scaffold;
  }

  String imagename = '1';
  int selectedDelay = 5;
  void changedelay(int type) {
    selectedDelay = type;
    setState(() {});
  }

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache player = new AudioCache(
      respectSilence: true,
    );
    const alarmAudioPath = "adjust.mp3";
    return await player.play(alarmAudioPath);
  }

  int _dropDownValue = 5;
  int _dropDownValue_min = 15;
  var cancel_start = true;
  Timer _timer =
      Timer(const Duration(seconds: 5), () => print('Timer finished'));
  int seconds = 120;
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) +
        ":" +
        formatTime(minute) +
        ":" +
        formatTime(second);
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  void startTimer() {
    int alpha = _dropDownValue_min * 60;
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        seconds--;
      });
      if (seconds == 0) {
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  int x = 1;

  int mqtt = 0;
  int time_delay = 12;
  int time_goal = 60;
  Color progre_color = Color(0xff67bd42);
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _buildColumn() {
    return Column(
      children: [
        _buildScrollableTextWith(currentAppState.getReceivedText),
      ],
    );
  }

  Widget _buildEditableColumn() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  Widget _buildPublishMessageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: _buildTextFieldWith(_messageTextController, 'Enter a message',
              currentAppState.getAppConnectionState),
        ),
        _buildSendButtonFrom(currentAppState.getAppConnectionState)
      ],
    );
  }

  Widget _buildConnectionStateText(String status) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              color: Colors.deepOrangeAccent,
              child: Text(status, textAlign: TextAlign.center)),
        ),
      ],
    );
  }

  Widget _buildTextFieldWith(TextEditingController controller, String hintText,
      MQTTAppConnectionState state) {
    bool shouldEnable = false;
    if (controller == _messageTextController &&
        state == MQTTAppConnectionState.connected) {
      shouldEnable = true;
    } else if ((controller == _hostTextController &&
            state == MQTTAppConnectionState.disconnected) ||
        (controller == _topicTextController &&
            state == MQTTAppConnectionState.disconnected)) {
      shouldEnable = true;
    }
    return TextField(
        enabled: shouldEnable,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: hintText,
        ));
  }

  AudioCache player = AudioCache();

  Widget _buildScrollableTextWith(String text) {
    mqtt_var = text;
    img.evict();
    timesplayed_second++;
    //print(isBackground);
    if (currentAppState.getReceivedText.contains('0') &&
        timesplayed_second % 15 == 0 ) {
      player.play("adjust.mp3");
      createPostureNotification();
    }
    if (currentAppState.getReceivedText.contains('0') && timesplayed == 0 ) {
      timesplayed++;
      img = AssetImage(
        'assets/reversed.gif',
      );
      player.play("adjust.mp3");
      createPostureNotification();
      progre_color = Colors.red;
    } else if (currentAppState.getReceivedText.contains('1')) {
      timesplayed = 0;
      img = AssetImage(
        'assets/anim.gif',
      );
      progre_color = Color(0xff67bd42);
    }

    return Column(
      children: [
        Row(children: [
          SizedBox(
            width: 15,
          ),
          Text(
            'Good morning ' + widget.fullName,
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
              text: 'Time remaining : ',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                color: Color(0xff67bd42),
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
                text: constructTime(seconds),
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                )),
          ]),
        )),
        SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Center(
              child: Image(
                image: img,
                height: 200,
              ),
            ),
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 12,
                percent: ((seconds / 120) - 1).abs(),
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(child: Text("Choose your goal")),
                            titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                            actionsOverflowButtonSpacing: 20,
                            content: Container(
                                child: DropdownButton(
                              hint: Text('$_dropDownValue_min minutes'),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.blue),
                              items: [15, 30, 60].map(
                                (val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text('$val minutes'),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue_min = val as int;
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            )),
                          );
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
                  initialLabelIndex: 0,
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
                            content: Container(
                                child: DropdownButton(
                              hint: Text('$_dropDownValue seconds'),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.blue),
                              items: [5, 15, 30].map(
                                (val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text('$val seconds'),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue = val as int;
                                    Navigator.pop(context);
                                    print(_dropDownValue);
                                  },
                                );
                              },
                            )),
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
              '$_dropDownValue_min min',
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
              '$_dropDownValue sec',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 17,
                color: Color.fromARGB(255, 49, 49, 49),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        _submitButton(currentAppState.getAppConnectionState),
        _canceltButton(currentAppState.getAppConnectionState),
      ],
    );
  }

  final values = ['1', '2', '3', '4', '5'];
  int _index = 0;

  Widget _submitButton(MQTTAppConnectionState state) {
    return Visibility(
      visible: cancel_start,
      child: InkWell(
        onTap: state == MQTTAppConnectionState.disconnected
            ? _configureAndConnect
            : null,
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
          child: Text('Start Posture Tracking',
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _canceltButton(MQTTAppConnectionState state) {
    return Visibility(
      visible: !cancel_start,
      child: InkWell(
        onTap:
            state == MQTTAppConnectionState.connected ? _disconnect : null, //
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
              color: Colors.red),
          child: Text('Pause Posture Tracking',
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildConnecteButtonFrom(MQTTAppConnectionState state) {
    return Row(
      children: <Widget>[
        Expanded(
          // ignore: deprecated_member_use
          child: RaisedButton(
            color: Colors.lightBlueAccent,
            child: const Text('Connect'),
            onPressed: state == MQTTAppConnectionState.disconnected
                ? _configureAndConnect
                : null, //
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RaisedButton(
            color: Colors.redAccent,
            child: const Text('Disconnect'),
            onPressed: state == MQTTAppConnectionState.connected
                ? _disconnect
                : null, //
          ),
        ),
      ],
    );
  }

  Widget _buildSendButtonFrom(MQTTAppConnectionState state) {
    // ignore: deprecated_member_use
    return RaisedButton(
      color: Colors.green,
      child: const Text('Send'),
      onPressed: state == MQTTAppConnectionState.connected
          ? () {
              _publishMessage(_messageTextController.text);
            }
          : null, //
    );
  }

  String mqtt_var = '1';
  // Utility functions
  String _prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        print('Connected');
        return 'Connected';
      case MQTTAppConnectionState.connecting:
        print('Connecting');
        return 'Connecting';

      case MQTTAppConnectionState.disconnected:
        print('Disconnected');
        return 'Disconnected';
    }
  }

  void _configureAndConnect() {
    // ignore: flutter_style_todos
    // TODO: Use UUID
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    manager = MQTTManager(
        host: 'broker.emqx.io',
        topic: 'splign',
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
    setState(() {
      cancel_start = !cancel_start;
    });
    startTimer();
  }

  void _disconnect() {
    manager.disconnect();
    setState(() {
      cancel_start = !cancel_start;
    });
    cancelTimer();
  }

  void _publishMessage(String text) {
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    final String message = osPrefix + ' says: ' + text;
    manager.publish(message);
    _messageTextController.clear();
  }
}
