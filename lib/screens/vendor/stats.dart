import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/model/rating_model.dart';
import 'package:hulace/model/review_model.dart';
import 'package:provider/provider.dart';

import '../../model/order_model.dart';
import '../../model/package_model.dart';
import '../../model/users.dart';
import '../../provider/UserDataProvider.dart';
import '../../api/firebase_apis.dart';
import '../../utils/constants.dart';
import '../../widgets/profile_image.dart';
import 'job_detail.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: secondaryColor,

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
                  Container(

                      height: MediaQuery.of(context).size.height*0.08,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(
                            10
                          )
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Balance",style: TextStyle(color: Colors.white),),
                              Text("EM${provider.userData!.balance}",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                            ],
                          ),
                          VerticalDivider(color: secondaryColor),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Category",style: TextStyle(color:Colors.white),),
                              Text(provider.userData!.businessCategory,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                            ],
                          ),
                          VerticalDivider(color: secondaryColor,width: 2,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Rating",style: TextStyle(color:Colors.white)),
                              FutureBuilder<RatingModel>(
                                  future: getRating(provider.userData!.userId),
                                  builder: (context, AsyncSnapshot<RatingModel> snapshot) {
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
                                        return Text("${snapshot.data!.rating} (${snapshot.data!.totalRatings})",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white));

                                      }
                                    }
                                  }
                              ),

                            ],
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            //height: MediaQuery.of(context).size.height*0.65,
            //width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.fromLTRB(10,10,10,0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              child: DefaultTabController(
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
                          unselectedLabelColor: primaryColor,
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
                            Tab(text: 'ORDERS'),
                            Tab(text: 'REVIEWS'),
                          ],
                        ),

                      ),

                      Container(
                        //height of TabBarView
                        height: MediaQuery.of(context).size.height*0.63,

                        child: TabBarView(children: <Widget>[
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('orders')
                                .where("vendorId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                .where("status",isEqualTo: "Completed").snapshots(),
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
                                  child: Text("No Completed Orders"),
                                );
                              }

                              return ListView(
                                padding: EdgeInsets.only(top: 10),

                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                  OrderModel model=OrderModel.fromMap(data,document.reference.id);
                                  return Card(
                                    margin: EdgeInsets.only(bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ProfilePicture(provider.userData!.profilePic),
                                                  SizedBox(width: 7,),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("${provider.userData!.firstName} ${provider.userData!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),
                                                        Text(model.category,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                              Text(model.status,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 12),)
                                            ],
                                          ),
                                        ),
                                        FutureBuilder<PackageModel>(
                                            future: getPackageData(model.packageId),
                                            builder: (context, AsyncSnapshot<PackageModel> snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Text("-",textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w400),),
                                                    )
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
                                                  return Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(snapshot.data!.title,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w400),),
                                                  );

                                                }
                                              }
                                            }
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(color: Colors.grey,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${model.date} ${model.time}",style: TextStyle(fontWeight: FontWeight.w500),),
                                              Text("KM${model.budget}",style: TextStyle(fontWeight: FontWeight.w500),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),

                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('reviews')
                                .where("vendorId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
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
                                  child: Text("No Reviews"),
                                );
                              }

                              return ListView(
                                padding: EdgeInsets.only(top: 10),

                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                  ReviewModel model=ReviewModel.fromMap(data,document.reference.id);
                                  return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [

                                          Row(
                                            children: [
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Text("${model.review}",textAlign: TextAlign.justify,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
                                          FutureBuilder<UserModel>(
                                              future: getUserData(model.customerId),
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
                                                      subtitle: Text(df.format(DateTime.fromMillisecondsSinceEpoch(model.createdAt)),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                                                    );

                                                  }
                                                }
                                              }
                                          ),

                                        ],
                                      )
                                  );
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
    );
  }
}
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

