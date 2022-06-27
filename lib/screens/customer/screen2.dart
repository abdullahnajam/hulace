import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}



class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var margin=MediaQuery.of(context).size.width*0.04;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height:height*0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 15,
                    child: Icon(Icons.arrow_back,color: Colors.black,size: 30,),
                  ),
                  Expanded(
                    flex: 85,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height*0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.black)
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Search here...",style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),),
                          ),
                        ),

                      ),
                    ),
                  ),

                ],
              ),

              Expanded(
                child: DefaultTabController(
                    length: 2,
                    child:Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(margin),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xffDCDCDC))
                          ),
                          child: TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: primaryColor,
                            indicatorColor: primaryColor,
                            /*indicator : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),*/
                            /*indicator:  UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.0,color: Colors.white),
                          insets: EdgeInsets.symmetric(horizontal:16.0)
                      ),*/

                            tabs: [
                              Tab(text: 'Gigs'),
                              Tab(text: 'Vendors'),
                            ],
                          ),

                        ),

                        Container(
                          //height of TabBarView
                          height: MediaQuery.of(context).size.height*0.72,

                          child: TabBarView(children: <Widget>[

                            Container(
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Recently Viewed",style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                    ),),
                                  ),


                                  ListView.builder(

                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount: 4,
                                      itemBuilder: (BuildContext context,int index){

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height*0.2,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                            ),

                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Image.asset("assets/images/person.png"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Text("I will be your event manager \n of your wedding event",style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                        color: Colors.black
                                                      )),

                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage: AssetImage("assets/images/emptyProfile.png"),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("robertFox",style:TextStyle(
                                                                color :Colors.black,
                                                              )),
                                                            )
                                                          ],
                                                        ),
                                                      ),


                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text("STARTING AT 500\$",style: TextStyle(
                                                          color :Colors.red.shade800,
                                                        ),),
                                                      )

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }

                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Recently Viewed",style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                    ),),
                                  ),


                                  ListView.builder(

                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount: 4,
                                      itemBuilder: (BuildContext context,int index){

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 20 ,
                                                  child: CircleAvatar(
                                                    backgroundImage: AssetImage("assets/images/emptyProfile.png"),
                                                    radius: 30,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex:60,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Willam Jones",style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),),
                                                        Text("Wedding Planner",style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 20,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 20),
                                                    child: Container(
                                                      width: width*0.05,
                                                      height:  MediaQuery.of(context).size.height*0.05,
                                                      decoration: BoxDecoration(
                                                        color: primaryColor,
                                                        borderRadius: BorderRadius.circular(10),

                                                      ),
                                                      child: Icon(Icons.navigate_next_outlined,color: Colors.white,size: 30,),

                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }

                                  ),
                                ],
                              ),
                            ),
                          ]),
                        )

                      ],

                    )
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
