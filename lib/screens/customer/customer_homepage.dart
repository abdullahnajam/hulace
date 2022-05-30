import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/notifications.dart';

import '../../utils/constants.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({Key? key}) : super(key: key);

  @override
  _CustomerHomepageState createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  String dropdownValue="Trending";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        elevation: 3,
                        child: Row(
                          children: [
                            SizedBox(width: 5,),
                            Icon(Icons.search),
                            SizedBox(width: 5,),
                            Text("Search")
                          ],
                        ),
                      ),
                    ),
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
                            child: Icon(Icons.notifications_none,color: primaryColor,),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("News Feed",style: TextStyle(fontSize:18,color: primaryColor),),
                  SizedBox(height: 10,),
                  Container(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context,int index){
                        return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: primaryColor,width: 1),
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/event.png"),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("Event",textAlign: TextAlign.center,style: TextStyle(fontSize:14,fontWeight: FontWeight.w300),),

                                ],
                              ),
                            )
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down),
                elevation: 16,
                style: const TextStyle(fontSize:18,color: primaryColor),
                underline: Container(

                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Trending']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                              child: Text("Sports Event",style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/person.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("John Doe",style: TextStyle(),),
                                Text("3 Days Ago",style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child:Text("Wanna play futsal next week. Let's connect? Join my event.",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),

                      ),

                      SizedBox(height: 10,),
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
                                  Text("  25.5.22",style: TextStyle(fontWeight: FontWeight.w300)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,size: 15,color: Colors.grey,),
                                  Text("  town",style: TextStyle(fontWeight: FontWeight.w300)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time_rounded,size: 15,color: Colors.grey,),
                                  Text("  2 hr",style: TextStyle(fontWeight: FontWeight.w300)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.people_outline,size: 15,color: Colors.grey,),
                                  Text("  30",style: TextStyle(fontWeight: FontWeight.w300)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
