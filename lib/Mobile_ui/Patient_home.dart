import 'package:flutter/material.dart';

class Homepatient extends StatefulWidget {
  const Homepatient({Key? key}) : super(key: key);

  @override
  _HomepatientState createState() => _HomepatientState();
}

class _HomepatientState extends State<Homepatient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Home for patient')),
    );
  }
}
