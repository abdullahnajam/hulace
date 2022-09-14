import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/api/firebase_apis.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/utils/notification_helper.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:timeago/timeago.dart';

import '../../model/event_model.dart';
import '../../model/notification_model.dart';
import '../../model/users.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({Key? key}) : super(key: key);

  @override
  _UserNotificationsState createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(7),
                      child: Icon(Icons.arrow_back_ios_sharp,size: 15,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.notifications,color: primaryColor,),
                  SizedBox(width: 5,),
                  Text("Notifications",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),


                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('notifications')
                    .where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy("timestamp",descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("errrrr ${snapshot.error.toString()}");
                    return Text('Somethg went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data!.size==0) {
                    return Center(
                      child: Text("No Notifications"),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.only(top: 10),

                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      NotificationModel model=NotificationModel.fromMap(data,document.reference.id);
                      return InkWell(
                        onTap: (){
                          if(model.type==NotificationType.eventRequest){
                            if(model.action){
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.confirm,
                                title: "Event Join Request",
                                text: "Do you want to accept this event request",
                                onConfirmBtnTap: ()async{
                                  final ProgressDialog pr = ProgressDialog(context: context);
                                  pr.show(max: 100, msg: 'Please Wait');
                                  EventModel _event=await getEventData(model.subjectId);
                                  _event.pending.remove(model.senderId);
                                  _event.members.add(model.senderId);

                                  await FirebaseFirestore.instance.collection('events').doc(model.subjectId).update({
                                    "pending":_event.pending,
                                    "members":_event.members
                                  }).then((value)async{
                                    await FirebaseFirestore.instance.collection('notifications').doc(model.id).update({
                                      "action":false,
                                    });
                                    pr.close();
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      text: "Member Added",
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

                                confirmBtnText: "Accept",
                                cancelBtnText: "Reject",
                                onCancelBtnTap: ()async{
                                  final ProgressDialog pr = ProgressDialog(context: context);
                                  pr.show(max: 100, msg: 'Please Wait');
                                  UserModel _user=await getUserData(model.senderId);
                                  await FirebaseFirestore.instance.collection('notifications').doc(model.id).update({
                                    "action":false,
                                  }).then((value)async{
                                    await Notifications.sendNotification(_user.token, "Request Rejected", "Your request to join event is rejected", NotificationType.rejectedEvent, model.senderId, model.subjectId,false);
                                    pr.close();
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      text: "Request Rejected",
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

                              );

                            }
                            else{
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: "You have already accepted/rejected this request",
                              );
                            }

                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/person.png"),
                                  )
                              ),
                            ),
                            title:Text(model.title,style: TextStyle(fontWeight:FontWeight.w500,fontSize: 13),),
                            subtitle:Text(model.body,style: TextStyle(fontSize: 13),),
                            trailing: Text(format(DateTime.fromMillisecondsSinceEpoch(model.timestamp)),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),

                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
