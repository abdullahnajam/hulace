import 'package:flutter/material.dart';
import 'package:hulace/screens/vendor/turn_on_location.dart';
import 'package:hulace/utils/constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RegisterVendor extends StatefulWidget {
  const RegisterVendor({Key? key}) : super(key: key);

  @override
  _RegisterVendorState createState() => _RegisterVendorState();
}

class _RegisterVendorState extends State<RegisterVendor> {
  int currentStep=1;
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
                Expanded(
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
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: InkWell(
                    onTap: (){
                      if(currentStep<4){
                        setState(() {
                          currentStep++;
                        });
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TurnOnLocation()));
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
          TextFormField(
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
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
              hintText: 'Individual',
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
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
              hintText: '<10',
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
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
              hintText: '>6',
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),

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
          child: GridView.builder(
            shrinkWrap: true,
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
        )
      ],
    );
  }
}
