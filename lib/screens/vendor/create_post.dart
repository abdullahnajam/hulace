import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hulace/api/image_api.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../model/package_model.dart';
import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';

class VendorPost extends StatefulWidget {
  String eventId;

  VendorPost(this.eventId);

  @override
  _VendorPostState createState() => _VendorPostState();
}

class _VendorPostState extends State<VendorPost> {
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
    final provider = Provider.of<UserDataProvider>(context, listen: false);

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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //padding: EdgeInsets.all(10),
                    children: [
                      Text("Select a package that you want to post",style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(height: 4,),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('packages')
                              .where("userId",isEqualTo: provider.userData!.userId).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.data!.size==0) {
                              return Center(
                                child: Text("No Packages"),
                              );
                            }

                            return ListView(
                              padding: EdgeInsets.only(top: 10),

                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                PackageModel model=PackageModel.fromMap(data,document.reference.id);
                                return Card(
                                  margin: EdgeInsets.only(bottom: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                          children:[
                                            Container(
                                              height: MediaQuery.of(context).size.height*0.2,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10),
                                                  ),
                                                  image: DecorationImage(
                                                      image: NetworkImage(model.image,),
                                                      fit: BoxFit.cover
                                                  )

                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text("KM${model.budget}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
                                              ),
                                            ),
                                          ]
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 5,top: 5),
                                        child: Text(model.title,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(model.description,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.w400),),
                                      ),

                                      InkWell(
                                        onTap:()async{
                                          final ProgressDialog pr = ProgressDialog(context: context);
                                          pr.show(max: 100, msg: 'Please Wait');

                                          await FirebaseFirestore.instance.collection('events').doc(widget.eventId).collection("posts").add({


                                            "userId":FirebaseAuth.instance.currentUser!.uid,
                                            "title":model.title,
                                            "status":"Active",
                                            "url":model.image,
                                            "packageId":model.id,
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
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              )
                                          ),
                                          alignment: Alignment.center,
                                          child: Text("Post",style: TextStyle(color: Colors.white),),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
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
