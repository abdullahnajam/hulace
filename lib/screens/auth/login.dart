import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hulace/api/firebase_apis.dart';
import 'package:hulace/screens/auth/register.dart';
import 'package:hulace/screens/auth/vendor_complete.dart';
import 'package:hulace/screens/get_started/register_as.dart';
import 'package:hulace/screens/navigators/vendor_nav.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../model/users.dart';
import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';
import '../navigators/customer_nav.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset("assets/images/icon.png",width: 50,height: 50,),
                      ),
                      SizedBox(height: 10,),
                      Text("Welcome to Hulace",textAlign: TextAlign.center,style: TextStyle(fontSize:22,fontWeight: FontWeight.w400),),
                      SizedBox(height: 5,),
                      //Text("To Hulace platform",textAlign: TextAlign.center,style: TextStyle(fontSize:14,fontWeight: FontWeight.w300),),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter Email',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter Password',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));

                            },
                            child: Text("Forgot Password?",style: TextStyle(fontSize:14,fontWeight: FontWeight.w400),),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: ()async{
                          if(_formKey.currentState!.validate()){
                            final ProgressDialog pr = ProgressDialog(context: context);
                            pr.show(max: 100, msg: 'Logging In');
                            try{
                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text
                              );
                              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot documentSnapshot) async{
                                if (documentSnapshot.exists) {
                                  pr.close();
                                  Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
                                  UserModel user=UserModel.fromMap(data,documentSnapshot.reference.id);
                                  if(user.status=="Pending"){
                                    FirebaseAuth.instance.signOut();
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.info,
                                      text: "Your account is pending for approval from admin",
                                    );
                                  }
                                  else if(user.status=="Blocked"){
                                    FirebaseAuth.instance.signOut();
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      text: "Your account is blocked by admin",
                                    );
                                  }

                                  else if(user.status=="Approved"){
                                    String? token="";
                                    FirebaseMessaging _fcm=FirebaseMessaging.instance;
                                    token=await _fcm.getToken();
                                    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                                      "token":token,
                                    });
                                    final provider = Provider.of<UserDataProvider>(context, listen: false);
                                    provider.setUserData(user);
                                    print("user type ${user.type}");
                                    if(user.type=="Customer")
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CustomerNavBar()));
                                    else
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => VendorNavBar()));

                                  }
                                }
                                else{
                                  pr.close();
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: "No User Data",
                                  );
                                }
                              });
                            }

                            on FirebaseAuthException catch  (e) {
                              print('Failed with error code: ${e.code}');
                              print(e.message);
                              pr.close();
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: getMessageFromErrorCode(e.code),
                              );
                            }

                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 50,
                          alignment: Alignment.center,
                          child: Text("Sign In",style: TextStyle(color: Colors.white),),
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height:20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Not have an account?",style: TextStyle(fontSize:14,fontWeight: FontWeight.w400),),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterAs()));

                            },
                            child: Text("  Sign Up",style: TextStyle(fontSize:15,fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("OR",style: TextStyle(fontSize:17,fontWeight: FontWeight.w500),),
                      SizedBox(height: 10,),
                      Text("Sign in with",style: TextStyle(fontSize:15,fontWeight: FontWeight.w300),),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: ()async{
                              try{
                                UserCredential _userCredential= await signInWithGoogle();
                                await FirebaseFirestore.instance.collection('users').doc(_userCredential.user!.uid).get().then((DocumentSnapshot documentSnapshot) async{
                                  if (documentSnapshot.exists) {
                                    Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
                                    UserModel user=UserModel.fromMap(data,documentSnapshot.reference.id);
                                    if(user.status=="Pending"){
                                      FirebaseAuth.instance.signOut();
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.info,
                                        text: "Your account is pending for approval from admin",
                                      );
                                    }
                                    else if(user.status=="Blocked"){
                                      FirebaseAuth.instance.signOut();
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: "Your account is blocked by admin",
                                      );
                                    }

                                    else if(user.status=="Approved"){
                                      String? token="";
                                      FirebaseMessaging _fcm=FirebaseMessaging.instance;
                                      token=await _fcm.getToken();
                                      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                                        "token":token,
                                      });
                                      final provider = Provider.of<UserDataProvider>(context, listen: false);
                                      provider.setUserData(user);
                                      print("user type ${user.type}");
                                      if(user.type=="Customer")
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CustomerNavBar()));
                                      else
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => VendorNavBar()));

                                    }
                                  }
                                  else{
                                    String? token="";
                                    FirebaseMessaging _fcm=FirebaseMessaging.instance;
                                    token=await _fcm.getToken();
                                    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                      "type":"Customer",
                                      "email":_userCredential.user!.email,
                                      "password":"",
                                      "balance":0,
                                      "status":"Approved",
                                      "token":token,
                                      "firstName":_userCredential.user!.displayName,
                                      "lastName":"",
                                      "city":"Not Set",
                                      "location":"Not Set",
                                      "country":"Not Set",
                                      "createdAt":DateTime.now().millisecondsSinceEpoch,
                                      "businessName":"",
                                      "employeeCount":"",
                                      "businessCategory":"",
                                      "ssm":"",
                                      "profilePic":"",
                                    });
                                    final provider = Provider.of<UserDataProvider>(context, listen: false);
                                    UserModel user=new UserModel.fromMap(
                                        {
                                          "type":"Customer",
                                          "balance":0,
                                          "email":_userCredential.user!.email,
                                          "password":"",
                                          "status":"Approved",
                                          "token":token,
                                          "firstName":_userCredential.user!.displayName,
                                          "lastName":"",
                                          "city":"Not Set",
                                          "location":"Not Set",
                                          "country":"Not Set",
                                          "favouriteVendors":[],
                                          "createdAt":DateTime.now().millisecondsSinceEpoch,
                                          "businessName":"",
                                          "employeeCount":"",
                                          "businessCategory":"",
                                          "ssm":"",
                                          "profilePic":"",
                                        },
                                        FirebaseAuth.instance.currentUser!.uid
                                    );


                                    provider.setUserData(user);
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CustomerNavBar()));
                                    /*if(widget.type=="Customer"){
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CustomerNavBar()));
                                    }
                                    else{
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CompleteVendorAuth()));
                                    }*/
                                  }
                                });
                              }
                              on FirebaseAuthException catch  (e) {
                                print('Failed with error code: ${e.code}');
                                print(e.message);
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: getMessageFromErrorCode(e.code),
                                );
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey.shade300)
                              ),
                              height: 50,
                              alignment: Alignment.center,
                              child: Image.asset("assets/images/google.png",height: 30,)
                            ),
                          ),
                          InkWell(
                            onTap: (){

                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width*0.45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey.shade300)
                                ),
                                height: 50,
                                alignment: Alignment.center,
                                child: Image.asset("assets/images/facebook.png",height: 30,)
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
