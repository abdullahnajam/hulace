import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/auth/login.dart';
import 'package:hulace/screens/get_started/register_as.dart';
import 'package:hulace/utils/constants.dart';

class GetStartedAuth extends StatefulWidget {
  const GetStartedAuth({Key? key}) : super(key: key);

  @override
  _GetStartedAuthState createState() => _GetStartedAuthState();
}

class _GetStartedAuthState extends State<GetStartedAuth> {
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
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login()));


                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.7,
                      alignment: Alignment.center,
                      child: Text("Sign In",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterAs()));


                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.7,
                      alignment: Alignment.center,
                      child: Text("Sign Up",style: TextStyle(color: primaryColor),),
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
