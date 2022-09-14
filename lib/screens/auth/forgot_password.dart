import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';
import 'new_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);


  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {


  var _emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.all(10),
              color: primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: bgColor,)
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text ('Forgot Password',style: TextStyle(
                      color: bgColor,
                      fontSize: 18
                    ),),
                  ),
                ],
              ),
            ),
            // Main Container of Screen
            Expanded(
              flex: 8,
              child: Container(
                  decoration: BoxDecoration(color: bgColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      const Center(
                        child: Text("Forgot Password", style: TextStyle(
                          color: primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                      const SizedBox(height: 10,),
                      const Center(
                        child: Text("Write the email you registered with and we will\nsend you a link to reset your password", textAlign: TextAlign.center,style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                        ),),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          fillColor: bgColor,
                          filled: true,

                        ),
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: InkWell(
                          onTap: ()async{
                            FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((value){
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "An email has been sent for password reset",
                              );
                            }).onError((error, stackTrace){

                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: error.toString(),
                              );
                            });
                            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const NewPassword()));
                          },
                          child: Container(
                            height: 40,
                            width: width*0.5,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: const Text("RESET PASSWORD",style: TextStyle(fontSize:16,color: bgColor),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ],
        ),

      ),
    );
  }
}
