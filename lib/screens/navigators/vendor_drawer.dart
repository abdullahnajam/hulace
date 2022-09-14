import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/create_event.dart';
import 'package:hulace/screens/customer/create_listing.dart';
import 'package:hulace/screens/customer/my_order.dart';
import 'package:hulace/screens/vendor/create_package.dart';
import 'package:hulace/screens/vendor/my_packages.dart';
import 'package:hulace/screens/vendor/proposals.dart';
import 'package:hulace/screens/vendor/vendor_my_events.dart';
import 'package:hulace/screens/vendor/vprofile.dart';
import 'package:hulace/widgets/profile_image.dart';
import 'package:provider/provider.dart';

import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';
import '../../utils/rate_us.dart';
import '../customer/my_requests.dart';
import '../get_started/getstarted_auth.dart';

class VendorDrawer extends StatefulWidget {
  const VendorDrawer({Key? key}) : super(key: key);

  @override
  _VendorDrawerState createState() => _VendorDrawerState();
}

class _VendorDrawerState extends State<VendorDrawer> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: drawerHeadGradient
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfilePicture(provider.userData!.profilePic),
                  SizedBox(height: 10,),
                  //Text(provider.userData.,style: TextStyle(color: Colors.white,fontSize: 16),),
                  Text(provider.userData!.email,style: TextStyle(color: Colors.white,fontSize: 14),),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreatePackage()));
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create A Package",style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
                            SizedBox(height: 3,),
                            Text("6/6/2022",style: TextStyle(color:Colors.white,fontSize: 12,fontWeight: FontWeight.w300),),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_right,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                /*InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreateListing()));
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create A Request",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
                            SizedBox(height: 3,),
                            Text("6/6/2022",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.white),),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_right,color: Colors.white,)
                      ],
                    ),
                  ),
                ),*/
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyPackages()));

                  },
                  leading: Icon(Icons.assignment),
                  title: Text("My Packages"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VendorMyEvents()));

                  },
                  leading: Icon(Icons.calendar_today),
                  title: Text("My Events"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Proposals()));

                  },
                  leading: Icon(Icons.list_alt),
                  title: Text("Sent Requests"),
                ),

                Divider(color: Colors.grey,),
                ListTile(
                  onTap: (){
                    showRateUsDialog(context);
                  },
                  leading: Icon(Icons.star_half),
                  title: Text("Rate Our App"),
                ),
                ListTile(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PainScale()));

                  },
                  leading: Icon(Icons.verified_user_rounded),
                  title: Text("Terms and Condition"),
                ),
                ListTile(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => About()));

                  },
                  leading: Icon(Icons.search),
                  title: Text("About"),
                ),
                ListTile(
                  onTap: (){

                  },
                  leading: Icon(Icons.chat),
                  title: Text("Contact Us"),
                ),
                ListTile(
                  onTap: ()async{
                    await FirebaseAuth.instance.signOut().then((value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => GetStartedAuth()));

                    });
                  },
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
