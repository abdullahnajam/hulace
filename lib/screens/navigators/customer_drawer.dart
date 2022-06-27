import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/create_event.dart';
import 'package:hulace/screens/customer/create_listing.dart';
import 'package:hulace/screens/customer/my_order.dart';

import '../../utils/constants.dart';
import '../../utils/rate_us.dart';
import '../customer/my_requests.dart';

class CustomerDrawer extends StatefulWidget {
  const CustomerDrawer({Key? key}) : super(key: key);

  @override
  _CustomerDrawerState createState() => _CustomerDrawerState();
}

class _CustomerDrawerState extends State<CustomerDrawer> {
  @override
  Widget build(BuildContext context) {
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
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/profile.png",),
                              fit: BoxFit.cover
                          )

                      ),

                    ),
                    SizedBox(height: 10,),
                    //Text(provider.userData.,style: TextStyle(color: Colors.white,fontSize: 16),),
                    Text("user@mail.com",style: TextStyle(color: Colors.white,fontSize: 14),),
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
                              Text("Create An Event",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                              SizedBox(height: 3,),
                              Text("6/6/2022",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
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
                              Text("6/6/2022",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.white),),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right,color: Colors.white,)
                        ],
                      ),
                    ),
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
                    onTap: (){

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
