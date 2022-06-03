import 'package:flutter/material.dart';
import 'package:hulace/screens/vendor/vendor_profile.dart';

import '../../utils/constants.dart';

class VendorDrawer extends StatefulWidget {
  const VendorDrawer({Key? key}) : super(key: key);

  @override
  _VendorDrawerState createState() => _VendorDrawerState();
}

class _VendorDrawerState extends State<VendorDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/person.png")
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Text("William Jones",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)

              ],
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VendorProfile()));

              },
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),

            ListTile(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Settings()));

              },
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),

            ListTile(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VendorProfile()));

              },
              leading: Icon(Icons.show_chart),
              title: Text("My Ratings"),
            ),

            ListTile(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VendorProfile()));

              },
              leading: Icon(Icons.info),
              title: Text("Help & Support"),
            ),
          ],
        ),
      ),
    );
  }
}
