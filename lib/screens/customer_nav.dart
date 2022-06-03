import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/customer_homepage.dart';
import 'package:hulace/screens/customer/customer_profile.dart';
import '../../utils/constants.dart';
import 'customer/home_Screen_p2.dart';
import 'customer/messages.dart';
import 'customer/screen2.dart';

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
      Container(),
      UserChatList(),
      CustomerProfile(),


    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.shopping_cart_outlined,
    Icons.chat_bubble_outline,
    Icons.person_outline,

  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Screen2()));

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        elevation: 10,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _currentIndex = index),
        //other params
      ),
      body: _children[_currentIndex],
    );
  }
}
