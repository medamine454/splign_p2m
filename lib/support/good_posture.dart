
import 'package:flutter/material.dart';

class Good_posture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Color(0xff67bd42),
     body : SafeArea(
       child: SingleChildScrollView(
         child: Column(
           children:<Widget> [
             Container(
               width: double.infinity,
               height: MediaQuery.of(context).size.height / 20,
             ),
             Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(30),
                     topRight: Radius.circular(30),
                 ),

               ),
               child: Column(
                 children: <Widget>[
                   SizedBox(height: 20,),
                   Padding(
                       padding: EdgeInsets.all(20),
                       child: Center(
                         child: Text('You should always keep a good posture',
                         style: TextStyle(
                           fontSize: 28,
                           color: Color(0xff757575),

                         ),
                         textAlign : TextAlign.center),
                       ),

                   ),
                   SizedBox(height: 20,),
                   Container(
                     width: double.infinity,
                     child: Image.asset("assets/images/posture.jpg"),

                   ),
                   SizedBox(height: 20,),

                   Text('What is good posture?'),
                   SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.all(40.0),
                   child: Text(   'Good posture is the proper alignment of your body when standing or sitting. Correct positioning involves training yourself to hold your body against gravity with the least strain and tension on supportive structures, such as your muscles and ligaments. Proper posture keeps your bones and joints in optimal alignment and decreases wear and tear on supportive structures.',
                     style: TextStyle(

                       fontFamily: "Roboto",
                       fontSize: 18.0,
                   ),),
                 ),

                     Text(    'Good posture reduces back and neck pain'),
                   SizedBox(height: 10,),
                     Text( 'Poor posture impacts digestion'),
                   SizedBox(height: 10,),
                     Text('Good posture improves muscle and joint function'),
                   SizedBox(height: 10,),
                     Text( 'Proper posture boosts mood'),
                   SizedBox(height: 10,),
                    Text(  'Proper posture improves spine health'),
                   SizedBox(height: 10,),


                 ],
               ),
             )
           ],
         ),
       ),
     )
   );
  }


}