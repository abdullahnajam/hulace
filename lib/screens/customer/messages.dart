import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/utils/constants.dart';

class UserChatList extends StatefulWidget {
  const UserChatList({Key? key}) : super(key: key);

  @override
  _UserChatListState createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Messages",style: TextStyle(fontSize: 20,color: primaryColor,fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Image.asset("assets/images/new.png"),
                          SizedBox(width: 5,),
                          Text("You have 2 new messages",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300))
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.chat,color: Colors.white,size: 20,),
                    ),
                  ),




                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/person.png"),
                            )
                        ),
                      ),
                      title:Text("Devon Lane",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                      subtitle: Text("Hi Julian! See you after work?",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                      trailing: Text("now",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.grey),),

                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
