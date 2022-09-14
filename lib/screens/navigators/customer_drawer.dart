import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/auth/intro.dart';
import 'package:hulace/screens/auth/onboarding.dart';
import 'package:hulace/screens/customer/create_event.dart';
import 'package:hulace/screens/customer/create_listing.dart';
import 'package:hulace/screens/customer/favourite.dart';
import 'package:hulace/screens/customer/my_order.dart';
import 'package:hulace/screens/get_started/getstarted_auth.dart';
import 'package:hulace/widgets/profile_image.dart';
import 'package:provider/provider.dart';

import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';
import '../../utils/rate_us.dart';
import '../auth/register.dart';
import '../customer/my_events.dart';
import '../customer/my_requests.dart';

class CustomerDrawer extends StatefulWidget {
  const CustomerDrawer({Key? key}) : super(key: key);

  @override
  _CustomerDrawerState createState() => _CustomerDrawerState();
}

class _CustomerDrawerState extends State<CustomerDrawer> {
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
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreateEvent()));
                    },
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: lightColor,
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
                              Text("Create An Event",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
                              SizedBox(height: 3,),
                              Text(df.format(DateTime.now()),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.white),),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right,color: Colors.grey[700],)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
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
                              Text(df.format(DateTime.now()),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.white),),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyEvents()));

                    },
                    leading: Icon(Icons.calendar_today),
                    title: Text("My Events"),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyOrders()));

                    },
                    leading: Icon(Icons.shopping_cart_outlined),
                    title: Text("My Orders"),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyRequests()));

                    },
                    leading: Icon(Icons.list_alt),
                    title: Text("My Requests"),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Favourite()));
                    },
                    leading: Icon(Icons.favorite_border),
                    title: Text("Liked Vendors"),
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
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => IntroScreen()));
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
                  SizedBox(height: 50,),
                ],
              ),
            )
          ],
        ),
    );
  }
}
