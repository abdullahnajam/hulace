import 'package:flutter/material.dart';
import 'package:hulace/screens/vendor/job_detail.dart';
import 'package:hulace/screens/vendor/vendor_drawer.dart';
import 'package:hulace/utils/constants.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: VendorDrawer(),
      key: _drawerKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      _openDrawer();
                    },
                    child: Image.asset("assets/images/square.png",height: 30,),
                  ),
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

                ],
              ),
              Text("Hi, William Jones !",style: TextStyle(color: primaryColor,fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(
                height: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
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
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext context,int index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetail()));

                      },
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/person.png")
                                  )
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Need a Wedding Planner",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 15),),
                                        Text("2 min ago",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 12),)
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 12),),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Icon(Icons.payments_outlined,size: 18,),
                                        SizedBox(width: 3,),
                                        Text("\$500",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                                        SizedBox(width: 20,),
                                        Icon(Icons.calendar_today_outlined,size: 18,),
                                        SizedBox(width: 3,),
                                        Text("18/05/2022",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),)
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
