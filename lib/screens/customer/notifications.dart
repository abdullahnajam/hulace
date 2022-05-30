import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/utils/constants.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({Key? key}) : super(key: key);

  @override
  _UserNotificationsState createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(7),
                      child: Icon(Icons.arrow_back_ios_sharp,size: 15,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.notifications,color: primaryColor,),
                  SizedBox(width: 5,),
                  Text("Notifications",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),


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
                      title:Text("Ali Ahmed Started Following You",style: TextStyle(fontSize: 13),),
                      trailing: Text("3 mins ago",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),

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
