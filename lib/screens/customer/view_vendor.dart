import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hulace/utils/constants.dart';

class ViewVendor extends StatefulWidget {
  const ViewVendor({Key? key}) : super(key: key);

  @override
  _ViewVendorState createState() => _ViewVendorState();
}

class _ViewVendorState extends State<ViewVendor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.35,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("assets/images/event1.png"),
                      fit: BoxFit.cover
                  )
              ),
              alignment: Alignment.topCenter,
              child: Padding(
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

                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserNotifications()));
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
                                child:  Icon(Icons.favorite_border,color: primaryColor,)
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: bgColor,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                ),
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(2),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
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

                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                        height: MediaQuery.of(context).size.height*0.07,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Rating",style: TextStyle(color: Colors.white),),
                                Text("4.8",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),)
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
                                Text("Orders",style: TextStyle(color:Colors.white)),
                                Text("67",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color:Colors.white))
                              ],
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    Text("Description",style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 4,),
                    Text("$loremIpsum $loremIpsum $loremIpsum $loremIpsum",style: TextStyle(fontWeight: FontWeight.w300),),
                    SizedBox(height: 20,),

                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("Custom Offer",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              alignment: Alignment.center,
                              child: Text("Place Order"),
                            )
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
