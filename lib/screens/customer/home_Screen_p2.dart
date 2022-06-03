import 'package:flutter/material.dart';

class HomeScreenP extends StatefulWidget {
  const HomeScreenP({Key? key}) : super(key: key);

  @override
  _HomeScreenPState createState() => _HomeScreenPState();
}

const primaryColor=Color(0xff502e2d);


class _HomeScreenPState extends State<HomeScreenP> {


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

              SizedBox(
                height: height*0.03
              ),
              Row(

                children: [
                  Container(
                    width: width*0.7,
                    height:  MediaQuery.of(context).size.height*0.07,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*0.05,
                        right: MediaQuery.of(context).size.width*0.03
                    ),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              SizedBox(width: 10,),
                              Text('Search here ... ',style: TextStyle(color: Colors.grey,),),
                            ],
                          ),
                        ),
                      ],

                    ),
                  ),
                  Container(
                    width: width*0.15,
                    height:  MediaQuery.of(context).size.height*0.07,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Icon(Icons.search,color: Colors.white,size: 30,),

                  ),

                ],
              ),


              SizedBox(
                  height: height*0.03
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Last Search",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text("Delete all",style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey
                    ),),
                  )

                ],
              ),


              ListView.builder(

              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context,int index){

                return Padding(
                  padding: const EdgeInsets.fromLTRB(8,4,0,4),
                  child: Row(
                    children: [

                      Expanded(
                      flex: 15,
                      child: Icon(Icons.access_time,color: Colors.grey,)),

                      Expanded(
                        flex: 70,
                        child: Text("Event Export",style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),),),

                      Expanded(
                          flex: 15,
                          child: Text("x",style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey
                          ),)),
                    ],
                  ),
                );
              }

          ),


              SizedBox(
                  height: height*0.02
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Categories",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  ),),
                ),
              ),

              ListView.builder(

                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext context,int index){

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8,4,0,4),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/vase.png",height: height*0.07,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Decoration",style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                      ),),

                                        Text("Adispiscing nam sapien proin velit sit.",style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey
                                      ),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height*0.005,
                            ),
                            Divider(
                              endIndent: 0,
                              indent: 0,
                              thickness: 2,
                              color: Colors.grey,
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
      ),
    );
  }
}
