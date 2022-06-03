import 'package:flutter/material.dart';
import 'package:hulace/widgets/custom_appbar.dart';

class VendorAlerts extends StatefulWidget {
  const VendorAlerts({Key? key}) : super(key: key);

  @override
  _VendorAlertsState createState() => _VendorAlertsState();
}

class _VendorAlertsState extends State<VendorAlerts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("Alerts",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Text("Today",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Text("No Notifications",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
              ),
              SizedBox(height: 30,),
              Text("Earlier",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              SizedBox(height: 20,),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("2 min ago",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),)

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
