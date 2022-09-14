import 'dart:async';
import 'package:hulace/api/firebase_apis.dart';
import 'package:hulace/model/package_model.dart';
import 'package:hulace/screens/customer/create_post.dart';
import 'package:hulace/screens/vendor/create_post.dart';
import 'package:hulace/utils/notification_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulace/model/event_model.dart';
import 'package:hulace/widgets/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:timeago/timeago.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../api/image_api.dart';
import '../../model/event_post_model.dart';
import '../../model/users.dart';
import '../../provider/UserDataProvider.dart';
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
  Future imageModalBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.cloud_upload),
                    title: const Text('Upload file'),
                    onTap: () => {
                      ImageHandler.chooseGallery().then((value) async{
                        if(value!=null){
                          print("not null");
                          String imageUrl=await ImageHandler.uploadImageToFirebase(context, value);
                          setState(() {
                            widget.event.image.add(imageUrl);
                          });
                          await FirebaseFirestore.instance.collection('events').doc(widget.event.id).update({
                            "image":widget.event.image,
                          });

                        }
                        Navigator.pop(context);
                      })
                    }),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () => {
                    ImageHandler.chooseCamera().then((value) async{
                      if(value!=null){
                        String imageUrl=await ImageHandler.uploadImageToFirebase(context, value);
                        setState(() {
                          widget.event.image.add(imageUrl);
                        });
                        await FirebaseFirestore.instance.collection('events').doc(widget.event.id).update({
                          "image":widget.event.image,
                        });
                      }

                      Navigator.pop(context);
                    })
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

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
                    length: 3,
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
                            /*indicator:  UnderlineTabIndicator(
                            borderSide: BorderSide(width: 0.0,color: Colors.white),
                            insets: EdgeInsets.symmetric(horizontal:16.0)
                        ),*/

                            tabs: [
                              Tab(icon: Icon(Icons.view_column_outlined)),
                              Tab(icon: Icon(Icons.image)),
                              Tab(icon: Icon(Icons.person_pin_rounded),),
                            ],
                          ),

                        ),

                        Container(
                          //height of TabBarView
                          height: MediaQuery.of(context).size.height*0.77,

                          child: TabBarView(children: <Widget>[
                            Stack(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('events').doc(widget.event.id).collection('posts')
                                      .orderBy('timestamp',descending: true).snapshots(),
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
                                        child: Text("No Posts"),
                                      );
                                    }

                                    return ListView(
                                      padding: EdgeInsets.only(top: 10),
                                      shrinkWrap: true,
                                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                        PostModel post=PostModel.fromMap(data,document.reference.id);
                                       
                                        return post.packageId==""?eventPost(post):packagePost(post);
                                      }).toList(),
                                    );
                                  },
                                ),
                                if(widget.event.members.contains(FirebaseAuth.instance.currentUser!.uid))
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: InkWell(
                                      onTap: (){
                                        if(provider.userData!.type=="Vendor"){
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VendorPost(widget.event.id)));

                                        }
                                        else{
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreatePost(widget.event.id)));

                                        }

                                      },
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: primaryColor,
                                        child: Icon(Icons.add,color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Stack(
                              children: [
                                if(widget.event.image.isNotEmpty)
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(

                                        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2),
                                        crossAxisSpacing: 3,
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 3
                                    ),
                                    itemCount: widget.event.image.length,
                                    itemBuilder: (BuildContext context,int index){
                                      return Image.network(widget.event.image[index],fit: BoxFit.cover,);
                                    },
                                  )
                                else
                                  Center(
                                    child: Text("No Images"),
                                  ),
                                if(widget.event.userId==FirebaseAuth.instance.currentUser!.uid)
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: InkWell(
                                        onTap: (){
                                          imageModalBottomSheet(context);
                                        },
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: primaryColor,
                                          child: Icon(Icons.add,color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),

                            ListView(
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
                                                                    future: getUserData(widget.event.members[index]),
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
                                Text("Event Code",style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(height: 4,),
                                Text(widget.event.eventCode,style: TextStyle(fontWeight: FontWeight.w300),),
                                SizedBox(height: 20,),
                                Text("Description",style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(height: 4,),
                                Text(widget.event.description,style: TextStyle(fontWeight: FontWeight.w300),),
                                SizedBox(height: 20,),
                                Text("Address",style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(height: 4,),
                                Text(widget.event.location,style: TextStyle(fontWeight: FontWeight.w300),),
                                SizedBox(height: 20,),
                                Text("Services Required",style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(height: 4,),
                                Wrap(
                                  spacing: 5,
                                  children: List.generate(
                                    widget.event.services.length,
                                        (index) {
                                      return FilterChip(
                                        label: Text(widget.event.services[index],style: TextStyle(color: Colors.black),),
                                        backgroundColor: Colors.white, onSelected: (bool value) {  },

                                      );
                                    },
                                  ),
                                ),
                                //Text(widget.event.location,style: TextStyle(fontWeight: FontWeight.w300),),
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
                                if(widget.event.userId!=FirebaseAuth.instance.currentUser!.uid && !widget.event.members.contains(FirebaseAuth.instance.currentUser!.uid)  && !widget.event.pending.contains(FirebaseAuth.instance.currentUser!.uid))
                                  InkWell(
                                    onTap: ()async{
                                      if(widget.event.members.length<widget.event.limit){
                                        if(!widget.event.members.contains(FirebaseAuth.instance.currentUser!.uid)){
                                          setState(() {
                                            widget.event.pending.add(FirebaseAuth.instance.currentUser!.uid);
                                          });
                                          final ProgressDialog pr = ProgressDialog(context: context);
                                          pr.show(max: 100, msg: 'Please Wait');
                                          await FirebaseFirestore.instance.collection('events').doc(widget.event.id).update({
                                            "pending":widget.event.pending,
                                          }).then((value){
                                            getUserData(widget.event.userId).then((value){
                                              Notifications.sendNotification(
                                                  value.token,
                                                  "Join Request",
                                                  "${provider.userData!.firstName} ${provider.userData!.lastName} has requested to join your group",
                                                  NotificationType.eventRequest,
                                                  widget.event.userId,
                                                  widget.event.id,
                                                  true
                                              );
                                            });

                                            pr.close();
                                            CoolAlert.show(
                                              context: context,
                                              type: CoolAlertType.success,
                                              text: "Request Sent to organizer",
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
                                      child: Text("JOIN EVENT",style: TextStyle(color: whiteColor,fontWeight: FontWeight.w500),),
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
                                      child: Text("LEAVE EVENT",style: TextStyle(color: whiteColor,fontWeight: FontWeight.w500),),
                                    ),
                                  ),
                              ],
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
  Widget eventPost(PostModel post){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<UserModel>(
            future: getUserData(post.userId),
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
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ProfilePicture(snapshot.data!.profilePic),
                    title: Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                    subtitle: Text(format(DateTime.fromMillisecondsSinceEpoch(post.timestamp)),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                  );

                }
              }
            }
        ),

        Text(post.title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
        SizedBox(height: 10,),
        Image.network(post.url,height: MediaQuery.of(context).size.height*0.25,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
        SizedBox(height: 10,),
      ],
    );
  }
  Widget packagePost(PostModel post){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<UserModel>(
            future: getUserData(post.userId),
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
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ProfilePicture(snapshot.data!.profilePic),
                    title: Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                    subtitle: Text(format(DateTime.fromMillisecondsSinceEpoch(post.timestamp)),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                  );

                }
              }
            }
        ),

        FutureBuilder<PackageModel>(
            future: getPackageData(post.packageId),
            builder: (context, AsyncSnapshot<PackageModel> snapshot) {
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
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            children:[
                              Container(
                                height: MediaQuery.of(context).size.height*0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data!.image,),
                                        fit: BoxFit.cover
                                    )

                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text("KM${snapshot.data!.budget}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
                                ),
                              ),
                            ]
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 5,top: 5),
                          child: Text(snapshot.data!.title,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(snapshot.data!.description,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w400),),
                        ),
                        if(FirebaseAuth.instance.currentUser!.uid==widget.event.userId)
                        InkWell(
                          onTap:(){
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2100, 6, 7),
                                onChanged: (date) {
                                  print('change $date');
                                },
                                onConfirm: (date) async{
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.confirm,
                                      text: "Are you sure you want to place the order?",
                                      onConfirmBtnTap: ()async{
                                        final ProgressDialog pr = ProgressDialog(context: context);
                                        pr.show(max: 100, msg: 'Please Wait');

                                        await FirebaseFirestore.instance.collection('orders').add({
                                          "vendorId":post.userId,
                                          "customerId":FirebaseAuth.instance.currentUser!.uid,
                                          "budget":snapshot.data!.budget,
                                          "status":"In Progress",
                                          "category":snapshot.data!.category,
                                          "date": df.format(date),
                                          "time": tf.format(date),
                                          "packageId": post.id,
                                          "paymentStatus": "Not Paid",
                                          "isRated": false,
                                          "rating": 0,
                                          "dateTime":date.millisecondsSinceEpoch,
                                          "createdAt":DateTime.now().millisecondsSinceEpoch,

                                        }).then((val)async{
                                          pr.close();
                                          CoolAlert.show(
                                              context: context,
                                              type: CoolAlertType.success,
                                              text: "Order Placed",
                                              onConfirmBtnTap: (){
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }
                                          );





                                        }).onError((error, stackTrace){
                                          pr.close();
                                          Navigator.pop(context);
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: error.toString(),
                                          );
                                        });
                                      }
                                  );
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en
                            );
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )
                            ),
                            alignment: Alignment.center,
                            child: Text("Place Order",style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                  );

                }
              }
            }
        ),


      ],
    );
  }
}
