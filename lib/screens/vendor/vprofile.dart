import 'package:flutter/material.dart';
import 'package:hulace/widgets/custom_appbar.dart';

import '../../utils/constants.dart';

class VProfile extends StatefulWidget {
  const VProfile({Key? key}) : super(key: key);

  @override
  _VProfileState createState() => _VProfileState();
}

class _VProfileState extends State<VProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 10,),
              CustomAppBar("Profile"),
              Container(
                width: 100,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/person.png")
                            )
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 0,
                      child: Container(

                        decoration: BoxDecoration(
                          color: Colors.white,
                            border: Border.all(color: primaryColor),
                            shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.edit,color: Colors.grey,size: 15,),
                      ),
                    )
                  ],
                ),

              ),
              Text("William Jones",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Description",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                  Icon(Icons.edit)
                ],
              ),
              SizedBox(height: 20,),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Portfolio",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                  Row(
                    children: [
                      Text("Edit",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                      SizedBox(width: 5,),
                      Icon(Icons.add_circle_outline),
                    ],
                  )
                ],
              ),
              Container(
                height: 120,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context,int index){
                    return  Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage("assets/images/event.png"),
                            fit: BoxFit.cover
                          )
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Text("Reviews",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    height: 60,
                    width: 60,
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
                              Text("Engagment Event Planner",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                              Row(
                                children: [
                                  Icon(Icons.star,size: 18,),
                                  Text("5",style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac sit euismod elementum amet et nisl entesque quam odio eu id ac elementum",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 12),),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),

                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Skills",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                  Icon(Icons.edit)
                ],
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
