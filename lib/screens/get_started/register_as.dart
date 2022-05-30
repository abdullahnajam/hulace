import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/auth/register.dart';
import 'package:hulace/utils/constants.dart';

class RegisterAs extends StatefulWidget {
  const RegisterAs({Key? key}) : super(key: key);

  @override
  _RegisterAsState createState() => _RegisterAsState();
}

class _RegisterAsState extends State<RegisterAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.6,
              child: Image.asset("assets/images/logo.png",width: 250,height: 250,color: primaryColor,),
            ),
            Expanded(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Register()));


                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.7,
                      alignment: Alignment.center,
                      child: Text("Sign Up As User",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Register()));


                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.7,
                      alignment: Alignment.center,
                      child: Text("Sign Up As Vendor",style: TextStyle(color: primaryColor),),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
