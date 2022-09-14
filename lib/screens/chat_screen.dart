import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/model/messages_model.dart';
import 'package:hulace/model/users.dart';
import 'package:hulace/provider/ChatProvider.dart';
import 'package:hulace/widgets/profile_image.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../api/firebase_apis.dart';
import '../provider/UserDataProvider.dart';
import '../utils/constants.dart';

class ChatScreen extends StatefulWidget {
  String type,recieverId;

  ChatScreen(this.type, this.recieverId);

  @override
  State<ChatScreen> createState() => _IndividualChatState();
}

class _IndividualChatState extends State<ChatScreen> {
  String customerId="";
  String vendorId="";
  final TextEditingController inputController = new TextEditingController();
  ScrollController controller = new ScrollController();
  @override
  void initState() {
    super.initState();
    if(widget.type=="Vendor"){
      customerId=widget.recieverId;
      vendorId=FirebaseAuth.instance.currentUser!.uid;
    }
    else{
      vendorId=widget.recieverId;
      customerId=FirebaseAuth.instance.currentUser!.uid;

    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(

      body:  SafeArea(
        child: Container(
          width: double.infinity, height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                color: primaryColor,
                child: Row(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            child: Icon(Icons.arrow_back,color: Colors.white,)
                          ),
                        ),
                        SizedBox(width: 20,),
                        FutureBuilder<UserModel>(
                            future: getUserData(vendorId==FirebaseAuth.instance.currentUser!.uid?customerId:vendorId),
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
                                  return Row(
                                    children: [
                                      ProfilePicture(snapshot.data!.profilePic),
                                      SizedBox(width: 10,),
                                      Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500),),
                                    ],
                                  );

                                }
                              }
                            }
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child:  StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('messages')
                      .where("headId",isEqualTo: "${customerId}-${vendorId}").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      controller.jumpTo(controller.position.maxScrollExtent);
                    }

                    if (snapshot.data!.size==0) {
                      return Center(
                        child: Text("No Messages"),
                      );
                    }

                    return ListView(
                      padding: EdgeInsets.only(top: 10),
                      controller: controller,
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        MessagesModel model=MessagesModel.fromMap(data,document.reference.id);
                        return buildListItemView(model);
                      }).toList(),
                    );
                  },
                ),
              ),
              Consumer<ChatProvider>(
                builder: (context, sender, child){
                  return Container(
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 5,),
                        Expanded(
                          child: TextField(
                            controller: inputController,
                            maxLines: 1, minLines: 1,
                            keyboardType: TextInputType.multiline,
                            decoration:const InputDecoration.collapsed(
                                hintText: 'Message'
                            ),
                            onChanged: (value){
                              if(value.isEmpty){
                                sender.setShowSend(false);
                              }
                              else{
                                sender.setShowSend(true);
                              }

                            },

                          ),
                        ),

                        //IconButton(icon: Icon(Icons.attach_file, color: Colors.blueGrey.shade200), onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.send, color: Colors.blue),
                            onPressed: () {
                              if(sender.showSend)
                                sendMessage(vendorId==FirebaseAuth.instance.currentUser!.uid?customerId:vendorId);
                            }
                        ),
                      ],
                    ),
                  );
                },
              )
              //InputArea()
            ],
          ),
        ),
      ),
    );
  }

  void onItemClick(int index, String obj) { }

  void sendMessage(recieverId)async{
    String message = inputController.text;
    inputController.clear();
    context.read<ChatProvider>().setShowSend(false);
    await FirebaseFirestore.instance.collection('messages').add({
      "senderId":FirebaseAuth.instance.currentUser!.uid,
      "mediaType":"Text",
      "recieverId":recieverId,
      "headId":"$customerId-$vendorId",
      "message":message,
      "isRead":false,
      "sentAt":DateTime.now().millisecondsSinceEpoch,
    });
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  Widget buildListItemView(MessagesModel item){
    bool isMe = item.senderId==FirebaseAuth.instance.currentUser!.uid?true:false;
    return Wrap(
      alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
      children: <Widget>[

        Card(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5),),
            margin: EdgeInsets.fromLTRB(isMe ? 20 : 10, 5, isMe ? 10 : 20, 5),
            color: isMe ? Color(0xffEFFFDE) : Colors.white, elevation: 1,
            child : Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(minWidth: 150),
                    child: Text(item.message, style: TextStyle(
                        color: Colors.black)
                    ),
                  ),
                  Container(height: 3, width: 0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(format(DateTime.fromMillisecondsSinceEpoch(item.sentAt)), textAlign: TextAlign.end, style: TextStyle(fontSize: 12, color: isMe ? Color(0xff58B346) : Colors.blueGrey.shade200)),
                      Container(width: 3),
                    ],
                  )
                ],
              ),
            )
        ),
        
      ],
    );
  }


}

