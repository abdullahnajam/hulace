import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/provider/UserDataProvider.dart';
import 'package:hulace/screens/auth/intro.dart';
import 'package:hulace/screens/auth/onboarding.dart';
import 'package:hulace/screens/navigators/customer_nav.dart';
import 'package:hulace/screens/navigators/vendor_nav.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/utils/notification_helper.dart';
import 'package:provider/provider.dart';

import 'model/users.dart';
class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
    Notifications.init();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    )
      ..forward()
      ..repeat(reverse: true);
    _loadWidget();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
  final splashDelay = 5;


  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }


 void navigationPage() async{
  if(FirebaseAuth.instance.currentUser!=null){
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot documentSnapshot) async{
      if (documentSnapshot.exists) {
        print("user exists");
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
        UserModel user=UserModel.fromMap(data,documentSnapshot.reference.id);
        print("user ${user.userId} ${user.status}");
        if(user.status=="Pending"){
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));

        }
        else if(user.status=="Blocked"){
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
        }

        else if(user.status=="Approved"){
          final provider = Provider.of<UserDataProvider>(context, listen: false);
          provider.setUserData(user);
          if(user.type=="Customer"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CustomerNavBar()));
          }
          else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => VendorNavBar()));
          }


        }
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
      }

    });
  }
  else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/upper.png",height: 150,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/lower.png",height: 50,width: 80,),
            ),
          ],
        )
    );
  }
}

