
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
                   Padding(
                     padding: const EdgeInsets.all(40.0),
                     child: Text('You may have heard that good posture is essential for good health, but do you know why? Posture refers to how you position your body when you’re sitting, standing, or lying down. Your posture is the result of habits formed over the course of years.'

                         'Many people may recognize poor posture in others without realizing how their own falls short. If you look around at co-workers at the office, you’ll likely find them hunched over at their desks. Learn why good posture matters — and what you can do to improve yours.'),
                   ),

                   Text('What is good posture?'),
                   SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Text(   'Good posture is the proper alignment of your body when standing or sitting. Correct positioning involves training yourself to hold your body against gravity with the least strain and tension on supportive structures, such as your muscles and ligaments. Proper posture keeps your bones and joints in optimal alignment and decreases wear and tear on supportive structures.'),
                 ),

                     Text(    'Good posture reduces back and neck pain'),
                   SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text( 'The proper alignment of your spine allows you to move easily so that your body supports your weight without strain. Poor posture can place stress on your tendons, muscles, and ligaments, leading to neck and back pain.'

                         'If you suffer from neck and back pain, it may surprise you to know that improving your posture may go a long way in easing your symptoms.'),
                      ),

                     Text( 'Poor posture impacts digestion'),
                   SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text( 'Slouching puts your body in an unnatural position that can impact certain abdominal organs. Stooping or hunching over at your desk or slouching while looking at your mobile device can interfere with proper digestion, increasing the risk for acid reflux and constipation.'

                         'If you notice that you get heartburn when slouching, something as simple as sitting up straight may bring relief.'),
                      ),

                     Text('Good posture improves muscle and joint function'),
                   SizedBox(height: 10,),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(  'When you use good posture, your muscles and other structures function properly, helping you to avoid abnormal wear and tear. Improper posture places stress on your joints and can cause them to wear away. This is the most common cause of osteoarthritis, a form of “wear and tear” arthritis.'

                         'While other factors, such as age and genetics, can increase the risk of arthritis, the way you carry your body plays a role in how much stress you put on your joints. Keeping your body aligned in the proper posture can reduce muscle fatigue and strain and help keep your joints healthy and lubricated.'),
                     ),

                     Text( 'Proper posture boosts mood'),
                   SizedBox(height: 10,),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text( 'When you think about factors that can improve your mood, posture likely isn’t the first thing to come to mind. Look at it this way: Your brain and body have two-way communication, meaning that your mood can impact your posture and your posture can affect your mood. When you’re happy, you may notice that you sit upright, and when you’re feeling down, you’re more likely to slouch or sit in a slumped position.'

                         'The next time you notice your mood sinking, try changing your posture; stand up straight, and take deep breaths. You may notice a gentle boost in mood after doing so.'),
                     ),

                       Text(  'Proper posture improves spine health'),
                   SizedBox(height: 10,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(  'Good posture is one of the simplest and easiest ways to keep your spine healthy. While it may take some practice and mindfulness, using correct posture will provide the appropriate back support. This is especially important if you spend time sitting in an office chair or standing throughout the day.'

                         'Sitting and standing with proper alignment improves blood flow, helps keep your nerves and blood vessels healthy, and supports your muscles, ligaments, and tendons. People who make a habit of using correct posture are less likely to experience related back and neck pain.'

                         'Back pain is one of the most common complaints we see at our clinics throughout the Chicagoland area. Our specialists will work with you to address the root cause of your pain and bring you relief.'),
                       ),


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