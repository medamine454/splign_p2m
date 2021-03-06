import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splign_p2m/support/support.dart';

class ProfilePg extends StatefulWidget {
  @override
  _ProfilePgState createState() => _ProfilePgState();
}

class _ProfilePgState extends State<ProfilePg> {
  late String email;
  late String role;
  late String userName;
  late String age = "18";
  late String height;
  late String weight;
  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        email = value.data()!['Email'];
        userName = value.data()!['Username'];
        role = value.data()!['role'];
        age = value.data()!['Age'];
        height = value.data()!['Height'];
        weight = value.data()!['Weight'];
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              } else {
                return Support(
                  age: age,
                  emailadress: email,
                  weight: weight,
                  height: height,
                  fullName: userName,
                );
              }
            }));
  }
}
