import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/messages.dart';
import 'package:hulace/screens/vendor/jobs.dart';
import 'package:hulace/screens/vendor/orders.dart';
import 'package:hulace/screens/vendor/proposals.dart';
import 'package:hulace/screens/vendor/vendor_alerts.dart';
import 'package:hulace/utils/constants.dart';



class VendorNavBar extends StatefulWidget {
  const VendorNavBar({Key? key}) : super(key: key);

  @override
  State<VendorNavBar> createState() => _VendorNavBarState();
}

class _VendorNavBarState extends State<VendorNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Jobs(),
    Proposals(),
    Orders(),
    UserChatList(),
    VendorAlerts()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_sharp),
            label: 'Proposals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
            label: 'Alerts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
