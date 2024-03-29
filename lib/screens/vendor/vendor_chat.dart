import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/utils/constants.dart';

import '../navigators/customer_drawer.dart';

class VendorChat extends StatefulWidget {
  const VendorChat({Key? key}) : super(key: key);

  @override
  _VendorChatState createState() => _VendorChatState();
}

class _VendorChatState extends State<VendorChat> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
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
                                  child:  Icon(Icons.chat,color: primaryColor,)
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
                              hintText: 'Find Chat',
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
                  borderRadius: BorderRadius.circular(20)
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
                      children: [
                        SizedBox(height: 10,),
                        ListTile(
                          leading: Container(
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
                          title: Text("Kim Joyce",style: TextStyle(fontWeight: FontWeight.w500),),
                          subtitle:  Text("Lorem ipsum dolor sit amet",style: TextStyle(fontWeight: FontWeight.w300),),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("2 min ago",style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),
                              SizedBox(height: 5,),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: primaryColor,
                                child: Text("2",style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
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
