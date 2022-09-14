import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hulace/model/category_model.dart';
import 'package:hulace/model/package_model.dart';
import 'package:hulace/screens/customer/view_vendor.dart';

import '../../api/firebase_apis.dart';
import '../../model/event_model.dart';
import '../../model/users.dart';
import '../../utils/constants.dart';
import '../navigators/customer_drawer.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  int selectedCategoryIndex=0;
  String selectedCategory="All Categories";
  Future<List<CategoryModel>> getCategories()async{
    CategoryModel cat=CategoryModel("",'All Categories',"",primaryColor.value);
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
      key: _drawerKey,
      drawer: CustomerDrawer(),
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.22,
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
                          _openDrawer();
                        },
                        child: Image.asset("assets/images/menu.png",color: bgColor,height: 40,),
                      ),


                      InkWell(
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
                                  child:  Icon(Icons.location_on_outlined,color: primaryColor,)
                              )
                          ),
                        ),
                      ),
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
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.5
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0.5,
                                ),
                              ),
                              hintText: 'Find Vendors',
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
                  SizedBox(height: 20,),
                  FutureBuilder<List<CategoryModel>>(
                      future: getServices(),
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
                      stream: FirebaseFirestore.instance.collection('users').where("type",isEqualTo:"Vendor").snapshots(),
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
                            child: Text("No Vendors"),
                          );
                        }

                        return ListView(
                          //physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            UserModel model=UserModel.fromMap(data,document.reference.id);
                            return Vendors(model);
                          }).toList(),
                        );
                      },
                    ),
                  )
                      :
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('users')
                          .where("businessCategory",isEqualTo:selectedCategory)
                          .where("type",isEqualTo:"Vendor").snapshots(),
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
                            child: Text("No Vendors"),
                          );
                        }

                        return ListView(
                          //physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            UserModel model=UserModel.fromMap(data,document.reference.id);
                            return Vendors(model);
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
  Widget Vendors(UserModel model){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewVendor(model)));

      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10,),
            ListTile(
              leading: model.profilePic==""?
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

              ):
              Container(
                margin: EdgeInsets.all(2),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(model.profilePic),
                        fit: BoxFit.cover
                    )

                ),

              ),
              title: Text("${model.firstName} ${model.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),
              subtitle: Text("${model.businessName}",style: TextStyle(fontWeight: FontWeight.w300),),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
              ),
              child:  FutureBuilder<String>(
                  future: getPackages(model.userId),
                  builder: (context, AsyncSnapshot<String> snapshot) {
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


                      else {

                        return Text(snapshot.data!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),);
                      }
                    }
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
