import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/navigators/vendor_drawer.dart';

import '../../utils/constants.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: VendorDrawer(),
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.25,
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
                              hintText: 'Find Your Order',
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
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context,int index){
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
                                  Container(
                                    margin: EdgeInsets.all(2),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                        Text("Kim Joyce",style: TextStyle(fontWeight: FontWeight.w500),),
                                        Text("Category",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text("PENDING",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 12),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Here will be the gig description provided by vendor",textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w400),),
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
                              Text("6/6/2022",style: TextStyle(fontWeight: FontWeight.w500),),
                              Text("\$200",style: TextStyle(fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                      ],
                    ),
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
