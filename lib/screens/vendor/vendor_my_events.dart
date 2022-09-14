import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/create_event.dart';
import 'package:timeago/timeago.dart';

import '../../api/firebase_apis.dart';
import '../../model/event_model.dart';
import '../../model/users.dart';
import '../../utils/constants.dart';
import '../customer/event_detail.dart';

class VendorMyEvents extends StatefulWidget {
  const VendorMyEvents({Key? key}) : super(key: key);

  @override
  _VendorMyEventsState createState() => _VendorMyEventsState();
}

class _VendorMyEventsState extends State<VendorMyEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,

      body: Container(
        margin: EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.08,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
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
                                child:  Icon(Icons.arrow_back,color: primaryColor,)
                            )
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                decoration: BoxDecoration(
                    color: bgColor,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                ),
                child:  DefaultTabController(
                    length: 2,
                    child:Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey[500],
                            indicatorColor: primaryColor,
                            padding: EdgeInsets.all(5),
                            indicator : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),


                            tabs: [
                              Tab(child: Text("JOINED")),
                              Tab(child: Text("PENDING"),),
                            ],
                          ),

                        ),

                        Container(
                          //height of TabBarView
                          height: MediaQuery.of(context).size.height*0.77,

                          child: TabBarView(children: <Widget>[

                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('events').where("members",arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.data!.size==0) {
                                  return Center(
                                    child: Text("No Events"),
                                  );
                                }

                                return ListView(
                                  padding: EdgeInsets.only(top: 10),
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    EventModel model=EventModel.fromMap(data,document.reference.id);
                                    return Event(model);
                                  }).toList(),
                                );
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('events').where("pending",arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.data!.size==0) {
                                  return Center(
                                    child: Text("No Events"),
                                  );
                                }

                                return ListView(
                                  padding: EdgeInsets.only(top: 10),
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    EventModel model=EventModel.fromMap(data,document.reference.id);
                                    return Event(model);
                                  }).toList(),
                                );
                              },
                            ),







                          ]),
                        )

                      ],

                    )
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Event(EventModel model){

    return InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EventDetail(model)));

        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10,top: 10,left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      child: Text(model.category,style: TextStyle(fontSize:13,fontWeight: FontWeight.w300,color: Colors.white),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FutureBuilder<UserModel>(
                        future: getUserData(model.userId),
                        builder: (context, AsyncSnapshot<UserModel> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              child: Text("-",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300)),
                            );
                          }
                          else {
                            if (snapshot.hasError) {
                              print("error ${snapshot.error}");
                              return Center(
                                child: Text("error ${snapshot.error}"),
                              );
                            }


                            else {
                              if(snapshot.data!.profilePic==""){
                                return Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/person.png"),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                );
                              }
                              else{
                                return Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot.data!.profilePic),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                );
                              }

                            }
                          }
                        }
                    ),

                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<UserModel>(
                            future: getUserData(model.userId),
                            builder: (context, AsyncSnapshot<UserModel> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  child: Text("-",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300)),
                                );
                              }
                              else {
                                if (snapshot.hasError) {
                                  print("error ${snapshot.error}");
                                  return Center(
                                    child: Text("error ${snapshot.error}"),
                                  );
                                }


                                else {
                                  return Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(),);

                                }
                              }
                            }
                        ),

                        Text(format(DateTime.fromMillisecondsSinceEpoch(model.createdAt)),style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 0,),
              Padding(
                padding: EdgeInsets.all(10),
                child:Text(model.description,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),

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
                          Text("  ${model.date}",style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,size: 15,color: Colors.grey,),
                          Text("  ${model.city}",style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded,size: 15,color: Colors.grey,),
                          Text("  ${model.time}",style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.people_outline,size: 15,color: Colors.grey,),
                          Text("  ${model.members.length}",style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
