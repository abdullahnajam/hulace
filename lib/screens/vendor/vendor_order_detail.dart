import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hulace/model/order_model.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/widgets/profile_image.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../model/package_model.dart';
import '../../model/users.dart';
import '../../api/firebase_apis.dart';

class VendorOrderDetail extends StatefulWidget {
  OrderModel order;

  VendorOrderDetail(this.order);

  @override
  _VendorOrderDetailState createState() => _VendorOrderDetailState();
}

class _VendorOrderDetailState extends State<VendorOrderDetail> {
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
                        Text("Amount",style: TextStyle(color: Colors.white),),
                        Text(widget.order.budget,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                      ],
                    ),
                    VerticalDivider(color: secondaryColor),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Category",style: TextStyle(color:Colors.white),),
                        Text(widget.order.category,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                      ],
                    ),
                    VerticalDivider(color: secondaryColor,width: 2,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Placed On",style: TextStyle(color:Colors.white)),
                        Text(widget.order.date,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)

                      ],
                    ),
                  ],
                )
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
                        future: getUserData(widget.order.customerId),
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
                                title: Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),
                                subtitle: Text("${snapshot.data!.businessName}",style: TextStyle(fontWeight: FontWeight.w300),),
                                trailing: InkWell(
                                  onTap: (){

                                  },
                                  child: CircleAvatar(
                                    backgroundColor: primaryColor,
                                    child: Icon(Icons.message,color: Colors.white,),
                                  ),
                                ),
                              );

                            }
                          }
                        }
                    ),


                    SizedBox(height: 20,),
                    Text("Status",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    SizedBox(height: 5,),
                    Text("${widget.order.status}",style: TextStyle(fontWeight: FontWeight.w300),),
                    SizedBox(height: 20,),
                    Text("Delivery",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    SizedBox(height: 5,),
                    Text("${widget.order.date}  ${widget.order.time}",style: TextStyle(fontWeight: FontWeight.w300),),

                    SizedBox(height: 20,),
                    CountdownTimer(
                      endTime: widget.order.dateTime,
                      widgetBuilder: (_, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text('Game over');
                        }
                        return Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("DAYS",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                    SizedBox(height: 10,),
                                    Text(time.days==null?"0":time.days.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.white),),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("HOURS",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                    SizedBox(height: 10,),
                                    Text(time.hours==null?"0":time.hours.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.white),),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("MINUTES",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                    SizedBox(height: 10,),
                                    Text(time.min==null?"0":time.min.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20,),
                    Text("Actions",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    SizedBox(height: 5,),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.block,color: Colors.redAccent,),
                                    SizedBox(height: 5,),
                                    Text("CANCEL",style: TextStyle(fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle_outline,color: Colors.green,),
                                    SizedBox(height: 5,),
                                    Text("COMPLETE",style: TextStyle(fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error_outline,color: Colors.orange,),
                                    SizedBox(height: 5,),
                                    Text("REPORT",style: TextStyle(fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

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
