import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hulace/screens/chat_screen.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/widgets/profile_image.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../model/package_model.dart';
import '../../model/users.dart';

class ViewVendor extends StatefulWidget {
  UserModel vendor;

  ViewVendor(this.vendor);

  @override
  _ViewVendorState createState() => _ViewVendorState();
}

class _ViewVendorState extends State<ViewVendor> {
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

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

                   /* InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserNotifications()));
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
                                child:  Icon(Icons.favorite_border,color: primaryColor,)
                            )
                        ),
                      ),
                    ),*/
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
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ProfilePicture(widget.vendor.profilePic),
                      title: Text("${widget.vendor.firstName} ${widget.vendor.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),
                      subtitle: Text("${widget.vendor.businessName}",style: TextStyle(fontWeight: FontWeight.w300),),
                      trailing: InkWell(
                        onTap: ()async{

                          await FirebaseFirestore.instance.collection('chat_head').doc("${FirebaseAuth.instance.currentUser!.uid}-${widget.vendor.userId}").set({
                            "customerId":FirebaseAuth.instance.currentUser!.uid,
                            "vendorId":widget.vendor.userId,
                          }).then((value){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen("Customer",widget.vendor.userId,"${FirebaseAuth.instance.currentUser!.uid}-${widget.vendor.userId}")));
                          }).onError((error, stackTrace){
                            Navigator.pop(context);
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: error.toString(),
                            );
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.message,color: Colors.white,),
                        ),
                      ),
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
                                Text("Rating",style: TextStyle(color: Colors.white),),
                                Text("0",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                              ],
                            ),
                            VerticalDivider(color: secondaryColor),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Category",style: TextStyle(color:Colors.white),),
                                Text(widget.vendor.businessCategory,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                              ],
                            ),
                            VerticalDivider(color: secondaryColor,width: 2,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Orders",style: TextStyle(color:Colors.white)),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('orders')
                                      .where("vendorId",isEqualTo: widget.vendor.userId).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: Text("-"),
                                      );
                                    }



                                    return Center(
                                      child: Text(snapshot.data!.size.toString(),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white)),
                                    );
                                  },
                                )

                              ],
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    Text("Packages",style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 4,),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('packages')
                          .where("userId",isEqualTo: widget.vendor.userId).snapshots(),
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
                            child: Text("No Packages"),
                          );
                        }

                        return ListView(
                          padding: EdgeInsets.only(top: 10),

                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            PackageModel model=PackageModel.fromMap(data,document.reference.id);
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
                                                  image: NetworkImage(model.image,),
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
                                            child: Text("KM${model.budget}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
                                          ),
                                        ),
                                      ]
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 5,top: 5),
                                    child: Text(model.title,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(model.description,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w400),),
                                  ),

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
                                                  "vendorId":model.userId,
                                                  "customerId":FirebaseAuth.instance.currentUser!.uid,
                                                  "budget":model.budget,
                                                  "status":"In Progress",
                                                  "category":model.category,
                                                  "date": df.format(date),
                                                  "time": tf.format(date),
                                                  "packageId": model.id,
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
                          }).toList(),
                        );
                      },
                    ),
                    SizedBox(height: 20,),

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
