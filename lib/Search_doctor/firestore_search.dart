import 'package:flutter/material.dart';

class SearchDoctor extends StatefulWidget {
  const SearchDoctor({Key? key}) : super(key: key);

  @override
  State<SearchDoctor> createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TextButton(onPressed: () {}, child: Text('Add doctor'))
      ],
    );
  }
}
