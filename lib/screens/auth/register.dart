import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hulace/screens/auth/vendor_complete.dart';
import 'package:hulace/screens/navigators/customer_nav.dart';
import 'package:hulace/screens/get_started/choose_interests.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../model/users.dart';
import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';
import '../../utils/location.dart';

class Register extends StatefulWidget {
  String type;

  Register(this.type);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  var _firstNameController=TextEditingController();
  var _lastNameController=TextEditingController();
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();
  var _ageController=TextEditingController();
  var _locationController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String city="";
  String country="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
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
                      Text("Sign up as ${widget.type} ",textAlign: TextAlign.center,style: TextStyle(fontSize:22,fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: _firstNameController,
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
                                  hintText: 'First Name',
                                  // If  you are using latest version of flutter then lable text and hint text shown like this
                                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: _lastNameController,
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
                                  hintText: 'Last Name',
                                  // If  you are using latest version of flutter then lable text and hint text shown like this
                                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
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
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: ()async{
                          List coordinates=await getUserCurrentCoordinates();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: kGoogleApiKey,
                                onPlacePicked: (result) {
                                  for(int i=0;i<result.addressComponents!.length;i++){
                                    print("addresss comp index:$i ${result.addressComponents![i].longName}");
                                  }
                                  result.addressComponents!.forEach((element) {print("herereee ${element.longName}");});
                                  print(result.addressComponents!.length);
                                  _locationController.text=result.formattedAddress!;
                                  city=result.addressComponents![2].longName;
                                  country=result.addressComponents![6].longName;
                                  Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(coordinates[0], coordinates[1]),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        controller: _locationController,
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
                          hintText: 'Enter Address',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: ()async{

                          if(_formKey.currentState!.validate()){
                            final ProgressDialog pr = ProgressDialog(context: context);
                            pr.show(max: 100, msg: 'Please Wait');
                            try{
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );
                              String? token="";
                              FirebaseMessaging _fcm=FirebaseMessaging.instance;
                              token=await _fcm.getToken();
                              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                "type":widget.type,
                                "email":_emailController.text,
                                "password":_passwordController.text,
                                "balance":0,
                                "status":"Approved",
                                "token":token,
                                "firstName":_firstNameController.text,
                                "lastName":_lastNameController.text,
                                "city":city,
                                "location":_locationController.text,
                                "country":country,
                                "createdAt":DateTime.now().millisecondsSinceEpoch,
                                "businessName":"",
                                "employeeCount":"",
                                "businessCategory":"",
                                "ssm":"",
                                "profilePic":"",
                              }).then((val)async{
                                pr.close();
                                final provider = Provider.of<UserDataProvider>(context, listen: false);
                                UserModel user=new UserModel.fromMap(
                                    {
                                      "type":widget.type,
                                      "balance":0,
                                      "email":_emailController.text,
                                      "password":_passwordController.text,
                                      "status":"Approved",
                                      "token":token,
                                      "firstName":_firstNameController.text,
                                      "lastName":_lastNameController.text,
                                      "city":city,
                                      "location":_locationController.text,
                                      "country":country,
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
                                if(widget.type=="Customer"){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CustomerNavBar()));
                                }
                                else{
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CompleteVendorAuth()));
                                }




                              }).onError((error, stackTrace){
                                pr.close();
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: error.toString(),
                                );
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
                          child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                        ),
                      ),
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
