import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:hulace/screens/customer/customer_homepage.dart';
import 'package:hulace/screens/customer/customer_profile.dart';
import 'package:hulace/screens/customer/search.dart';
import '../../../utils/constants.dart';
import '../customer/home_Screen_p2.dart';
import '../customer/messages.dart';
import '../customer/screen2.dart';

class CustomerNavBar extends StatefulWidget {

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<CustomerNavBar>{

  int _currentIndex = 0;

  List<Widget> _children=[];

  @override
  void initState() {
    super.initState();
    _children = [
      CustomerHomepage(),
      Search(),
      UserChatList(),
      CustomerProfile(),


    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: Colors.black,
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.circle,
        shape: bottomBarShape,
        padding: EdgeInsets.all(0),

        snakeViewColor: primaryColor,
        selectedItemColor: SnakeShape.circle == SnakeShape.indicator ? bgColor : null,
        unselectedItemColor: Colors.white,

        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.cabin), label: 'tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'mic'),
        ],
      ),

      body: _children[_currentIndex],
    );
  }
}
