import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/vendor/job_detail.dart';
import 'package:hulace/screens/navigators/vendor_drawer.dart';
import 'package:hulace/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/notifications.dart';

import '../../model/category_model.dart';
import '../../model/request_model.dart';
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
  int selectedCategoryIndex=0;
  String selectedCategory="All Categories";
  Future<List<CategoryModel>> getCategories()async{
    CategoryModel cat=CategoryModel("",'All Categories');
    List<CategoryModel> categories=[cat];
    await FirebaseFirestore.instance.collection('categories').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        CategoryModel model=CategoryModel.fromMap(data, doc.reference.id);
        categories.add(model);
      });
    });
    return categories;
  }

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
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top:20,left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category Events",style: TextStyle(fontSize:18,fontWeight: FontWeight.w500),),
                        //Text("View All",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  FutureBuilder<List<CategoryModel>>(
                      future: getCategories(),
                      builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            child: Text("-",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300)),
                          );
                        }
                        else {
                          if (snapshot.hasError) {
                            print("error ${snapshot.error}");
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }
                          else if(snapshot.data!.isEmpty){
                            return const Center(
                              child: Text("No Categories"),
                            );
                          }

                          else {

                            return Container(
                              height: 50,
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,int index){
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: FilterChip(
                                      label: Text(snapshot.data![index].name,style: TextStyle(color: selectedCategoryIndex==index?Colors.white:Colors.black,),),
                                      backgroundColor: selectedCategoryIndex==index?primaryColor:Colors.white,

                                      onSelected: (bool value) {
                                        setState(() {
                                          selectedCategoryIndex=index;
                                          selectedCategory=snapshot.data![index].name;
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }
                      }
                  ),
                 /* Padding(
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
                  ),*/
                  selectedCategory=='All Categories'?
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('requests').snapshots(),
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
                            child: Text("No Requests"),
                          );
                        }

                        return ListView(
                          padding: EdgeInsets.only(top: 10),

                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            RequestModel model=RequestModel.fromMap(data,document.reference.id);
                            return Job(model);
                          }).toList(),
                        );
                      },
                    ),
                  )
                  :
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('requests')
                          .where('category',isEqualTo:selectedCategory).snapshots(),
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
                            child: Text("No Requests"),
                          );
                        }

                        return ListView(
                          padding: EdgeInsets.only(top: 10),

                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            RequestModel model=RequestModel.fromMap(data,document.reference.id);
                            return Job(model);
                          }).toList(),
                        );
                      },
                    ),
                  ),


                ],
              ),
            ),
          )

        ],
      ),
    );
  }
  Widget Job(RequestModel model){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetail(model)));

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(model.title,style: TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 15),),
                            Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(model.createdAt)),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 12),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(model.description,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 12),),


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
                        Text(model.budget,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                      ],
                    ),
                    VerticalDivider(color: secondaryColor),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Category",style: TextStyle(color:Colors.white),),
                        Text(model.category,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                      ],
                    ),
                    VerticalDivider(color: secondaryColor,width: 2,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Date",style: TextStyle(color:Colors.white)),
                        Text(model.date,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white))
                      ],
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}


