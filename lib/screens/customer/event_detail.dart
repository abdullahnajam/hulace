import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulace/model/event_model.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../model/users.dart';
import '../../utils/constants.dart';

class EventDetail extends StatefulWidget {
  EventModel event;

  EventDetail(this.event);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  Future<UserModel> getUserData(String id)async{
    UserModel? request;
    await FirebaseFirestore.instance.collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
        request=UserModel.fromMap(data, documentSnapshot.reference.id);
      }
    });
    return request!;
  }
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition? _kGooglePlex;
  final Set<Marker> markers = new Set();
  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.event.coordinates.latitude, widget.event.coordinates.longitude),
      zoom: 15,
    );
    LatLng _center =  LatLng(widget.event.coordinates.latitude, widget.event.coordinates.longitude);
    markers.add(Marker( //add first marker
      markerId: MarkerId(widget.event.id.toString()),
      position: _center, //position of marker
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(widget.event.image),
                      fit: BoxFit.cover
                  )
              ),
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
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: bgColor,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                ),
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    FutureBuilder<UserModel>(
                        future: getUserData(widget.event.userId),
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
                                return Row(
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
                                    SizedBox(width: 7,),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),

                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                              else{
                                return Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot.data!.profilePic),
                                              fit: BoxFit.cover
                                          )

                                      ),

                                    ),
                                    SizedBox(width: 7,),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),

                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }

                            }
                          }
                        }
                    ),

                    SizedBox(height: 20,),
                    Container(
                        height: MediaQuery.of(context).size.height*0.07,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Time",style: TextStyle(color: Colors.white),),
                                Text(widget.event.time,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                              ],
                            ),
                            VerticalDivider(color: secondaryColor),
                            InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height*0.7,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Members",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(Icons.close),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: widget.event.members.length,
                                                itemBuilder: (BuildContext context,int index){
                                                  return  FutureBuilder<UserModel>(
                                                      future: getUserData(widget.event.userId),
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
                                                              return Row(
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
                                                                  SizedBox(width: 7,),
                                                                  Container(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),

                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            }
                                                            else{
                                                              return Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.all(2),
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(snapshot.data!.profilePic),
                                                                            fit: BoxFit.cover
                                                                        )

                                                                    ),

                                                                  ),
                                                                  SizedBox(width: 7,),
                                                                  Container(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),

                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            }

                                                          }
                                                        }
                                                      }
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      );
                                    });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Members",style: TextStyle(color:Colors.white),),
                                  Text(widget.event.members.length.toString(),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                                ],
                              ),
                            ),
                            VerticalDivider(color: secondaryColor,width: 2,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Date",style: TextStyle(color:Colors.white)),
                                Text(widget.event.date,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white))
                              ],
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    Text("Description",style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 4,),
                    Text(widget.event.description,style: TextStyle(fontWeight: FontWeight.w300),),
                    SizedBox(height: 20,),
                    Text("Address",style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 4,),
                    Text(widget.event.location,style: TextStyle(fontWeight: FontWeight.w300),),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        markers: markers,
                        initialCameraPosition: _kGooglePlex!,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    if(widget.event.userId!=FirebaseAuth.instance.currentUser!.uid && !widget.event.members.contains(FirebaseAuth.instance.currentUser!.uid))
                      InkWell(
                      onTap: ()async{
                        if(widget.event.members.length<widget.event.limit){
                          if(!widget.event.members.contains(FirebaseAuth.instance.currentUser!.uid)){
                            setState(() {
                              widget.event.members.add(FirebaseAuth.instance.currentUser!.uid);
                            });
                            final ProgressDialog pr = ProgressDialog(context: context);
                            pr.show(max: 100, msg: 'Please Wait');
                            await FirebaseFirestore.instance.collection('events').doc(widget.event.id).update({
                              "members":widget.event.members,
                            }).then((value){
                              pr.close();
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Event Joined",
                              );
                            }).onError((error, stackTrace){
                              pr.close();
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: error.toString(),
                              );
                            });
                          }
                          else{
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text: "Event already joined",
                            );
                          }
                        }
                        else{
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.info,
                            text: "Event capacity is full",
                          );
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Text("Join Event"),
                      ),
                    ),
                    if(widget.event.members.contains(FirebaseAuth.instance.currentUser!.uid))
                      InkWell(
                        onTap: ()async{
                          setState(() {
                            widget.event.members.remove(FirebaseAuth.instance.currentUser!.uid);
                          });
                          final ProgressDialog pr = ProgressDialog(context: context);
                          pr.show(max: 100, msg: 'Please Wait');
                          await FirebaseFirestore.instance.collection('events').doc(widget.event.id).update({
                            "members":widget.event.members,
                          }).then((value){
                            pr.close();
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Event Left",
                            );
                          }).onError((error, stackTrace){
                            pr.close();
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: error.toString(),
                            );
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          alignment: Alignment.center,
                          child: Text("Leave Event"),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
