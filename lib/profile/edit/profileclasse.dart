import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend/Firebase/authentication.dart';
import '../../Signup_login/loginPage.dart';

class ProfilePageFinal extends StatelessWidget {
  String PhoneNumber;
  String emailadress;
  String fullName;
  int num_orders;
  String imageURL;
  ProfilePageFinal(
      {Key ?key,
        required this.PhoneNumber,
        required this.emailadress,
        required this.fullName,
        required this.num_orders,
        required this.imageURL})
      : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(),
        Container(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        heroTag: "btn1",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        )

                      ),
                      FloatingActionButton(
                        heroTag: "btn2",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: () {
                          AuthenticationHelper().signOut();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>  LoginPage()));
                          final snackBar = SnackBar(
                              content:
                              Text('You have successfully logged out!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ],
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'My Profile',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.beVietnamPro(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    height: innerHeight * 0.72,
                                    width: innerWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 80,
                                        ),
                                        Text(
                                          fullName,
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontFamily: 'Nunito',
                                            fontSize: 37,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Past orders',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              num_orders.toString(),
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))),
                            Center(
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 80,
                                      backgroundImage: NetworkImage(imageURL)),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.38,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '\nFull Name : ',
                              style: TextStyle(
                                color: Color.fromRGBO(39, 105, 171, 1),
                                fontSize: 25,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              fullName,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Phone : ',
                              style: TextStyle(
                                color: Color.fromRGBO(39, 105, 171, 1),
                                fontSize: 25,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              PhoneNumber,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Email :',
                              style: TextStyle(
                                color: Color.fromRGBO(39, 105, 171, 1),
                                fontSize: 25,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              emailadress,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Center(
                      child: RaisedButton(
                        padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        color: Colors.white,
                        splashColor: Colors.lightBlueAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditProfilePgg()));
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Color.fromRGBO(39, 105, 171, 1),
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            letterSpacing: 2.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}