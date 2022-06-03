import 'package:flutter/material.dart';
import 'package:hulace/widgets/custom_appbar.dart';

import '../../utils/constants.dart';

class SendProposal extends StatefulWidget {
  const SendProposal({Key? key}) : super(key: key);

  @override
  _SendProposalState createState() => _SendProposalState();
}

class _SendProposalState extends State<SendProposal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            CustomAppBar("Send Proposal"),
            SizedBox(height: 20,),
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
              value: false,
              title: Text("Are you available on required date",style: TextStyle(fontWeight: FontWeight.w300),),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value){

              },
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SendProposal()));

              },
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 50,

                alignment: Alignment.center,
                child: Text("Continue",style: TextStyle(color: Colors.white),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
