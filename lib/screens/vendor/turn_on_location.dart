import 'package:flutter/material.dart';
import 'package:hulace/utils/constants.dart';

import '../navigators/vendor_nav.dart';

class TurnOnLocation extends StatefulWidget {
  const TurnOnLocation({Key? key}) : super(key: key);

  @override
  _TurnOnLocationState createState() => _TurnOnLocationState();
}

class _TurnOnLocationState extends State<TurnOnLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/map.png",height: 200,),
              SizedBox(height: MediaQuery.of(context).size.height*0.15,),
              Text("Turn on your location so we can fetch your exact location",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 17),),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              InkWell(
                onTap: (){
                  print("tapped");
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VendorNavBar()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("Location On",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
