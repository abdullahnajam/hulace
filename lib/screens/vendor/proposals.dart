import 'package:flutter/material.dart';
import 'package:hulace/widgets/custom_appbar.dart';

import '../../utils/constants.dart';

class Proposals extends StatefulWidget {
  const Proposals({Key? key}) : super(key: key);

  @override
  _ProposalsState createState() => _ProposalsState();
}

class _ProposalsState extends State<Proposals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("Proposals",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              DefaultTabController(
                  length: 2,
                  child:Column(
                    children: [
                      Container(
                        padding : EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height*0.07,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: primaryColor,
                          indicator : BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                          ),
                          /*indicator:  UnderlineTabIndicator(
                            borderSide: BorderSide(width: 0.0,color: Colors.white),
                            insets: EdgeInsets.symmetric(horizontal:16.0)
                        ),*/

                          tabs: [
                            Tab(text: 'Active'),
                            Tab(text: 'Expired'),
                          ],
                        ),

                      ),

                      Container(
                        height: MediaQuery.of(context).size.height*0.7,

                        child: TabBarView(children: <Widget>[
                          ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index){
                              return Card(
                                child: ListTile(
                                  leading: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/person.png")
                                        )
                                    ),
                                  ),
                                  title: Text("Need a Wedding Planner"),
                                  subtitle: Text("Sended 10 mins ago",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                                  trailing: Text("View",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index){
                              return Card(
                                child: ListTile(
                                  leading: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/person.png")
                                        )
                                    ),
                                  ),
                                  title: Text("Need a Wedding Planner"),
                                  subtitle: Text("Sended 10 mins ago",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                                  trailing: Text("View",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              );
                            },
                          ),


                        ]),
                      )

                    ],

                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
