import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/notifications.dart';

import '../../utils/constants.dart';
import '../navigators/customer_drawer.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({Key? key}) : super(key: key);

  @override
  _CustomerHomepageState createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
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
      drawer: CustomerDrawer(),
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
                        Text("Hulace, Discover Amazing Events",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w500),)
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
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("News Feed",style: TextStyle(fontSize:18,color: primaryColor),),
                        SizedBox(height: 10,),
                        Container(
                          height: 90,
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context,int index){
                              return InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white,width: 1.5),
                                              image: DecorationImage(
                                                  image: AssetImage("assets/images/event.png",),

                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text("Event # ${index+1}",textAlign: TextAlign.center,style: TextStyle(fontSize:14,fontWeight: FontWeight.w300),),

                                      ],
                                    ),
                                  )
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
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
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10,top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                      child: Text("Sports Event",style: TextStyle(fontSize:13,fontWeight: FontWeight.w300,color: Colors.white),),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage("assets/images/person.png"),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("John Doe",style: TextStyle(),),
                                        Text("3 Days Ago",style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 0,),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child:Text("Wanna play futsal next week. Let's connect? Join my event.",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),

                              ),

                              SizedBox(height: 0,),
                              Container(
                                height: 50,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today_outlined,size: 15,color: Colors.grey,),
                                          Text("  25.5.22",style: TextStyle(fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,size: 15,color: Colors.grey,),
                                          Text("  town",style: TextStyle(fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time_rounded,size: 15,color: Colors.grey,),
                                          Text("  2 hr",style: TextStyle(fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.people_outline,size: 15,color: Colors.grey,),
                                          Text("  30",style: TextStyle(fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
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
