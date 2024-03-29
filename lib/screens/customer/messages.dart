import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/chat_screen.dart';
import 'package:hulace/screens/navigators/vendor_drawer.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/widgets/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../../model/chat_head_model.dart';
import '../../model/users.dart';
import '../../provider/UserDataProvider.dart';
import '../../api/firebase_apis.dart';
import '../navigators/customer_drawer.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
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
                        child: Image.asset("assets/images/menu.png",color: Colors.white,height: 40,),
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
                          child: Icon(Icons.search,color: whiteColor,),
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('chat_head').snapshots(),
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
                      child: Text("No Chats"),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.only(top: 10),

                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      ChatHeadModel model=ChatHeadModel.fromMap(data,document.reference.id);
                      return ChatHead(model);
                    }).toList(),
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget ChatHead(ChatHeadModel model){
    return InkWell(
      onTap: (){
        final provider = Provider.of<UserDataProvider>(context, listen: false);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(provider.userData!.type, model.vendorId==FirebaseAuth.instance.currentUser!.uid?model.customerId:model.vendorId)));

      },
      child: Card(
        margin: EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: 10,),
            FutureBuilder<UserModel>(
                future: getUserData(model.vendorId==FirebaseAuth.instance.currentUser!.uid?model.customerId:model.vendorId),
                builder: (context, AsyncSnapshot<UserModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      leading: ProfilePicture(""),
                      title: Text("-",style: TextStyle(fontWeight: FontWeight.w500),),
                      subtitle:  Text(model.lastMessage,style: TextStyle(fontWeight: FontWeight.w300),),

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
                      return  ListTile(
                        leading: ProfilePicture(snapshot.data!.profilePic),
                        title: Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),
                        subtitle:  Text(model.lastMessage,style: TextStyle(fontWeight: FontWeight.w300),),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(format(DateTime.fromMillisecondsSinceEpoch(model.timestamp)),style: TextStyle(fontSize:10,fontWeight: FontWeight.w300),),
                            SizedBox(height: 5,),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: primaryColor,
                              child: Text("2",style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),
                            )
                          ],
                        ),
                      );

                    }
                  }
                }
            ),

            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
