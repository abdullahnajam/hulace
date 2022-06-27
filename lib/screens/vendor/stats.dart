import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'job_detail.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var margin=MediaQuery.of(context).size.width*0.04;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
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
                            Navigator.pop(context);
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
                                    child:  Icon(Icons.arrow_back,color: primaryColor,)
                                )
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                  Container(

                      height: MediaQuery.of(context).size.height*0.08,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(
                            10
                          )
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("\$",style: TextStyle(color: Colors.white),),
                              Text("EM5000",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
                            ],
                          ),
                          VerticalDivider(color: secondaryColor),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Category",style: TextStyle(color:Colors.white),),
                              Text("Sports",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white),)
                            ],
                          ),
                          VerticalDivider(color: secondaryColor,width: 2,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Date",style: TextStyle(color:Colors.white)),
                              Text("18/05/2022",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white))
                            ],
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            //height: MediaQuery.of(context).size.height*0.65,
            //width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.fromLTRB(10,10,10,0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              child: DefaultTabController(
                  length: 2,
                  child:Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                        ),
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: primaryColor,
                          indicatorColor: primaryColor,
                          padding: EdgeInsets.all(5),
                          indicator : BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor,
                              ),
                          /*indicator:  UnderlineTabIndicator(
                            borderSide: BorderSide(width: 0.0,color: Colors.white),
                            insets: EdgeInsets.symmetric(horizontal:16.0)
                        ),*/

                          tabs: [
                            Tab(text: 'ORDERS'),
                            Tab(text: 'REVIEWS'),
                          ],
                        ),

                      ),

                      Container(
                        //height of TabBarView
                        height: MediaQuery.of(context).size.height*0.63,

                        child: TabBarView(children: <Widget>[

                          ListView.builder(
                            padding: EdgeInsets.only(top: 10),
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
                                          Text("COMPLETED",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 12),)
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
                          ListView.builder(
                            itemCount: 3,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context,int index){
                              return InkWell(
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [

                                          Row(
                                            children: [
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                              Icon(Icons.star,size: 14,),
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Text("$loremIpsum $loremIpsum",textAlign: TextAlign.justify,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),

                                          ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: AssetImage("assets/images/profile.png",),
                                                      fit: BoxFit.cover
                                                  )
                                              ),

                                            ),
                                            title: Text("CINDY A",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                                            subtitle: Text("Jun 2, 2022",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),),
                                          ),
                                        ],
                                      )
                                  )
                              );
                            },
                          ),



                        ]),
                      )

                    ],

                  )
              ),
            ),
          )

        ],
      ),
    );
  }
}
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

