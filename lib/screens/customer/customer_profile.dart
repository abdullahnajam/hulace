import 'package:flutter/material.dart';
import 'package:hulace/splash.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/widgets/custom_appbar.dart';

import '../navigators/customer_drawer.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: CustomerDrawer(),
      backgroundColor: secondaryColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: secondaryColor,

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
                          _openDrawer();
                        },
                        child: Image.asset("assets/images/menu.png",color: primaryColor,height: 40,),
                      ),


                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
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
                                      child:  Icon(Icons.settings,color: primaryColor,)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),
                  ],
                ),
              ),
              Expanded(
                //height: MediaQuery.of(context).size.height*0.65,
                //width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(20)
                  ),

                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height*0.1,
              20,
              0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/person.png"),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Text("William Jones",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person,color: primaryColor,),
                    title: Text("Personal Info"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp,color: primaryColor,size: 15,),
                  ),
                ),

                SizedBox(height: 5,),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet,color: primaryColor,),
                    title: Text("Payment Ways"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp,color: primaryColor,size: 15,),
                  ),
                ),
                SizedBox(height: 5,),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    leading: Icon(Icons.reply,color: primaryColor,),
                    title: Text("Refer a friend"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp,color: primaryColor,size: 15,),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: (){


                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: drawerHeadGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vendor Subscription",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                                  Image.asset("assets/images/crown.png",height: 25,)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("\$4.99/month",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: (){
                                  //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Subscribe()));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(20,10,20,10),
                                  decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Text("SEE DETAILS",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color:Colors.white),),
                                ),
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      ),
                    )
                ),



              ],
            ),
          ),
        ],
      )
    );
  }
}
