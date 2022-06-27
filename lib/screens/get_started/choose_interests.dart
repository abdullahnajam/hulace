import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/customer_homepage.dart';
import 'package:hulace/screens/navigators/customer_nav.dart';

import '../../utils/constants.dart';

class ChooseInterests extends StatefulWidget {
  const ChooseInterests({Key? key}) : super(key: key);

  @override
  _ChooseInterestsState createState() => _ChooseInterestsState();
}

class _ChooseInterestsState extends State<ChooseInterests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Choose what kind of events\nyou are interested",textAlign: TextAlign.center,style: TextStyle(fontSize:20,fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    Text("It helps us to personalize your homepage\non the basis of your interests",textAlign: TextAlign.center,style: TextStyle(fontSize:14,fontWeight: FontWeight.w300),),

                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: GridView.builder(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(

                        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.2),
                        crossAxisSpacing: 10,
                        crossAxisCount: 3,
                        mainAxisSpacing: 10
                    ),
                    itemCount: 12,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: primaryColor,width: 2),
                                    image: DecorationImage(
                                        image: AssetImage("assets/images/event.png"),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Event",textAlign: TextAlign.center,style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),),

                          ],
                        )
                      );
                    }
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CustomerNavBar()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("Continue",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
