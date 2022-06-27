import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:hulace/screens/customer/customer_profile.dart';
import 'package:hulace/screens/customer/messages.dart';
import 'package:hulace/screens/customer/my_order.dart';
import 'package:hulace/screens/vendor/jobs.dart';
import 'package:hulace/screens/vendor/orders.dart';
import 'package:hulace/screens/vendor/proposals.dart';
import 'package:hulace/screens/vendor/vendor_alerts.dart';
import 'package:hulace/screens/vendor/vendor_chat.dart';
import 'package:hulace/screens/vendor/vendor_profile.dart';
import 'package:hulace/utils/constants.dart';



class VendorNavBar extends StatefulWidget {
  const VendorNavBar({Key? key}) : super(key: key);

  @override
  State<VendorNavBar> createState() => _VendorNavBarState();
}

class _VendorNavBarState extends State<VendorNavBar> {




  int _currentIndex = 0;

  List<Widget> _children=[];

  @override
  void initState() {
    super.initState();
    _children = [
      Jobs(),
      Orders(),
      VendorChat(),
      VendorProfile()


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
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'mic'),
        ],
      ),

      body: _children[_currentIndex],
    );
  }
}
