import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/get_started/getstarted_auth.dart';
import 'package:hulace/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with WidgetsBindingObserver{
  final PageController _pageController = PageController();
  final PageController _page2Controller = PageController();
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height*0.6,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.6,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: 2,
                    itemBuilder: (context, position){
                      return Container(

                        child: Image.asset(index==0?"assets/images/onboard1.png":"assets/images/onboard2.png",fit: BoxFit.cover,),
                      );
                    },

                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        child: SmoothPageIndicator(
                            controller: _pageController,
                            count:  2,

                            effect:  ExpandingDotsEffect(dotWidth: 7,dotHeight: 7,activeDotColor: primaryColor),
                            onDotClicked: (index){

                            }
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: _page2Controller,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, position){
                            return Column(
                              children: [
                                Container(
                                  child: Text(index==0?"Finding vendors for events\nis became easy.":"Instantly chat with vendors\nand book events.",textAlign: TextAlign.center,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.02,
                                ),
                                Container(
                                  child: Text("Lorem ipsum dolor sit amet, consectetur\nadipiscing elit leo felis congue elit leo.",textAlign: TextAlign.center,style: TextStyle(fontSize:13,fontWeight: FontWeight.w300,color: Colors.grey),),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.08,
                                ),
                                InkWell(
                                  onTap: (){
                                    if(index==0){
                                      setState(() {
                                        index++;
                                      });
                                      _page2Controller.animateToPage(index,duration: Duration(milliseconds: 500), curve: Curves.ease);
                                      _pageController.animateToPage(index,duration: Duration(milliseconds: 500), curve: Curves.ease);
                                    }
                                    else{
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GetStartedAuth()));
                                    }


                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*0.5,
                                    alignment: Alignment.center,
                                    child: Text(index==0?"Continue":"Get Started",style: TextStyle(color: Colors.white),),
                                  ),
                                )

                              ],
                            );
                          },

                        ),
                      ),



                    ],
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
