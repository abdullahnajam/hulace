import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/api/image_api.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/constants.dart';

class CreatePost extends StatefulWidget {
  String eventId;

  CreatePost(this.eventId);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String url="";
  var _titleController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future imageModalBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.cloud_upload),
                    title: const Text('Upload file'),
                    onTap: () => {
                      ImageHandler.chooseGallery().then((value) async{
                        if(value!=null){
                          print("not null");
                          String imageUrl=await ImageHandler.uploadImageToFirebase(context, value);
                          print("url path $imageUrl");
                          setState(() {
                            print(imageUrl);
                            url=imageUrl;
                          });

                        }
                        Navigator.pop(context);
                      })
                    }),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () => {
                    ImageHandler.chooseCamera().then((value) async{
                      if(value!=null){
                        String imageUrl=await ImageHandler.uploadImageToFirebase(context, value);
                        setState(() {
                          url=imageUrl;
                        });
                      }

                      Navigator.pop(context);
                    })
                  },
                ),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 50,left: 10,right: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                            elevation: 3,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child:  Icon(Icons.arrow_back,color: primaryColor,)
                            )
                        ),

                      ),
                    ),


                  ],
                ),
              ),


              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: bgColor,

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(10),
                    children: [
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        minLines: 6,
                        maxLines: 6,
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
                          hintText: 'Write post',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          print("url $url");
                          imageModalBottomSheet(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.25,
                          width: MediaQuery.of(context).size.width,

                          child: url==""?DottedBorder(
                              color: primaryColor,
                              strokeWidth: 1,
                              dashPattern: [7],
                              borderType: BorderType.Rect,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/upload.png",color: primaryColor,height: 50,width: 50,fit: BoxFit.cover,),
                                    SizedBox(height: 10,),
                                    Text("Upload Image",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w300),)
                                  ],
                                ),
                              )
                          ):Image.network(url,fit: BoxFit.cover,),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: ()async{
                          if(_formKey.currentState!.validate()){
                            final ProgressDialog pr = ProgressDialog(context: context);
                            pr.show(max: 100, msg: 'Please Wait');

                            await FirebaseFirestore.instance.collection('events').doc(widget.eventId).collection("posts").add({


                              "userId":FirebaseAuth.instance.currentUser!.uid,
                              "title":_titleController.text,
                              "status":"Active",
                              "url":url,
                              "packageId":"",
                              "timestamp":DateTime.now().millisecondsSinceEpoch,



                            }).then((val)async{
                              pr.close();
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Posted",
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
                          height: 45,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          alignment: Alignment.center,
                          child: Text("POST",style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
