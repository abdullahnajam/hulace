import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/vendor/send_proposal.dart';
import 'package:hulace/widgets/custom_appbar.dart';

import '../../utils/constants.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({Key? key}) : super(key: key);

  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              CustomAppBar("Job Detail"),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/person.png")
                        )
                    ),
                  ),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Need a Wedding Planner",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 15),),
                      Text("2 min ago",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),)
                    ],
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 30,),
              Text("Skills Needed",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              SizedBox(height: 10,),
              Wrap(
                spacing: 5,
                children: List.generate(
                  3,
                      (index) {
                    return FilterChip(
                      label: Text("Organizer",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(side: BorderSide(color: Colors.grey,width: 1)),
                      onSelected: (bool value) {print("selected");},
                    );
                  },
                ),
              ),
              SizedBox(height: 30,),
              Text("Budget and Date When Required",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.payments_outlined,size: 18,),
                  SizedBox(width: 3,),
                  Text("\$500",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                  SizedBox(width: 20,),
                  Icon(Icons.calendar_today_outlined,size: 18,),
                  SizedBox(width: 3,),
                  Text("18/05/2022",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),

                ],
              ),

              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SendProposal()));

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
        ),
      ),
    );
  }
}
