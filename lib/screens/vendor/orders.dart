import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("Manage Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              DefaultTabController(
                  length: 3,
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
                            Tab(text: 'Cancelled'),
                            Tab(text: 'Completed'),
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

                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Row(
                                           children: [
                                             Container(
                                               height: 50,
                                               width: 50,
                                               decoration: BoxDecoration(
                                                   border: Border.all(color: primaryColor),
                                                   shape: BoxShape.circle,
                                                   image: DecorationImage(
                                                       image: AssetImage("assets/images/person.png")
                                                   )
                                               ),
                                             ),
                                             SizedBox(width: 10,),
                                             Text("William Jones",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),)

                                           ],
                                         ),
                                         Container(
                                           decoration: BoxDecoration(
                                             color: primaryColor,
                                             borderRadius: BorderRadius.circular(5)
                                           ),
                                           padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                           alignment: Alignment.center,
                                           child: Text("\$300",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 13),),
                                         )
                                       ],
                                     ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.access_time_rounded),
                                              SizedBox(width: 5,),
                                              Text("1/6/2022")
                                            ],
                                          ),
                                          Text("Running",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w400,fontSize: 13),),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index){
                              return Card(

                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: primaryColor),
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/images/person.png")
                                                      )
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Text("William Jones",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),)

                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                              alignment: Alignment.center,
                                              child: Text("\$300",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 13),),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.access_time_rounded),
                                                SizedBox(width: 5,),
                                                Text("1/6/2022")
                                              ],
                                            ),
                                            Text("Running",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w400,fontSize: 13),),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index){
                              return Card(

                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: primaryColor),
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/images/person.png")
                                                      )
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Text("William Jones",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),)

                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                              alignment: Alignment.center,
                                              child: Text("\$300",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 13),),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.access_time_rounded),
                                                SizedBox(width: 5,),
                                                Text("1/6/2022")
                                              ],
                                            ),
                                            Text("Running",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w400,fontSize: 13),),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
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
