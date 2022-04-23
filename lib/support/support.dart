import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splign_p2m/support/good_posture.dart';
import '../app/constans/enum.dart';
import 'category_card.dart';
import 'search_bar.dart';

import '../app/shared_components/coustom_bottom_nav_bar.dart';
const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);



class Support extends StatefulWidget {
  Support(

      {Key ?key,
        required this.age,
        required this.emailadress,
        required this.weight,
        required this.height,
        required this.fullName,})

      : super(key: key);
  String age;
  String weight;
  String height;
  String emailadress;
  String fullName;
  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
<<<<<<< HEAD
=======

>>>>>>> 79a7db9c9ca79591993f0c42258692d62bfc42a2
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,

            decoration: BoxDecoration(
              color: Color(0xff67bd42),
              borderRadius: new BorderRadius.only(
                bottomLeft: const Radius.circular(30.0),
                bottomRight: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),

              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xff67bd42),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "Good Morning"+ widget.fullName,
                  ),
                  SearchBar(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "You should always keep a good posture",
                          svgSrc: "assets/icons/posture.svg",
                          press: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Good_posture()),
                          );},
                        ),
                        CategoryCard(
                          title: "Yoga is good for you",
                          svgSrc: "assets/icons/Yoga.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "You Have To Eat Healthy",
                          svgSrc: "assets/icons/Eat_healthy.svg",
                          press: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Good_posture()),
                          );},
                        ),
                        CategoryCard(
                          title: "Make a medical ckeckup ",
                          svgSrc: "assets/icons/Medical_care.svg",
                          press: () {},
                        ),

                        CategoryCard(
                          title: "Maintain a stress free lifestyle",
                          svgSrc: "assets/icons/healthy_lifestyle.svg",
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
