import 'package:flutter/material.dart';
import 'package:hulace/screens/vendor/job_detail.dart';
import 'package:hulace/screens/navigators/vendor_drawer.dart';
import 'package:hulace/utils/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/notifications.dart';

import '../../utils/constants.dart';
import '../navigators/customer_drawer.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  String dropdownValue="Trending";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: secondaryColor,
      key: _drawerKey,
      drawer: VendorDrawer(),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height*0.28,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: secondaryColor,
                /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black,
                      Color(0xff2e2e30),
                    ],
                  ),*/
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            _openDrawer();
                          },
                          child: Image.asset("assets/images/menu.png",color: primaryColor,height: 40,),
                        ),


                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserNotifications()));
                          },
                          child: Container(
                            height: 50,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                elevation: 3,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child:  Icon(Icons.notifications_none,color: primaryColor,)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset("assets/images/icon.png",height: 25,color: primaryColor,),
                        SizedBox(width: 10,),
                        Text("Hulace, Discover Events To Host",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 60,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 3,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(2),
                            height: 60,
                            width: 50,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)
                              /*borderRadius: BorderRadius.only(
                              topLeft:Radius.circular(10),
                              bottomLeft:Radius.circular(10),
                            )*/
                            ),
                            child: Icon(Icons.search,color: secondaryColor,),
                          ),
                          SizedBox(width: 10,),
                          Text("Find amazing events",style: TextStyle(fontSize: 16,color: Colors.grey),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            //height: MediaQuery.of(context).size.height*0.65,
            //width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: bgColor,

                  borderRadius: BorderRadius.circular(20)
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top:20,left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category Events",style: TextStyle(fontSize:18,fontWeight: FontWeight.w500),),
                        Text("View All",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FilterChip(
                            backgroundColor: Colors.white,
                            label: Text("Sports"),
                            onSelected: (bool value) {
                              setState(() {

                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FilterChip(
                            backgroundColor: Colors.white,
                            label: Text("Wedding"),
                            onSelected: (bool value) {
                              setState(() {

                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FilterChip(
                            backgroundColor: Colors.white,
                            label: Text("Concert"),
                            onSelected: (bool value) {
                              setState(() {

                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: 5,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetail()));

                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10,right: 10),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage("assets/images/person.png")
                                          )
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Need a Wedding Planner",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 15),),
                                                Text("2 min ago",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 12),)
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 12),),


                                            /*Row(
                                              children: [
                                                Icon(Icons.payments_outlined,size: 18,),
                                                SizedBox(width: 3,),
                                                Text("\$500",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                                                SizedBox(width: 20,),
                                                Icon(Icons.calendar_today_outlined,size: 18,),
                                                SizedBox(width: 3,),
                                                Text("18/05/2022",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),)
                                              ],
                                            ),*/
                                          ],
                                        ),
                                      ),

                                    )
                                  ],
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height*0.07,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("\$",style: TextStyle(color: Colors.white),),
                                            Text("EM5000",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                                          ],
                                        ),
                                        VerticalDivider(color: secondaryColor),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Category",style: TextStyle(color:Colors.white),),
                                            Text("Sports",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                                          ],
                                        ),
                                        VerticalDivider(color: secondaryColor,width: 2,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Date",style: TextStyle(color:Colors.white)),
                                            Text("18/05/2022",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white))
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}


