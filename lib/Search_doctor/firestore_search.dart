import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splign_p2m/Search_doctor/search_service.dart';

class SearchDoctor extends StatefulWidget {
  @override
  _SearchDoctorState createState() => new _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    var capitalizedValue = '';
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    } else {
      var capitalizedValue =
          value.substring(0, 1).toUpperCase() + value.substring(1);
    }

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element()['Username'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

    Widget childWidget() {
      return Container(
        width: mWidth,
        height: mHeight * 0.75,
      );
    }

    return new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'My doctor',
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff67bd42),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 10.0),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element, context);
              }).toList())
        ]));
  }
}

Widget buildResultCard(data, BuildContext context) {
  double mWidth = MediaQuery.of(context).size.width;
  double mHeight = MediaQuery.of(context).size.height;
  Widget _submitButton(data) {
    return InkWell(
      onTap: () async {
        DocumentReference ref =
            FirebaseFirestore.instance.collection('users').doc(data()['id']);

        final user = FirebaseAuth.instance.currentUser;
        List<String> list = [user!.uid];
        await ref
            .update({
              'pending_patients': FieldValue.arrayUnion(list),
            })
            .then((value) => print("Patient added to the list Added"))
            .catchError((error) => print("Failed to add user: $error"));
      },
      child: Container(
        width: mWidth * 0.7,
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
        child: Text('Send tracking request',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 48, // Image radius
                    backgroundImage: NetworkImage(data()['ImgUrl']),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Center(
                      child: Text(
                    'Dr. ' + data()['Username'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  )),
                  SizedBox(
                    height: 3,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_city,
                          color: Color.fromARGB(255, 77, 77, 77),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          data()['Location'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text('------------------------------------------------'),
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: mWidth * 0.8,
                    child: Text(
                      data()['Description'],
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _submitButton(data),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: mWidth * 0.8,
                    child: Text(
                      'By sending this request, you accept to send your posture measurement to this doctor',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          });
    },
    child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48, // Image radius
                backgroundImage: NetworkImage(data()['ImgUrl']),
              ),
              SizedBox(
                height: 7,
              ),
              Center(
                  child: Text(
                'Dr. ' + data()['Username'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              )),
              SizedBox(
                height: 3,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: Color.fromARGB(255, 77, 77, 77),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      data()['Location'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77),
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
  );
}
