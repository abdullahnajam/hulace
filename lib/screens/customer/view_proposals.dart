import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/model/proposal_model.dart';
import 'package:hulace/model/request_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../api/payment_service.dart';
import '../../model/users.dart';
import '../../api/firebase_apis.dart';
import '../../utils/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class ViewProposals extends StatefulWidget {
  RequestModel request;

  ViewProposals(this.request);

  @override
  _ViewProposalsState createState() => _ViewProposalsState();
}

class _ViewProposalsState extends State<ViewProposals> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.15,
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

                SizedBox(height: 10,),

              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height*0.07,
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
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
                      Text("Status",style: TextStyle(color: Colors.white),),
                      Text(widget.request.status,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                    ],
                  ),
                  VerticalDivider(color: secondaryColor),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Offers",style: TextStyle(color:Colors.white),),
                      Text("0",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                    ],
                  ),
                  VerticalDivider(color: secondaryColor,width: 2,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Budget",style: TextStyle(color:Colors.white)),
                      Text("\$${widget.request.budget}",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white))
                    ],
                  ),
                ],
              )
          ),
          Expanded(
            //height: MediaQuery.of(context).size.height*0.65,
            //width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('proposals')
                    .where("requestId",isEqualTo: widget.request.id)
                    .snapshots(),
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
                      child: Text("No Offers"),
                    );
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      ProposalModel model=ProposalModel.fromMap(data,document.reference.id);
                      return InkWell(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AttemptedTest(model)));

                          },
                          child: Card(
                            margin: EdgeInsets.only(bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<UserModel>(
                                    future: getUserData(model.vendorId),
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
                                            child: Text("rror ${snapshot.error}"),
                                          );
                                        }


                                        else {
                                          return ListTile(
                                            leading: snapshot.data!.profilePic==""?
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
                                            ):
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(snapshot.data!.profilePic),
                                                      fit: BoxFit.cover
                                                  )
                                              ),
                                            ),
                                            title: Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),
                                            subtitle: Text("\$${model.cost}",style: TextStyle(color: primaryColor),),
                                            trailing: Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(model.createdAt)),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 12),)

                                          );

                                        }
                                      }
                                    }
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(model.cover),
                                ),
                                InkWell(
                                  onTap: ()async{
                                    DatePicker.showDateTimePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime.now(),
                                        maxTime: DateTime(2100, 6, 7),
                                        onChanged: (date) {
                                          print('change $date');
                                        },
                                        onConfirm: (date) async{
                                          print('confirmed $date');
                                          CoolAlert.show(
                                              context: context,
                                              type: CoolAlertType.confirm,
                                              text: "Are you sure you want to place the order?",
                                              onConfirmBtnTap: ()async{
                                                PaymentService _payment=PaymentService();
                                                Navigator.pop(context);
                                                _payment.payment(model.cost).then((value)async{
                                                  await FirebaseFirestore.instance.collection('orders').add({
                                                    "vendorId":model.vendorId,
                                                    "customerId":FirebaseAuth.instance.currentUser!.uid,
                                                    "budget":model.cost,
                                                    "status":"In Progress",
                                                    "category":"",
                                                    "date": df.format(date),
                                                    "time": tf.format(date),
                                                    "packageId": model.id,
                                                    "paymentStatus": "Paid",
                                                    "isRated": false,
                                                    "rating": 0,
                                                    "dateTime":date.millisecondsSinceEpoch,
                                                    "createdAt":DateTime.now().millisecondsSinceEpoch,

                                                  }).then((val)async{
                                                    FirebaseFirestore.instance.collection('proposals').doc(model.id).update({
                                                      "status":"Ordered"
                                                    });
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
                                                    Navigator.pop(context);
                                                    CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.error,
                                                      text: error.toString(),
                                                    );
                                                  });
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
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text("Place Order",style: TextStyle(color: Colors.white)),
                                  ),
                                )

                              ],
                            ),
                          )
                      );
                    }).toList(),
                  );
                },
              ),

            ),
          )
        ],
      ),
    );
  }
}
