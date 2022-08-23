import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/model/event_model.dart';
import 'package:hulace/screens/customer/event_detail.dart';
import 'package:hulace/screens/customer/notifications.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../model/category_model.dart';
import '../../model/users.dart';
import '../../utils/apis.dart';
import '../../utils/constants.dart';
import '../navigators/customer_drawer.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({Key? key}) : super(key: key);

  @override
  _CustomerHomepageState createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
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
                        child: Image.asset("assets/images/menu.png",color: bgColor,height: 40,),
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
                            child: Icon(Icons.search,color: bgColor,),
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
                /*padding: EdgeInsets.zero,
                shrinkWrap: true,*/
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
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
                  selectedCategory=="All Categories"?
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('events').snapshots(),
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
                          //physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            EventModel model=EventModel.fromMap(data,document.reference.id);
                            return Event(model);
                          }).toList(),
                        );
                      },
                    ),
                  )
                  :
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('events')
                          .where("category",isEqualTo:selectedCategory).snapshots(),
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
                          //physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            EventModel model=EventModel.fromMap(data,document.reference.id);
                            return Event(model);
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
                padding: const EdgeInsets.only(right: 10,top: 10),
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

                        Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(model.createdAt)),style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),
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
