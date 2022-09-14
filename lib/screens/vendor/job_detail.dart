import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hulace/api/payment_service.dart';
import 'package:hulace/screens/vendor/send_proposal.dart';
import 'package:hulace/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../model/request_model.dart';
import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';

class JobDetail extends StatefulWidget {
  RequestModel request;

  JobDetail(this.request);

  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  var _coverLetterController=TextEditingController();
  var _offeredController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool available=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                        Text(widget.request.title,style: TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 15),),
                        Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.request.createdAt)),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),)
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  widget.request.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),

                SizedBox(height: 30,),
                Text("Budget and Date When Required",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.payments_outlined,size: 18,),
                    SizedBox(width: 3,),
                    Text("\$${widget.request.budget}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                    SizedBox(width: 20,),
                    Icon(Icons.calendar_today_outlined,size: 18,),
                    SizedBox(width: 3,),
                    Text(widget.request.date,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),

                  ],
                ),

                SizedBox(height: 30,),
                Text("Cover Letter",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                SizedBox(height: 10,),
                Text(
                  "Introduce yourself and your abilities to handle the required event management program",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _coverLetterController,
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
                    hintText: '',
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: 20,),
                Text("Your Offered Budget",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _offeredController,
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
                    hintText: '',
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: 20,),
                CheckboxListTile(
                  value: available,
                  title: Text("Are you available on required date",style: TextStyle(fontWeight: FontWeight.w300),),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value){
                    setState(() {
                      available=value!;
                    });
                  },
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: ()async{
                    if(_formKey.currentState!.validate()){
                      final ProgressDialog pr = ProgressDialog(context: context);
                      pr.show(max: 100, msg: 'Please Wait');

                      await FirebaseFirestore.instance.collection('proposals').add({
                        "requestId":widget.request.id,
                        "customerId":widget.request.userId,
                        "availability":available,
                        "vendorId":FirebaseAuth.instance.currentUser!.uid,
                        "cover":_coverLetterController.text,
                        "cost":_offeredController.text,
                        "status":"Active",
                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                      }).then((val)async{
                        PaymentService payment=PaymentService();
                        payment.payment(_offeredController.text);
                        pr.close();
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Proposal Submitted",
                            onConfirmBtnTap: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                        );





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
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 50,

                    alignment: Alignment.center,
                    child: Text("Submit",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
