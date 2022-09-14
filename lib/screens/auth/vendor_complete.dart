import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/api/firebase_apis.dart';
import 'package:hulace/screens/navigators/vendor_nav.dart';
import 'package:hulace/screens/vendor/turn_on_location.dart';
import 'package:hulace/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../model/category_model.dart';
import '../../model/users.dart';
import '../../provider/UserDataProvider.dart';

class CompleteVendorAuth extends StatefulWidget {
  const CompleteVendorAuth({Key? key}) : super(key: key);

  @override
  _CompleteVendorAuthState createState() => _CompleteVendorAuthState();
}

class _CompleteVendorAuthState extends State<CompleteVendorAuth> {
  int currentStep=1;
  var _businessNameController=TextEditingController();
  var _ssmController=TextEditingController();
  String employeeCount="Individual";
  String selectedCategory="";
  List<String> employeeList=['Individual','<10','>6'];
  int selectedCategoryIndex=0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: StepProgressIndicator(
                totalSteps: 4,
                roundedEdges: Radius.circular(5),
                currentStep: currentStep,
                selectedColor: primaryColor,
                unselectedColor: Colors.grey,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  if(currentStep==1)
                    bussinessName()
                  else if(currentStep==2)
                    employees()
                  else if(currentStep==3)
                    ssn()
                  else if(currentStep==4)
                    category()

                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                currentStep>1?Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      if(currentStep>1){
                        setState(() {
                          currentStep--;
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],

                      ),
                      child: Icon(Icons.arrow_back,color: Colors.grey[600],size: 20,),
                    ),
                  ),
                ):Container(),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: InkWell(
                    onTap: ()async{
                      if(currentStep<4){
                        setState(() {
                          currentStep++;
                        });
                      }
                      else{
                        final ProgressDialog pr = ProgressDialog(context: context);
                        pr.show(max: 100, msg: 'Please Wait');
                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                          "businessName":_businessNameController.text,
                          "employeeCount":employeeCount,
                          "businessCategory":selectedCategory,
                          "ssm":_ssmController.text,
                        }).then((val)async{
                          pr.close();
                          final provider = Provider.of<UserDataProvider>(context, listen: false);
                          provider.userData!.employeeCount=employeeCount;
                          provider.userData!.businessName=_businessNameController.text;
                          provider.userData!.businessCategory=selectedCategory;
                          provider.userData!.ssm=_ssmController.text;

                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VendorNavBar()));




                        }).onError((error, stackTrace){
                          pr.close();
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: error.toString(),
                          );
                        });

                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: 50,

                      alignment: Alignment.center,
                      child: Text("Continue",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
  Widget bussinessName(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text("What is the name of your Business?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          Text("You can choose whether name you want. Well’ keep it between you and us.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16,color: Colors.grey),),
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _businessNameController,
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
              hintText: 'Enter the name here',
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),

        ],
      ),
    );
  }
  Widget employees(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text("How many employees in your Business?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          Text("Select the number of people you have employed in your business.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16,color: Colors.grey),),
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          InkWell(
            onTap: (){
              setState(() {
                employeeCount=employeeList[0];
              });
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: employeeCount==employeeList[0]?primaryColor:Colors.grey[200],
                borderRadius: BorderRadius.circular(7)
              ),
              child: Text(employeeList[0],style: TextStyle(color: employeeCount==employeeList[0]?Colors.white:Colors.grey[600],fontSize: 17),),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              setState(() {
                employeeCount=employeeList[1];
              });
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: employeeCount==employeeList[1]?primaryColor:Colors.grey[200],
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Text(employeeList[1],style: TextStyle(color: employeeCount==employeeList[1]?Colors.white:Colors.grey[600],fontSize: 17),),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              setState(() {
                employeeCount=employeeList[2];
              });
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: employeeCount==employeeList[2]?primaryColor:Colors.grey[200],
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Text(employeeList[2],style: TextStyle(color: employeeCount==employeeList[2]?Colors.white:Colors.grey[600],fontSize: 17),),
            ),
          ),
          SizedBox(height: 10,),


        ],
      ),
    );
  }
  Widget ssn(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text("What is your SSM Number?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          Text("Enter SSM number of your business here.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16,color: Colors.grey),),
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _ssmController,
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
              hintText: 'SSM Number goes here',
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),

        ],
      ),
    );
  }
  Widget category(){
    return Column(
      children: [
        SizedBox(height: 10,),
        Text("Choose your Business Category",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),

        Container(
          height: MediaQuery.of(context).size.height*0.7,
          child: FutureBuilder<List<CategoryModel>>(
              future: getServices(),
              builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: Text("-",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300)),
                  );
                }
                else {
                  if (snapshot.hasError) {
                    print("error ${snapshot.error}");
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  else if(snapshot.data!.isEmpty){
                    return const Center(
                      child: Text("No Services"),
                    );
                  }

                  else {

                    /*return Wrap(
                      spacing: 5,
                      children: List.generate(
                        snapshot.data!.length,
                            (index) {
                          return FilterChip(
                            label: Text(snapshot.data![index].name,style: TextStyle(color: selectedCategoryIndex==index?Colors.white:Colors.black,),),
                            backgroundColor: selectedCategoryIndex==index?primaryColor:Colors.white,

                            onSelected: (bool value) {
                              setState(() {
                                selectedCategoryIndex=index;
                                selectedCategory=snapshot.data![index].name;
                              });
                            },
                          );
                        },
                      ),
                    );*/

                    return GridView.builder(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(

                            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.0),
                            crossAxisSpacing: 10,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCategoryIndex=index;
                                  selectedCategory=snapshot.data![index].name;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedCategoryIndex==index?Colors.grey[400]:Colors.grey[200]
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /*Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: primaryColor,width: 2),
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot.data![index].image),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),*/
                                    Text(snapshot.data![index].name,textAlign: TextAlign.center,style: TextStyle(fontSize:14,fontWeight: FontWeight.w400),),

                                  ],
                                ),
                              )
                          );
                        }
                    );
                  }
                }
              }
          ),

        )
      ],
    );
  }
}
